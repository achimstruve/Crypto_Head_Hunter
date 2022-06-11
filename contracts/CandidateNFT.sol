// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CandidateNFT is ERC721, Ownable {
    // Token Counter
    uint256 public tokenId;

    // Internal information
    struct Internal_Info {
        bytes32 name;
        bytes32 description;
    }
    Internal_Info[] internal Internal_Informations;

    // Skills
    struct Skill {
        bytes32 name;
        uint256 experience;
    }
    Skill[] public Skills;

    // Mappings
    mapping(uint256 => Internal_Informations) tokenIdToInternalInfo;
    mapping(uint256 => Skills) tokenIdToSkills;
    mapping(uint256 => address) tokenIdToHolder;

    constructor() ERC721("Candidate", "CNFT") {
        tokenId = 0;
    }

    function createInternalInfo(bytes32 _name, bytes32 _description)
        public
        payable
        onlyOwner
    {
        Internal_Info memory newInfo;
        newInfo.name = _name;
        newInfo.description = _description;
        Internal_Info[].push(newInfo);
    }

    function getInternalInfo()
        public
        payable
        onlyOwner
        returns (bytes32[], bytes32[])
    {
        return Internal_Info;
    }

    function createSkill(bytes32 _name, uint256 _experience)
        public
        payable
        onlyOwner
    {
        Skill memory newSkill;
        newSkill.name = _name;
        newSkill.experience = _experience;
        Skills.push(newSkill);
    }

    function getSkills() public payable onlyOwner returns (Skill) {
        return Skills;
    }
}
