import { HardhatUserConfig } from "hardhat/types";
import "@shardlabs/starknet-hardhat-plugin";
import "@nomiclabs/hardhat-ethers";

const config: HardhatUserConfig = {
  solidity: "0.6.12",
  starknet: {
    dockerizedVersion: "0.8.1",
    network: "devnet",
  },
  networks: {
    devnet: {
      url: "http://127.0.0.1:5050",
    },
  },
};

export default config;
