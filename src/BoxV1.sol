// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {UUPSUpgradeable} from  "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable,OwnableUpgradeable,UUPSUpgradeable{
    uint256 internal number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers(); // "hey constructor , don't do anything"
    }

    function initialize() public initializer{
        __Ownable_init(msg.sender); // sets owner = msg.sender
        __UUPSUpgradeable_init(); // doesn't do anything , is just good practice
    }

    function getNumber() external view returns(uint256)
    {
        return number;
    }

    function getVersion() external pure returns(uint256)
    {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {} 
}