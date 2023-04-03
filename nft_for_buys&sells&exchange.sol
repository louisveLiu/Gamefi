// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GameNFT is ERC721Enumerable, Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    IERC20 private _token;

    uint256 private constant PRICE = 10 * 10**18; // 10 Tokens

    enum AssetType {CHARACTER, ITEM}

    struct Asset {
        uint256 id;
        string name;
        AssetType assetType;
        uint256 level;
    }

    mapping(uint256 => Asset) private _assets;
    mapping(uint256 => uint256) private _tokenPrices;

    constructor(IERC20 token) ERC721("GameNFT", "GNFT") {
        _token = token;
    }

    function mintAsset(address to, string memory name, AssetType assetType, uint256 level) public onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();

        _safeMint(to, tokenId);
        _assets[tokenId] = Asset(tokenId, name, assetType, level);

        return tokenId;
    }

    function buy(uint256 tokenId) public nonReentrant {
        require(_exists(tokenId), "Token does not exist");
        address seller = ownerOf(tokenId);

        _token.transferFrom(msg.sender, seller, _tokenPrices[tokenId]);
        _transfer(seller, msg.sender, tokenId);
    }

    function setTokenPrice(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Not token owner");
        _tokenPrices[tokenId] = price;
    }

    function swap(uint256 tokenId1, uint256 tokenId2) public {
        address owner1 = ownerOf(tokenId1);
        address owner2 = ownerOf(tokenId2);

        require(owner1 == msg.sender || owner2 == msg.sender, "Caller is not owner of any tokens");

        _transfer(owner1, owner2, tokenId1);
        _transfer(owner2, owner1, tokenId2);
    }

    function upgrade(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
        _assets[tokenId].level++;
    }

    function getAsset(uint256 tokenId) public view returns (Asset memory) {
        return _assets[tokenId];
    }

    function getTokenPrice(uint256 tokenId) public view returns (uint256) {
        return _tokenPrices[tokenId];
    }
}
