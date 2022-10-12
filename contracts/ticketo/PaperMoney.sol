// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../common/token/ERC20/ERC20.sol";

contract PaperMoney is ERC20 {
    constructor() ERC20("PaperMoney", "pUSD") {

    }
    function mint(uint amount) external {
        _mint(msg.sender, amount);
    }

    function burn(uint amount) external {
        _burn(msg.sender, amount);
    }
}