//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol"; 

contract DPAIAirdrop is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable,
    PausableUpgradeable
{
    using BitMaps for BitMaps.BitMap;

    error AlreadyClaimed(address claimer);
    error InvalidProof();
    error CannotTransfer(address target, uint256 amount);

    bool private _isInitialized;
    bytes32 public root;
    address public token;
    BitMaps.BitMap private given;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() payable {
        _disableInitializers();
    }

    function initialize(
        address owner_,
        bytes32 root_,
        address token_
    ) public initializer {
        if (_isInitialized) return;
        __Ownable_init(owner_);
        _isInitialized = true;
        __UUPSUpgradeable_init();
        __Pausable_init();
        root = root_;
        token = token_;
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

    function setToken(address newToken) external onlyOwner {
        token = newToken;
    }

    function setRoot(bytes32 newRoot) external onlyOwner {
        root = newRoot;
    }

    function claim(
        bytes32[] memory proof,
        address addr,
        uint256 amount
    ) public {
        uint256 userId = uint256(uint160(addr));
        if (given.get(userId)) revert AlreadyClaimed(addr);
        bytes32 leaf = keccak256(
            bytes.concat(keccak256(abi.encode(addr, amount)))
        );
        if (!MerkleProof.verify(proof, root, leaf)) revert InvalidProof(); 
        given.set(userId);
        if (!IERC20(token).transfer(addr, amount))
            revert CannotTransfer(addr, amount); 
    }

    function unset(address addr) external onlyOwner {
        uint256 userId = uint256(uint160(addr));
         given.unset(userId);
    }
}
