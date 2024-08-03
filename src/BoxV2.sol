// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {UUPSUpgradeable} from  "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
// can also add the initializer stuff if we want

contract BoxV2 is UUPSUpgradeable {
    uint256 internal number;

    function setNumber(uint256 _number) external{
        number = _number;
    }

    function getNumber() external view returns(uint256)
    {
        return number;
    }

    function getVersion() external pure returns(uint256)
    {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {} 
}