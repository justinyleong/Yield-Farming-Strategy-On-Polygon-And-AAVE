// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.0 <0.8.0;

import "../../deps/interfaces/quickswap/IUniswapV2Router01.sol";

import "../../deps/interfaces/openzepplin/ERC20.sol";
import "../../deps/interfaces/openzepplin/SafeMath.sol";

contract quickswapInteractor {
    using SafeMath for uint256;
        
    IUniswapV2Router01 public router = IUniswapV2Router01(0xa5E0829CaCEd8fFDD4De3c43696c57F7D7A678f);
    
    /*
    constructor(address _routerAddress) public {
        router = IUniswapV2Router01(_routerAddress);
    }
    */
    
    function swap(ERC20 _tokenA, ERC20 _tokenB) external {
        address[] calldata path;
        path[0] = address(_tokenA);
        path[1] = address(_tokenB);

        // still needs an oracle
        uint256 amountOut = 0;
        uint256 amountInMax = 0;

        router.swapTokensForExactTokens(
            amountOut,
            amountInMax,
            path,
            address(this),
            Date().getTime() + 10000
        );
    }
}