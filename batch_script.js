const hre = require("hardhat");

async function main() {
  const [owner] = await hre.ethers.getSigners();
  
  // Implementation and Factory addresses (from Repo 24)
  const FACTORY_ADDR = "0x..."; 
  const TOKEN_ADDR = "0x...";

  const factory = await hre.ethers.getContractAt("BatchVestingFactory", FACTORY_ADDR);

  const beneficiaries = [
    "0x70997970C51812dc3A010C7d01b50e0d17dc79C8",
    "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC",
    "0x90F79bf6EB2c4f870365E785982E1f101E93b906"
  ];
  
  const now = Math.floor(Date.now() / 1000);
  const starts = [now, now, now];
  const durations = [31536000, 63072000, 126144000]; // 1yr, 2yr, 4yr

  console.log("Starting batch deployment...");
  const tx = await factory.batchDeployVesting(TOKEN_ADDR, beneficiaries, starts, durations);
  await tx.wait();
  
  console.log(`Successfully deployed ${beneficiaries.length} vesting vaults.`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
