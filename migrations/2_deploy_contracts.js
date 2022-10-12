const dotenv = require('dotenv');
dotenv.config();

const PaperMoney = artifacts.require("PaperMoney");
const Factory = artifacts.require("Factory");
const Ticket = artifacts.require("Ticket");

module.exports = function (deployer) {
    // deployer.deploy(PaperMoney);
    // deployer.deploy(Ticket);
    deployer.deploy(Factory, "0x9D3Fb5FA31882aCcf6a7e800E100DFB7BfEaCfc0", "0x88fba9B861B0B3168C491C71ce2f0842E3678FB2");
};