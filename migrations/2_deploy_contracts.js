const dotenv = require('dotenv');
dotenv.config();

const PaperMoney = artifacts.require("PaperMoney");
const Factory = artifacts.require("Factory");
const Ticket = artifacts.require("Ticket");

module.exports = function (deployer) {
    // deployer.deploy(PaperMoney);
    // deployer.deploy(Ticket);
    deployer.deploy(Factory, "0x57ce059C55b71424299Ef4C4795e1756378B5Cfd", "0x700329D1840f4cd5E7b7bFbd9b9a8aCeFd7fbBE5");
};