//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./../contracts/Interfaces/PriceOracleInterface.sol";

contract CallerContract is Ownable {

  uint256 private tokenPrice;

  // initialize PriceOracleInterface
  PriceOracleInterface private oracleInstance;
  address private oracleAddress;
  // map valid request id to bool
  mapping(uint256=>bool) myRequests;

  event newOracleAddressEvent(address oracleAddress);
  event ReceivedNewRequestIdEvent(uint256 id);
  event PriceUpdatedEvent(uint256 tokenPrice, uint256 id);

  // set new Oracle smart contract address
  function setOracleInstanceAddress (address _oracleInstanceAddress) public onlyOwner {
    oracleAddress = _oracleInstanceAddress;
    oracleInstance = PriceOracleInterface(oracleAddress);
    emit newOracleAddressEvent(oracleAddress);
  }

  //@dev recieve latest token price id
  function updateTokenPrice() public {
    uint256 id = oracleInstance.getLatestTokenPrice();
    myRequests[id] = true;
    emit ReceivedNewRequestIdEvent(id);
  }

  // return latest token price id
  /*@dev callback fuction for async token price request 
  / update token price and remove request id from myRequest mapping */
  function callback(uint256 _tokenPrice, uint256 _id) public {
      require(myRequests[_id], "This request is not in my pending list.");
      tokenPrice = _tokenPrice;
      delete myRequests[_id];
      emit PriceUpdatedEvent(_tokenPrice, _id);
  }
    
  modifier onlyOracle() {
    require(msg.sender == oracleAddress, "You are not authorized to call this function.");
    _;
  }
}
