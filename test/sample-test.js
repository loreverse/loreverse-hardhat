const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Loreverse", function () {
	let contract, contractWithAlice, contractWithBob;
	let Owner, Alice, Bob;

	beforeEach(async function () {
		const factory = await ethers.getContractFactory("Loreverse");
		contract = await factory.deploy();
		await contract.deployed();

		[Owner, Alice, Bob] = await ethers.getSigners();
		contractWithAlice = contract.connect(Alice);
		contractWithBob = contract.connect(Bob);
	});

	it("name&symbol", async function () {
		expect(await contract.name()).to.equal("Loreverse");
		expect(await contract.symbol()).to.equal("LORE");
	});

	it("metadata", async function () {
		const tx1 = await contractWithAlice.mint("metadata1", "title1", "body1", 0); // tokenId = 1
		await tx1.wait();
		const tx2 = await contractWithBob.mint("metadata2", "title2", "body2", 1); // tokenId = 2
		await tx2.wait();
		expect(await contractWithAlice.tokenURI(1)).to.equal("metadata1");
		expect(await contractWithAlice.tokenURI(2)).to.equal("metadata2");
	});

	it("getForkCount", async function () {
		const tx1 = await contractWithAlice.mint("metadata1", "title1", "body1", 0); // tokenId = 1
		await tx1.wait();
		const tx2 = await contractWithBob.mint("metadata2", "title2", "body2", 1); // tokenId = 2
		await tx2.wait();
		expect(await contract.getForkCount(1)).to.equal(1);
		expect(await contract.getForkCount(2)).to.equal(0);
	});
});
