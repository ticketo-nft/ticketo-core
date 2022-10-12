// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../common/access/Ownable.sol";
import "../common/security/ReentrancyGuard.sol";
import "../common/token/ERC20/utils/SafeERC20.sol";
import "./interfaces/ITicket.sol";

contract Factory is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    bool public isDeprecated;
    address public cashAddress;
    address public ticketAddress;

    event FestivalAdded(uint256 index);
    event BuyTicket(address indexed user, uint80 index, uint256 schedule, uint80 seat);

    struct FestivalInfo {
        uint256 index;
        string name;
        string description;
        string thumbImg;
        string fullImg;
        uint256 schedule;
        uint256 price;
    }

    FestivalInfo[] public festivalInfos;
    mapping(uint256 => bool[40]) seatInfos;

    constructor(address _cashAddress, address _ticketAddress) {
        isDeprecated = false;
        cashAddress = _cashAddress;
        ticketAddress = _ticketAddress;
        _transferOwnership(msg.sender);
    }

    function festivalInfoLength() view external returns (uint256) {
        return festivalInfos.length;
    }

    function buyTicket(uint256 _index, uint256 _schedule, uint80 _seat) external {
        require(_index <= festivalInfos.length);

        bool [40] storage seatInfo = seatInfos[_index];
        require(seatInfo[_seat] == false);
        seatInfo[_seat] = true;

        FestivalInfo memory festivalInfo = festivalInfos[_index];
        uint256 balance = IERC20(cashAddress).balanceOf(msg.sender);
        require(balance >= festivalInfo.price);

        IERC20(cashAddress).transferFrom(msg.sender, address(this), festivalInfo.price);
        ITicket(ticketAddress).mint(msg.sender, _index, _schedule, _seat, festivalInfo.price);
    }

    function addFestival(string[] memory _strings, uint256 _schedule, uint256 _price) external onlyOwner {
        uint256 index = festivalInfos.length;
        festivalInfos.push(FestivalInfo(index, _strings[0], _strings[1], _strings[2], _strings[3], _schedule, _price));
        emit FestivalAdded(index);
    }
}