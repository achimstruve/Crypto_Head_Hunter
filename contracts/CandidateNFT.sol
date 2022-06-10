// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CandidateNFT is ERC721 {
    // Token Counter
    uint256 public tokenCounter;

    // Initialize Skills
    struct Skill {
        bytes32 name;
        uint256 level;
    }
    Skill public Solidity;
    Skill public Rust;
    Skill public Vyper;
    Skill public Cpp;
    Skill public Csharp;
    Skill public Python;
    Skill public Java;
    Skill public Golang;
    Skill public JavaScript;
    Skill public Front_End_UI;
    Skill public Art;
    Skill public Writing;
    Skill public Data_Science;
    Skill public Tokenomics;
    Skill public Marketing;
    Skill public Leadership;
    Skill public Moderation;

    constructor() ERC721("Candidate", "CNFT") {
        tokenCounter = 0;
    }
}
