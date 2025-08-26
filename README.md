Blockchain-Based Rent Agreement System

This project demonstrates a blockchain implementation of a simple rental agreement using **Solidity** and deployed/tested in **Remix Ethereum IDE**.

Smart Contract Features

- Roles: Landlord and Tenant
- Deposit and Rent values fixed at deployment
- Enforces:
  - Only the tenant can pay deposit
  - Only landlord/tenant can interact post-deployment
- Emits events: `DepositPaid`, `RentPaid`, `LeaseEnded`
- Ensures secure and transparent rental process

Tech Stack

- Solidity (v0.8.8)
- Remix IDE
- Ethereum VM (Prague test environment)
- MetaMask accounts (in Remix)

Testing Steps (Screenshots in `/screenshots`)

1. Deployed contract with tenant and landlord addresses
2. Tenant called `payDeposit()` with exact deposit amount (2 ETH)
3. Landlord/tenant cannot misuse functions due to role-based modifiers
4. Transactions recorded on test blockchain (Remix VM)
5. Revert triggered when wrong amount or user attempted payment



