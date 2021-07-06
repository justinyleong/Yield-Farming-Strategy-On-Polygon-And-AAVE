// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.0 <0.8.0;

interface ICurveAavePool {
    
    function add_liquidity(uint256[3] calldata _amounts, uint256 _min_mint_amount, bool _use_underlying) external returns (uint256);
    
    function remove_liquidity_imbalance(uint256[3] calldata _amounts, uint256 _max_burn_amount, bool _use_underlying) external returns (uint256);
}