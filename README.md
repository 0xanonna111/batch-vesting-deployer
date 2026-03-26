# Batch Vesting Deployer

This repository extends the Minimal Proxy Vesting Factory with **Batch Processing** capabilities. It is designed for HR and Finance teams within Web3 organizations to execute mass token lockups efficiently.

## Features
* **Atomic Batching**: Deploy 1 to 100+ vesting schedules in one transaction.
* **Gas Optimization**: Uses a single `for` loop to clone and initialize proxies, minimizing the base transaction cost.
* **Safety Checks**: Reverts the entire batch if any single deployment fails, ensuring data consistency across the registry.

## Usage
1. Provide an array of `beneficiaries`, `starts`, and `durations`.
2. Ensure the lengths of all arrays match.
3. Call `batchDeployVesting()` from the owner's wallet.
