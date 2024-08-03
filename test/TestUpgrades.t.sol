// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test,console} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract TestUpgrades is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public proxy;

    address public OWNER = makeAddr("owner");

    function setUp() public
    {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); // right now points to BoxV1
    }

    function test_StartsWithBoxV1() public {
        
        BoxV1 box = BoxV1(proxy);
        uint256 number = box.getNumber();
        uint256 version = box.getVersion();
        
        assertEq(0, number, "Number should be 0");
        assertEq(1, version, "Version should be 1");
    }

    function test_UpgradesToBoxV2() public
    {
        BoxV2 box = new BoxV2();

        upgrader.upgradeBox(proxy , address(box));

        BoxV2 newImplementation = BoxV2(proxy);
        uint256 number = newImplementation.getNumber();
        uint256 version = newImplementation.getVersion();
        
        assertEq(0, number, "Number should be 0");
        assertEq(2, version, "Version should be 1");

        newImplementation.setNumber(5);

        assertEq(5, newImplementation.getNumber());
    }
}