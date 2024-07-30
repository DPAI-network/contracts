// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol"; // solhint-disable
import {console} from "forge-std/console.sol";

import {DPAIToken} from "contracts/DPAIToken.sol";

contract DeployContractMigration is Script{
    uint256 public immutable privateKey;
    address payable public  contractAddress;
    constructor() {
        privateKey = vm.envUint("PRIVATE_KEY");
        contractAddress = payable(vm.envAddress("DPAITOKEN_PROXY"));
        // contractAddress = payable(vm.envAddress("SEPOLIA_DPAITOKEN2_PROXY"));
    }
    function run() external {
        vm.startBroadcast(privateKey);
        DPAIToken c = DPAIToken(contractAddress);
        // c.setOldToken(vm.envAddress("SEPOLIA_DPAITOKEN2_PROXY"));
        // c.transferTo(0xA19ad8CeD0c41D90BA86863083c02374f835Dff3, 100000000000000000000000);
        // c.setWallet(payable (0x972e08cf7d79E9CA2013fbd662CFFA31761d1325));
        // c.setPriceFeed(vm.envAddress("FEED"));

        // c.setMinimalTax(0);
        // c.setTaxPromille(0);
    /*     c.setTaxFree(vm.envAddress("DPAIAIRDROP_PROXY"), true);
        c.setTaxFree(vm.envAddress("DPAITOKEN_PROXY"), true);
        c.setTaxFree(vm.envAddress("DPAITOKEN2_PROXY"), true); */
        /* console.log(
            "Balance before",
            c.balanceOf(contractAddress)
        );
        c.mint(contractAddress, 100000000000000000000000000);
        c.transferTo(vm.envAddress("DPAIAIRDROP_PROXY"), 10000000000000000000000000);
                console.log(
            "Balance transfered",
            c.balanceOf(contractAddress)
        );
                console.log(
            "Balance airdrop",
            c.balanceOf(vm.envAddress("DPAIAIRDROP_PROXY"))
        ); */
       /*  c.mint(contractAddress, 100000000000000000000000000);
        console.log(
            "Balance minted",
            c.balanceOf(contractAddress)
        );
        c.transferTo(vm.envAddress("TEST"), 10000000000000000000);
        console.log(
            "Balance transfered",
            c.balanceOf(contractAddress)
        ); */
        vm.stopBroadcast();
    }
}
