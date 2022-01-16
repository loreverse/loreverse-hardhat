// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";

contract Loreverse is ERC721Enumerable, Ownable {
	using Strings for uint256;

	constructor() ERC721("Loreverse", "LORE") {}

	function exists(uint256 tokenId) public view returns (bool) {
		return _exists(tokenId);
	}

	function tokenURI(uint256 tokenId) public view override returns (string memory) {
		require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
		// TODO:
		return "";
	}

	function mint(
		string calldata metadata,
		string calldata title,
		string calldata body,
		uint256 originalTokenId
	) external {
		// TODO:
		// 	_safeMint(_msgSender(), tokenId);
	}

	function getForkCount(uint256 tokenId) public view returns (uint256) {
		// TODO:
		return 0;
	}

	function getTitle(uint256 tokenId) public view returns (string memory) {
		// TODO:
		return "";
	}

	function getBody(uint256 tokenId) public view returns (string memory) {
		// TODO:
		return "";
	}
}
