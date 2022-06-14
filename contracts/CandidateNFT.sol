// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CandidateNFT is ERC721, Ownable {
    // Interfaces
    AggregatorV3Interface public priceFeed;
    
    // Parameter
    uint256 public tokenId;
    uint256 public minUSDprice;
    address public creatorAddress;

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
    mapping(address => uint256) public addressToAmountSpent;
    mapping(uint256 => Internal_Info[]) internal tokenIdToInternalInfo;
    mapping(uint256 => Skill[]) internal tokenIdToSkills;

    constructor(address _priceFeed) ERC721("Candidate", "CNDT") {
        priceFeed = AggregatorV3Interface(_priceFeed);
        minUSDprice = 50; // Set the minimum USD price for one candidate mint to $50
        creatorAddress = msg.sender;
    }

    modifier onlyCreator {
        require(msg.sender == creatorAddress);
        _;
    }

    function _setminUSDPrice(uint256 _newPrice) public onlyCreator{
        require(_newPrice >= 0, "The price has to be equal or more than 0 USD!");
        minUSDprice = _newPrice;
    }

    function _changeCreatorAddress(address _newCreator) public onlyCreator{
        creatorAddress = _newCreator;
    }

    // Candidate Properties //

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


    // Minting //

    function _mintCandidate(
        address _to,
        uint256 _tokenId,
        string memory _infoName,
        string memory _description,
        string memory _skillName,
        uint256 _experience
    ) public payable {
        require(getConversionRate(msg.value)/10**18 >= minUSDprice, "You have to spend more to mint this NFT!");
        addressToAmountSpent[msg.sender] = msg.value;
        createInternalInfo(_infoName, _description, _tokenId);
        createSkill(_skillName, _experience, _tokenId);
        _safeMint(_to, _tokenId, "");
    }

    
    // ETH Price and Conversions //

    function _getPrice() public view returns(uint256){
        (,int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 10000000000);
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = _getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }
}
