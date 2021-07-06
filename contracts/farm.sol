// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.0 <0.8.0;

import "./aave/aaveInteractor.sol";
import "./curve/curveInteractor.sol";
import "./quickswap/quickswapInteractor.sol";

import "../../deps/interfaces/openzepplin/ERC20.sol";
import "../../deps/interfaces/openzepplin/SafeMath.sol";

contract farm is aaveInteractor, curveInteractor, quickswapInteractor {
    using SafeMath for uint256;
    
    uint256 totalDai = 0;
    // tokens
    ERC20 DAI = ERC20(0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063);
    ERC20 MATIC = ERC20(0x0000000000000000000000000000000000001010);
    ERC20 WMATIC = ERC20(0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270);
    ERC20 CRV = ERC20(0x172370d5cd63279efa6d502dab29171933a610af);
    
    function execute() external {
        
        // deposits the dai
        aDeposit(DAI, DAI.balanceOf(address(this)));
        totalDai = DAI.balanceOf(address(this));
        
        // borrows more stablecoins
        aBorrow(DAI, 0.75 * 10**18 * totalDai, 2);
        
        // deposits in curve
        cDeposit(DAI, DAI.balanceOf(address(this)));
    }
    
    function harvest() external {
        
        // withdraws and claim rewards from curve
        cWithdraw(DAI, type(uint256).max, true);
        
        // swap rewards to dai
        swap(WMATIC, DAI);
        swap(CRV, DAI);
        
        //repay aave loan
        aRepay(DAI, type(uint256).max, 2, true);
        
        // withdraw and claim rewards from aave
        aWithdraw(DAI, type(uint256).max, true);
        
        // claim wmatic and swap to dai
        swap(WMATIC, DAI);
        
        // sends funds back to user
        DAI.transfer(getBalance());
    }
    
    function tend() external {
        // claims curve rewards
        cWithdraw(DAI, type(uint256).max, true);
        cDeposit(DAI, DAI.balanceOf(address(this)));
        
        // swaps to dai
        swap(WMATIC, DAI);
        swap(CRV, DAI);
        
        // execute same process
        execute();
    }
}