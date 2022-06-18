import { ethers } from "hardhat"
import { expect } from "chai"

import { MyContract } from "../typechain/contracts/MyContract"

describe("MyContract", function () {
  let myContract: MyContract

  beforeEach(async () => {
    const MyContractFactory = await ethers.getContractFactory("MyContract")
    myContract = (await MyContractFactory.deploy()) as MyContract
  })

  describe("getName", function () {
    it("should return a name", async function () {
      const rawName = await myContract.getName()
      const name = ethers.utils.parseBytes32String(rawName)
      expect(name).to.equal("tristan")
    })
  })
})
