// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CandidateNFT is ERC721, Ownable {
    // Token Counter
    uint256 public tokenId;

    // Internal Information Struct
    struct Internal_Info {
        string name;
        string description;
    }

    // Skill Struct
    struct Skill {
        string name;
        uint256 experience;
    }

    // Mappings
    mapping(uint256 => Internal_Info[]) internal tokenIdToInternalInfo;
    mapping(uint256 => Skill[]) internal tokenIdToSkills;

    constructor() ERC721("Candidate", "CNDT") {}

    function createInternalInfo(
        string memory _name,
        string memory _description,
        uint256 _tokenId
    ) public onlyOwner {
        Internal_Info memory newInfo;
        newInfo.name = _name;
        newInfo.description = _description;
        tokenIdToInternalInfo[_tokenId].push(newInfo);
    }

    function getInternalInfo(uint256 _tokenId)
        public
        view
        onlyOwner
        returns (Internal_Info[] memory)
    {
        Internal_Info[] memory internalInfo = tokenIdToInternalInfo[_tokenId];
        return internalInfo;
    }

    function createSkill(
        string memory _name,
        uint256 _experience,
        uint256 _tokenId
    ) public onlyOwner {
        Skill memory newSkill;
        newSkill.name = _name;
        newSkill.experience = _experience;
        tokenIdToSkills[_tokenId].push(newSkill);
    }

    function getSkills(uint256 _tokenId)
        public
        view
        onlyOwner
        returns (Skill[] memory)
    {
        Skill[] memory skills = tokenIdToSkills[_tokenId];
        return skills;
    }

    function _mintCandidate(
        address _to,
        uint256 _tokenId,
        string memory _infoName,
        string memory _description,
        string memory _skillName,
        uint256 _experience
    ) public payable {
        createInternalInfo(_infoName, _description, _tokenId);
        createSkill(_skillName, _experience, _tokenId);
        _safeMint(_to, _tokenId, "");
    }
}
