//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./../Interfaces/CallerContractInterface.sol";


contract PriceOracle is Ownable {
    uint private randNonce = 0;
    uint private modulus = 1000;

    mapping(uint256=>bool) pendingRequests;

    event GetLatestTokenPriceEvent(address callerAddress, uint id);
    event SetLatestTokenPriceEvent(uint256 ethPrice, address callerAddress);    

    // returns unique request id for token price request
    function getLatestTokenPrice() public returns (uint256) {
        //@dev pseudorandom number generator
        randNonce++;
        uint id = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % modulus;
        pendingRequests[id] = true;
        emit GetLatestTokenPriceEvent(msg.sender, id);
        return id;
    }

    function setLatestEthPrice(uint256 _tokenPrice, address _callerAddress, uint256 _id) public onlyOwner {
        require(pendingRequests[_id], "This request is not in my pending list.");
        delete pendingRequests[_id];
        CallerContractInterface callerContractInstance;
        callerContractInstance = CallerContractInterface(_callerAddress);
        callerContractInstance.callback(_tokenPrice, _id);
        emit SetLatestTokenPriceEvent(_tokenPrice, _callerAddress);
    }
}
