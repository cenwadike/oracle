//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface PriceOracleInterface {
  function getLatestTokenPrice() external returns (uint256);
}
