# Yield-Farming-Strategy-On-Polygon-And-AAVE
## Gitcoin Round 10 Hackathon

Follows the strategy as listed in the submission requirements.

## Use

1. User deposits DAI and MATIC into the contract

2. Run the execute function

3. User can "tend" the farm periodically with the `tend` function

4. Run the `harvest` function to "harvest" all your tokens, which will be converted to DAI

## Technical Specs

- farm.sol is the main controller that uses the three functions `execute`, `harvest`, and `tend` to run the dapp

- Deposits DAI into Aave and borrows against the deposit

- Stakes borrowed DAI into Curve's aave pool

- Whenever the user `tends` their "crops," the rewards from aave and curve will be swapped to DAI and the cycle will begin again

- `harvest` allows the user to collect their "crops," thereby claiming rewards from all platforms, repaying all loans, and withdrawing from Aave

## Note
Thank you so much for hosting this bounty! This was a great first introduction for me to defi, yield farming, and dapp development itself 😅. Learning everything in such a short time is something that I certainly won't forget. 

## Edit: 2022
Hi everyone! This project has not been touched for a while, so feel free to contact me if you wish to continue the work. Currently, the defi space is still rapidly expanding, so this is a good starter project for anyone interested. Here are some helpful links about the topic:

[LINK](https://cryptonews.com/news/defi-news/)

