// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {DeployScript} from "contracts/DeployScript.sol";
import {DPAIStaking} from "contracts/DPAIStaking.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "hardhat/console.sol";
contract DeployContractManager is DeployScript {
    bytes32 private _salt = keccak256("DPAIStaking");
    constructor()
        DeployScript(
            vm.envUint("PRIVATE_KEY"),
            _salt,
            vm.envOr("DPAISTAKING_PROXY", address(0))
        )
    {}
    function _run() internal override createOrUpgrade {
        DPAIStaking c = new DPAIStaking{salt: _salt}();
        implementation = address(c);
        initialize = abi.encodeCall(
            c.initialize,
            (
                vm.envAddress("WALLET"),
                vm.envAddress("DPAITOKEN_PROXY") 
            )
        );
        data = bytes.concat(
            c.initialize.selector,
            abi.encode(
                vm.envAddress("WALLET"),
                vm.envAddress("DPAITOKEN_PROXY") 
            )
        );
    }
}
