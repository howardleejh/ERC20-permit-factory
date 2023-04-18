require('@nomicfoundation/hardhat-toolbox')
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: '0.8.19',
        settings: {
          optimizer: {
            enabled: true,
            runs: 999999,
          },
        },
      },
    ],
  },
  networks: {
    sepolia: {
      url:
        `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}` ||
        '',
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  gasMultiplier: 1.2,
  gasReporter: {
    enabled: true,
    currency: 'USD',
    token: 'ETH',
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  paths: {
    sources: './src',
  },
}
