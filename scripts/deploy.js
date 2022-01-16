const hre = require("hardhat");

async function main() {
	const factory = await ethers.getContractFactory("MyNft");
	const contract = await factory.deploy();
	await contract.deployed();
	console.log("Deployed to:", contract.address);
}
main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
