//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {console} from "forge-std/console.sol";
import "./IDPAIStaking.sol";

contract DPAIStaking is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable,
    PausableUpgradeable,
    IDPAIStaking
{
    bool private _isInitialized;
    address public token;
    mapping(address => Staked[]) public staked;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() payable {
        _disableInitializers();
    }

    function initialize(address owner_, address token_) public initializer {
        if (_isInitialized) return;
        __Ownable_init(owner_);
        _isInitialized = true;
        token = token_;
        __UUPSUpgradeable_init();
        __Pausable_init();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function setToken(address newToken) public onlyOwner {
        token = newToken;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function stake(
        uint256 amount,
        uint256 cliff,
        uint256 duration,
        address recipient
    ) external override {
        if (recipient == address(0)) revert ZeroAddress();
        if (amount == 0) revert ZeroAmount();
        if (duration == 0) revert ZeroDuration();
        if (msg.sender != owner()) {
            IERC20(token).transferFrom(msg.sender, address(this), amount);
        }
        staked[recipient].push(
            Staked(amount, cliff + block.timestamp, duration)
        );
    }

    function clearStaking(address recipient) external override {
        delete staked[recipient];
    }

    function stake(
        uint256 cliff,
        uint256 duration,
        StakeMultiple[] memory staked_
    ) external override onlyOwner {
        if (cliff == 0) revert ZeroCliff();
        if (duration == 0) revert ZeroDuration();
        for (uint i = 0; i < staked_.length; i++) {
            if (staked_[i].recipient == address(0)) revert ZeroAddress();
            if (staked_[i].amount == 0) revert ZeroAmount();
            staked[staked_[i].recipient].push(
                Staked(staked_[i].amount, cliff+block.timestamp, duration)
            );
        }
    }

    function stakedAmount(
        address recipient
    ) external view override returns (uint256) {
        uint ln = staked[recipient].length;
        uint sum = 0;
        uint lockedNow;
        if (ln == 0) return 0;
        for (uint i = 0; i < ln; i++) {
            lockedNow = staked[recipient][i].amountLocked;
            if (block.timestamp < staked[recipient][i].cliff) {
                sum += lockedNow;
                continue;
            }
            if (
                staked[recipient][i].cliff < block.timestamp &&
                block.timestamp <
                staked[recipient][i].cliff + staked[recipient][i].duration
            ) {
                sum +=
                    lockedNow -
                    ((lockedNow *
                        (block.timestamp - staked[recipient][i].cliff)) /
                        staked[recipient][i].duration);
            }
        }
        return sum;
    }

    function vestedAmount(
        address recipient
    ) external view override returns (uint256) {
        uint ln = staked[recipient].length;
        uint sum = 0;
        uint lockedNow;
        if (ln == 0) return 0;
        for (uint i = 0; i < ln; i++) {
            lockedNow = staked[recipient][i].amountLocked;
            if (block.timestamp < staked[recipient][i].cliff) {
                continue;
            }
            if (
                block.timestamp >=
                staked[recipient][i].cliff + staked[recipient][i].duration
            ) {
                sum += lockedNow;
                continue;
            }
            if (
                staked[recipient][i].cliff < block.timestamp &&
                block.timestamp <
                staked[recipient][i].cliff + staked[recipient][i].duration
            ) {
                sum +=
                    (lockedNow *
                        (block.timestamp - staked[recipient][i].cliff)) /
                    staked[recipient][i].duration;
            }
        }
        return sum;
    }
}
