// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CandidateNFT is ERC721 {
    // Token Counter
    uint256 public tokenCounter;
    
    constructor () ERC721("Candidate", "CNFT") {
        tokenCounter = 0;
    }
}
