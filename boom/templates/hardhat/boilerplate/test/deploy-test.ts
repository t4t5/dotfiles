import { ethers } from "hardhat"
import { expect } from "chai"

describe("MyContract", function () {
  it("should return a name", async function () {
    const MyContract = await ethers.getContractFactory("MyContract")
    const myContract = await MyContract.deploy()

    const rawName = await myContract.getName()
    const name = ethers.utils.parseBytes32String(rawName)
    expect(name).to.equal("tristan")
  })
})
