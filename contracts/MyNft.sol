// SPDX-FileCopyrightText: 2022 @NowAndNawoo
//
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";

contract MyNft is ERC721Enumerable, Ownable {
	using Strings for uint256;

	uint8 public constant VERSION = 1;

	constructor() ERC721("MyNFT", "MYNFT") {}

	function exists(uint256 tokenId) public view returns (bool) {
		return _exists(tokenId);
	}

	function claim(uint256 tokenId) external {
		_safeMint(_msgSender(), tokenId);
	}
}
