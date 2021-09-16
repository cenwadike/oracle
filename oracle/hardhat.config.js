/**
 * @type import('hardhat/config').HardhatUserConfig
 */

 require("dotenv").config();

 require("@nomiclabs/hardhat-etherscan");
 require("@nomiclabs/hardhat-waffle");
 
 const fs = require("fs");
 const privateKey = fs.readFileSync(".secret").toString();
  
 const projectId = "017b2c20018d4243a6fcff529c181b58";
 
 module.exports = {
   solidity: "0.8.4",
   networks: {
     hardhat: {
       chainId: 1337
       // initialBaseFeePerGas: 0, // workaround from https://github.com/sc-forks/solidity-coverage/issues/652#issuecomment-896330136 . Remove when that issue is closed.
     },
     mumbai: {
       url: `https://polygon-mumbai.infura.io/v3/${projectId}`,
       accounts: [privateKey]
     },
     mainnet: {
       url: `https://mainnet.infura.io/v3/${projectId}`,
       accounts: [privateKey]
     }
     
   },
   gasReporter: {
     enabled: process.env.REPORT_GAS !== undefined,
     currency: "USD",
   }
 };
 
