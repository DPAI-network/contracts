// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {DeployScript} from "contracts/DeployScript.sol";
import {DPAIAirdrop} from "contracts/DPAIAirdrop.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "hardhat/console.sol";
contract DeployContractManager is DeployScript {
    bytes32 private _salt = keccak256("DPAIAirdrop");
    constructor()
        DeployScript(
            vm.envUint("PRIVATE_KEY"),
            _salt,
            vm.envOr("DPAIAIRDROP_PROXY", address(0))
        )
    {}
    function _run() internal override createOrUpgrade {
        DPAIAirdrop c = new DPAIAirdrop{salt: _salt}();
        implementation = address(c);
        initialize = abi.encodeCall(
            c.initialize,
            (
                vm.envAddress("WALLET"),
                vm.envBytes32("MERKLE_ROOT"),
                vm.envAddress("DPAITOKEN_PROXY") 
            )
        );
        data = bytes.concat(
            c.initialize.selector,
            abi.encode(
                vm.envAddress("WALLET"),
                vm.envBytes32("MERKLE_ROOT"),
                vm.envAddress("DPAITOKEN_PROXY") 
            )
        );
    }
}
