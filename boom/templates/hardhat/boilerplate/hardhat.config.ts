import { task } from "hardhat/config"
import "@nomiclabs/hardhat-ethers"
import "@nomiclabs/hardhat-etherscan"
import "solidity-coverage"

import dotenv from "dotenv"
dotenv.config()

// "npx hardhat accounts"
task("accounts", "Prints the list of accounts", async (_args, hre) => {
  const accounts = await hre.ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
})

const { /* INFURA_PROJECT_ID, PRIVATE_KEY,*/ ETHERSCAN_API_KEY } = process.env

export default {
  solidity: "0.8.0",
  paths: {
    artifacts: "./artifacts",
  },
  defaultNetwork: "hardhat",
  namedAccounts: {
    deployer: 0, // Call first address "deployer"
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
  // networks: {
  //   ropsten: {
  //     url: `https://ropsten.infura.io/v3/${INFURA_PROJECT_ID}`,
  //     accounts: [PRIVATE_KEY],
  //   },
  // },
}
