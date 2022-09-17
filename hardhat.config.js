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
      url: "${ETHEREUM_MAINNET_URL}",
      accounts: ["${ETHEREUM_MAINNET_ACCOUNT_1}"]
    }
  },
  etherscan: {
    apiKey: "${ETHERSCAN_API_KEY}"
  }
};
