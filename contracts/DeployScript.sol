// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol"; // solhint-disable
import {console} from "forge-std/console.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {stdJson} from "forge-std/StdJson.sol";
import "@openzeppelin/contracts/utils/Create2.sol";


abstract contract DeployScript is Script {
    uint256 public immutable privateKey;
    address public implementation;
    bytes public data;
    bytes32 private _salt;
    bytes public initialize;
    string private _contractName;
    address public proxyAddress;

    error InvalidAddress(string reason);

    modifier create() {
        _;
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        proxyAddress = address(new ERC1967Proxy{salt:_salt}(implementation, data));
    }

    modifier upgrade() {
        _;
        if (proxyAddress == address(0)) {
            revert InvalidAddress("proxy address can not be zero");
        }
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        }
        UUPSUpgradeable proxy = UUPSUpgradeable(proxyAddress);
        proxy.upgradeToAndCall(address(implementation), data);
    }

     modifier createOrUpgrade() {
        _;
        if (implementation == address(0)) {
            revert InvalidAddress("implementation address can not be zero");
        } 
        if (proxyAddress == address(0)) {
             proxyAddress = address(new ERC1967Proxy{salt:_salt}(implementation, data));
         } else {
            UUPSUpgradeable proxy = UUPSUpgradeable(proxyAddress);
            proxy.upgradeToAndCall(address(implementation), "");
         }
     }
 
    constructor(uint256 pkey, bytes32 salt_ , address proxyAddress_ ) {
        privateKey = pkey;
        _salt = salt_;
        proxyAddress = proxyAddress_;
    }

     function getProxyAddress(bytes memory encodedCall) public view returns (address) {
        return Create2.computeAddress(bytes32(_salt), keccak256(abi.encodePacked(
                type(ERC1967Proxy).creationCode,
                abi.encode(
                    implementation,
                    encodedCall
                    //abi.encodeCall(initialize, (msg.sender))
                )
            )));
    }

    function run() external {
        vm.startBroadcast(privateKey);
        _run();
        vm.stopBroadcast();
    }

    function _run() internal virtual;

    function isContract(address _addr) internal view returns(bool) {
        uint256 size;
        assembly { size := extcodesize(_addr) }
        return (size > 0);
    }
 


}
