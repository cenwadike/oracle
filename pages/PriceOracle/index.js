import { ethers, providers } from 'ethers'
import { useEffect, useState } from 'react'
import axios from 'axios'
import Web3Modal from 'web3modal'

const client = ipfsHttpClient('infura_client_url')
const BN = require('bn.js')
/* const SLEEP_INTERVAL = process.env.SLEEP_INTERVAL || 2000
const MAX_RETRIES = process.env.MAX_RETRIES || 5 */
var pendingRequests = []


import {  } from './config.js' // contracts address 

// todo: import abi for smart contracts
import NFT from '../artifacts/contracts/NFT.sol/NFT.json'
import Market from '../artifacts/contracts/NFTMarket.sol/NFTMarket.json'
