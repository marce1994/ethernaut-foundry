// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut.sol";
import 'openzeppelin-contracts/contracts/utils/math/SafeMath.sol';
import "../src/CoinFlip/CoinFlipTest.t.sol";

// for i in {1..10}; do source .env && forge script script/CoinFlip.s.sol:CoinFlipScript --rpc-url $RINKEBY_RPC_URL --broadcast --private-key $ETH_PRIV_KEY --verify --etherscan-api-key $ETHERSCAN_API_KEY -vv && sleep 20; done;
contract CoinFlipScript is Script {
    using SafeMath for uint256;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Proxy proxy = Proxy(0xcF75170c95BEFef63B36bB89e4A9eDa3fEB6c278); // Deploy this first

        // Hack
        address instance = 0x8fABDC87305AF9bd38E0f11d530F96548a5ADe26;
        proxy.HackCoinFlip(instance);

        vm.stopBroadcast();
    }
}