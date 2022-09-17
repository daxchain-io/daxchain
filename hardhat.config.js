/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      evmVersion: "byzantium",
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    },
  },
  networks: {
    mainnet: {
      url: "https://mainnet.infura.io/v3/7a4e3713d7224de18fc39e73ff0b8b66",
      accounts: [""]
    }
  },
  etherscan: {
    apiKey: ""
  }
};
