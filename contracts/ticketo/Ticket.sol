// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../common/access/Ownable.sol";
import "../common/token/ERC721/extensions/ERC721Burnable.sol";
import "../common/token/ERC20/utils/SafeERC20.sol";
import "../common/token/ERC20/IERC20.sol";


contract Ticket is ERC721Burnable, Ownable {
    using SafeERC20 for IERC20;
    struct TicketInfo {
        address ev;
        uint256 seat;
        uint256 schedule;
        uint256 price;
    }

    TicketInfo[] public ticketInfos;
    address public factory;
    address public cash;

    constructor() ERC721("Ticketo-Ticket", ""){}

    function mint(address _account, address _ev, uint256 _seat, uint256 _schedule, uint256 _price) {
        require(msg.sender == factory);
        uint256 ticketId = ticketInfos.length;
        ticketInfos.push(TicketInfo(_ev, _seat, _schedule, _price));
        _mint(_account, ticketId);
    }

    function burn(uint256 tokenId) public virtual override {
        require(msg.sender == factory);
        super._burn(tokenId);
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