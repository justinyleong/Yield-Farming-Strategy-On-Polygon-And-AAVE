// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.0 <0.8.0;

import "../../deps/interfaces/aave/ILendingPoolAddressesProvider.sol";
import "../../deps/interfaces/aave/ILendingPool.sol";

import "../../deps/interfaces/openzepplin/ERC20.sol";
import "../../deps/interfaces/openzepplin/SafeMath.sol";

contract AaveInteractor {
    using SafeMath for uint256;

    ILendingPoolAddressesProvider public provider = ILendingPoolAddressesProvider(0xd05e3E715d945B59290df0ae8eF85c1BdB684744);
    ILendingPool public aPool = ILendingPool(provider.getLendingPool());

    /*
    constructor(uint256 _lendingPoolAddress) public {
        provider = ILendingPoolAddressesProvider(_lendingPoolAddress);
        aPool = ILendingPool(provider.getLendingPool());
    }
    */

    function aDeposit(ERC20 _token, uint256 _amount) external {
        if(_amount != 0) {
            _token.approve(address(aPool), _amount);

            aPool.deposit(address(_token), _amount, address(this), 0);
        }
    }

    function aWithdraw(
        ERC20 _token,
        uint256 _amount,
        bool _withAll
    ) external {
        if (_withAll) {
            aPool.withdraw(address(_token), type(uint256).max, address(this));
        } else {
            aPool.withdraw(address(_token), _amount, address(this));
        }
    }

    function aBorrow(
        ERC20 _token,
        uint256 _amount,
        uint256 _debtType
    ) external {
        aPool.borrow(address(_token), _amount, _debtType, 0, address(this));
    }

    function aRepay(
        ERC20 _token,
        uint256 _amount,
        uint256 _debtType,
        bool _repayAll
    ) external {
        _token.approve(address(aPool), _amount);
        if (_repayAll) {
            aPool.repay(
                address(aPool),
                type(uint256).max,
                _debtType,
                address(this)
            );
        } else {
            aPool.repay(address(aPool), _amount, _debtType, address(this));
        }
    }
}
