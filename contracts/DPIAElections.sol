//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import {PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

contract DPIAElections is
    Initializable,
    UUPSUpgradeable,
    OwnableUpgradeable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable
{
    using BitMaps for BitMaps.BitMap;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    using EnumerableMap for EnumerableMap.AddressToUintMap;
    error WrongMerkleProof(address sender, uint256 amount);
    error AlreadyVoted(address sender);
    error NotVoted(address sender);

    bool private _isInitialized;
    bytes32 public root;
    mapping(address => uint256) public votes;
    EnumerableMap.UintToAddressMap private addresses;
    EnumerableMap.AddressToUintMap private votedTarget;
    BitMaps.BitMap private voted;
    mapping(address => string) public names;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function initialize(address owner_) public initializer {
        if (_isInitialized) return;
        __Ownable_init(owner_);
        __UUPSUpgradeable_init();
        __Pausable_init();
        __ReentrancyGuard_init();
        _isInitialized = true;
    }

    function setRoot(bytes32 newRoot) external onlyOwner {
        root = newRoot;
    }

    function vote(
        uint256 amount,
        bytes32[] memory proof,
        address voteFor
    ) external {
        bytes32 leaf = keccak256(abi.encode(msg.sender, amount));
        if (!MerkleProof.verify(proof, root, leaf))
            revert WrongMerkleProof(msg.sender, amount);
        uint256 userId = uint256(uint160(msg.sender));
        if (voted.get(userId)) revert AlreadyVoted(msg.sender);
        voted.set(userId);
        votes[voteFor] = votes[voteFor] + amount;
        uint256 i;
        for (i = 0; i < addresses.length(); i++) {
            if (addresses.get(i) == voteFor) {
                votedTarget.set(msg.sender, i);
                return;
            }
        }
        addresses.set(i, voteFor);
        votedTarget.set(msg.sender, i);
    }

    function length() external view returns (uint256) {
        return addresses.length();
    }

    function get(uint256 i) external view returns (address) {
        return addresses.get(i);
    }

    function unvote(uint256 amount, bytes32[] memory proof) external {
        bytes32 leaf = keccak256(abi.encode(msg.sender, amount));
        if (!MerkleProof.verify(proof, root, leaf))
            revert WrongMerkleProof(msg.sender, amount);
        uint256 userId = uint256(uint160(msg.sender));
        if (!voted.get(userId)) revert NotVoted(msg.sender);
        address voteFor = addresses.get(votedTarget.get(msg.sender));
        votes[voteFor] = votes[voteFor] - amount;
        voted.unset(userId);
        votedTarget.remove(msg.sender);
    }
}
