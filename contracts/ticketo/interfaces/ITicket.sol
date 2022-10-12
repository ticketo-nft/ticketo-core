// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ITicket {
    function mint(address _account, uint256 _index, uint256 _schedule, uint80 _seat, uint256 _price) external;
}