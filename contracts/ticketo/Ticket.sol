// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../common/access/Ownable.sol";
import "../common/token/ERC20/utils/SafeERC20.sol";
import "../common/token/ERC20/IERC20.sol";
import "./interfaces/ITicket.sol";
import "../common/token/ERC721/extensions/ERC721Enumerable.sol";


contract Ticket is ITicket, ERC721Enumerable, Ownable {
    using SafeERC20 for IERC20;
    struct TicketInfo {
        uint256 index;
        uint80 seat;
        uint256 schedule;
        uint256 price;
    }

    TicketInfo[] public ticketInfos;
    address public factory;
    address public cash;

    constructor() ERC721("Ticketo-Ticket", ""){}

    function mint(address _account, uint256 _index, uint256 _schedule, uint80 _seat, uint256 _price) external override virtual {
        require(msg.sender == factory);
        uint256 ticketId = ticketInfos.length;
        ticketInfos.push(TicketInfo(_index, _seat, _schedule, _price));
        _mint(_account, ticketId);
    }

    function withdrawAdminFee() external {
        require(msg.sender == factory);
        uint256 bal = IERC20(cash).balanceOf(address(this));
        IERC20(cash).transfer(factory, bal);
    }

    function setAddressInfo(address _factory, address _cash) external onlyOwner {
        factory = _factory;
        cash = _cash;
    }
}