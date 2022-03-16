# Starting a new Dapp project

```
- npm init -y
- npm i -D hardhat
- npm i -D @nomiclabs/hardhat-etherscan
- npx hardhat
- npm i @openzeppelin/contracts
- npm i dotenv
- npx hardhat run scripts/sample-script.js
```

# To deploy and verify

```
- npx hardhat run scripts/deploy.js --network rinkeby
- npx hardhat verify YOUR_CONTRACT_ADDRESS --network rinkeby
```

# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
