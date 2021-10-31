import { ethers } from "hardhat"

async function main() {
  const MyContract = await ethers.getContractFactory("MyContract")
  const myContract = await MyContract.deploy()

  console.log("MyContract deployed to:", myContract.address)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
