const { ethers } = require('hardhat')

async function main() {
  // deploys ERC20Factory smart contract
  try {
    const TokenFactoryDeployer = await ethers.getContractFactory(
      'PermittableERC20Factory'
    )
    const TokenFactory = await TokenFactoryDeployer.deploy()
    await TokenFactory.deployed()

    // latest deployed test contract address is [Sepolia: 0x10A7597A84eDA3091939f56b3eE55F7F96B7e87A]
    console.log(
      `Successfully deployed to contract address: ${TokenFactory.address}`
    )
  } catch (err) {
    console.error(err)
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
