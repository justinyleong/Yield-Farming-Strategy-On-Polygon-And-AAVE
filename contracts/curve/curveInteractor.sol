// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.0 <0.8.0;

import "../../deps/interfaces/curve/ICurveAavePool.sol";

import "../../deps/interfaces/openzepplin/SafeMath.sol";

contract curveInteractor {
    using SafeMath for uint256;
        
    ICurveAavePool pool = ICurveAavePool(0x445FE580eF8d70FF569aB36e80c647af338db351);
    
    /*
    constructor(uint256 _curveAavePoolAddress) public {
        pool = ICurveAavePool(_curveAavePoolAddress);
    }
    */
    
    function deposit(ERC20 _token, uint256 _amount) external {
        uint256[3] calldata tokens;
        // dai
        tokens[0] = _amount;
        // usdt
        tokens[1] = 0;
        //usdc
        tokens[2] = 0;
        
        pool.add_liquidity(tokens, _amount, false);
    }
    
    function withdraw(ERC20 _token, uint256 _amount, bool withAll) external {
        if(withAll){
            _amount = type(uint256).max;
        }
        uint256[3] calldata tokens;
        // dai
        tokens[0] = _amount;
        // usdt
        tokens[1] = 0;
        //usdc
        tokens[2] = 0;
        
        pool.remove_liquidity_imbalance(tokens, _amount, false);
    }
}