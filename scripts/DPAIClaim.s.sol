// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol"; // solhint-disable
import {console} from "forge-std/console.sol";

import {DPAIAirdrop} from "contracts/DPAIAirdrop.sol";

contract DeployContractMigration is Script {
    uint256 public immutable privateKey;
    address public contractAddress;
    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
        contractAddress = vm.envAddress("DPAIAIRDROP_PROXY");
    }
    function run() external {
        vm.startBroadcast(privateKey);
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = bytes32(
            0xcefd908f57843d2481be377d10d67148d5334010ef59ec86de892d9b456b4241
        );
        proof[1] = bytes32(
            0x3ae57b03aa85822e428a2e69fff2c699e13a9c7ac9c261963249e1587816f150
        );
        DPAIAirdrop c = DPAIAirdrop(contractAddress);
        // c.setToken(vm.envAddress("DPAITOKEN_PROXY"));
        // c.setRoot(bytes32(0x8de9735df9f93ad8a091508497782317f023defac8d3634c642bf758b2501442))  ; 
        c.unset(0x52f374460d02580256288a8597BB48921ba3912B);
        /*  c.claim(
            proof,
            0x52f374460d02580256288a8597BB48921ba3912B,
            10000000000000000000
        ); */
 
        vm.stopBroadcast();
    }
}
