// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script{
    function run() external returns(address proxy){
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
            );
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        proxy = upgradeBox(mostRecentDeployment , address(newBox));
    }

    function upgradeBox(address proxyAddress , address newBox) public returns(address){
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddress); // VERY IMP LINE
        // we are accessing the functions of proxy via interface of BoxV1 (this is what UUPSUpgradeable means , proxy being implemented into the implementation contracts)
        // since BoxV1 is UUPSUpgradeable , we can call the `upgradeToAndCall` function on it
        proxy.upgradeToAndCall(newBox , "");
        vm.stopBroadcast();
        return address(proxy);
    }
}