// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyContract {
  bytes32 public constant NAME = "tristan";

  function getName() external pure returns (bytes32) {
    return NAME;
  }
}
