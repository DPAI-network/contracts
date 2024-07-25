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

contract DPAIElections is
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
    error NotPermittedTime();
    error IndexOutOfRange(uint256 i);

    bool private _isInitialized;
    bytes32 public root;
    uint256 public beginTime;
    uint256 public endTime;
    uint256 public winnersCount;
    mapping(address => uint256) public votes;
    EnumerableMap.UintToAddressMap private addresses;
    EnumerableMap.AddressToUintMap private votedTarget;
    BitMaps.BitMap private voted;
    mapping(address => string) public names;

    modifier whenVotable() {
        if (block.timestamp < beginTime || block.timestamp > endTime)
            revert NotPermittedTime();
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function initialize(address owner_) public initializer {
        if (_isInitialized) return;
        _isInitialized = true;
        __Ownable_init(owner_);
        __UUPSUpgradeable_init();
        __Pausable_init();
        __ReentrancyGuard_init();
    }

    function setRoot(bytes32 newRoot) external onlyOwner {
        root = newRoot;
    }

    function vote(
        uint256 amount,
        bytes32[] memory proof,
        address voteFor
    ) external whenNotPaused whenVotable {
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

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function setBeginTime(uint256 newTime) external onlyOwner {
        beginTime = newTime;
    }

    function setEndTime(uint256 newTime) external onlyOwner {
        endTime = newTime;
    }

    function setWinnersCount(uint256 newWinnersCount) external onlyOwner {
        winnersCount = newWinnersCount;
    }

    function length() external view returns (uint256) {
        return addresses.length();
    }

    function get(uint256 i) external view returns (address) {
        if (i >= addresses.length()) revert IndexOutOfRange(i);
        return addresses.get(i);
    }

    function unvote(
        uint256 amount,
        bytes32[] memory proof
    ) external whenNotPaused whenVotable {
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

    function getwinners() external view returns (address[] memory result) {
        uint256 max;
        uint256 pos;
        uint256[] memory amounts;
        address ta;
        uint256 i;
        uint256 j;
        for (i = 0; i < winnersCount && i < addresses.length(); i++) {
            result[i] = addresses.get(i);
            amounts[i] = votes[result[i]];
        }
        for (i = 0; i < winnersCount - 1 && i < addresses.length() - 1; i++) {
            for (j = i + 1; j < winnersCount && j < addresses.length(); j++) {
                if (amounts[j] > amounts[i]) {
                    ta = result[j];
                    result[j] = result[i];
                    result[i] = ta;
                    max = amounts[j];
                    amounts[j] = amounts[i];
                    amounts[i] = max;
                }
            }
        }
        if (addresses.length() >= winnersCount) return result;
        for (i = winnersCount; i < addresses.length(); i++) {
            ta = addresses.get(i);
            if (votes[ta] <= amounts[winnersCount - 1]) {
                continue;
            }
            if (votes[ta] >= amounts[0]) {
                for (j = 1; j < winnersCount; j++) {
                    amounts[j] = amounts[j - 1];
                    result[j] = result[j - 1];
                }
                amounts[0] = votes[ta];
                result[0] = ta;
                continue;
            }
            pos = winnersCount - 1;
            for (j = winnersCount - 2; j > 0; j--) {
                if (votes[ta] > amounts[j]) pos = j;
            }
            for (j = pos + 1; j < winnersCount; j++) {
                amounts[j] = amounts[j - 1];
                result[j] = result[j - 1];
            }

            amounts[pos] = votes[ta];
            result[pos] = ta;
        }
    }
}



