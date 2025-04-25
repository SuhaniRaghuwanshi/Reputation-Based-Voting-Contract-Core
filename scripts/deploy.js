const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying ReputationVoting contract from:", deployer.address);

  const ReputationVoting = await hre.ethers.getContractFactory("ReputationVoting");
  const reputationVoting = await ReputationVoting.deploy();
  await reputationVoting.deployed();

  console.log("✅ ReputationVoting contract deployed at:", reputationVoting.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
