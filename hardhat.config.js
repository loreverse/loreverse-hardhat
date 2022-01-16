const { privateKey, alchemyApiKey, polygonscanApiKey, etherscanApiKey } = require("./secrets.json");

require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
	const accounts = await hre.ethers.getSigners();

	for (const account of accounts) {
		console.log(account.address);
	}
});

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
	solidity: {
		version: "0.8.11",
		settings: {
			optimizer: {
				enabled: true,
				runs: 200,
			},
		},
	},
	networks: {
		hardhat: {},
		rinkeby: {
			url: "https://eth-rinkeby.alchemyapi.io/v2/" + alchemyApiKey,
			chainId: 4,
			accounts: [privateKey],
		},
		matic_testnet: {
			url: "https://matic-mumbai.chainstacklabs.com",
			chainId: 80001,
			accounts: [privateKey],
		},
		matic_mainnet: {
			url: "https://matic-mainnet.chainstacklabs.com",
			chainId: 137,
			accounts: [privateKey],
		},
	},
	etherscan: {
		// apiKey: etherscanApiKey    // EtherscanでVerifyする場合
		apiKey: polygonscanApiKey, // PolygonscanでVerifyする場合
	},
};
