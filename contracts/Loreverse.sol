// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";

contract Loreverse is ERC721Enumerable, Ownable {
	using Strings for uint256;

	uint256 public nextTokenId = 1;
	mapping(uint256 => string) metadatas; // tokenId -> metadata(Base64Encoded)
	mapping(uint256 => string) titles; // tokenId -> title
	mapping(uint256 => string) bodies; // tokenId -> body
	mapping(uint256 => uint256) forkCounts; // tokenId -> forkCount
	mapping(uint256 => uint256) tokenIdOfTheForkSourceLore; // tokenId -> originalTokenId

	constructor() ERC721("Loreverse", "LORE") {}

	function exists(uint256 tokenId) public view returns (bool) {
		return _exists(tokenId);
	}

	function tokenURI(uint256 tokenId) public view override returns (string memory) {
		require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
		return metadatas[tokenId];
	}

	function mint(
		string calldata metadata,
		string calldata title,
		string calldata body,
		uint256 originalTokenId
	) external {
		uint256 _tokenId = nextTokenId;
		nextTokenId++;
		metadatas[_tokenId] = metadata;
		titles[_tokenId] = title;
		bodies[_tokenId] = body;

		if (originalTokenId > 0) {
			forkCounts[originalTokenId] += 1;
			tokenIdOfTheForkSourceLore[_tokenId] = originalTokenId;
		}

		_safeMint(_msgSender(), _tokenId);
	}

	function getForkCount(uint256 tokenId) public view returns (uint256) {
		require(_exists(tokenId), "nonexistent token");
		return forkCounts[tokenId];
	}

	function getTitle(uint256 tokenId) public view returns (string memory) {
		require(_exists(tokenId), "nonexistent token");
		return titles[tokenId];
	}

	function getBody(uint256 tokenId) public view returns (string memory) {
		require(_exists(tokenId), "nonexistent token");
		return bodies[tokenId];
	}

	function getOriginalTokenId(uint256 tokenId) public view returns (uint256) {
		require(_exists(tokenId), "nonexistent token");
		return tokenIdOfTheForkSourceLore[tokenId];
	}
}
