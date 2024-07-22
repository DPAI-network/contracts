// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {DeployScript} from "contracts/DeployScript.sol"; 
import {DPIAElections} from "contracts/DPIAElections.sol"; 
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "hardhat/console.sol";
contract DeployContractManager is DeployScript {
    bytes32 private _salt = keccak256("DPIAElections");

    constructor() DeployScript(vm.envUint("PRIVATE_KEY"), _salt, vm.envOr("DPIAELECTIONS_PROXY", address(0))) {}

     function _run() internal override createOrUpgrade {
        DPIAElections c = new DPIAElections{salt:_salt}();
        implementation = address(c); 
        initialize =  abi.encodeCall(c.initialize, (vm.envAddress("OWNER")));
        data = bytes.concat(c.initialize.selector, abi.encode(vm.envAddress("OWNER")));
    }
}
