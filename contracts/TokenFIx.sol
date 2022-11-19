// contracts/TokenExchange.sol
pragma solidity 0.8.10;

// Import base Initializable contract

// Import the IERC20 interface and and SafeMath library
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

contract TokenFix {
    using SafeMath for uint256;

    using SafeERC20 for IERC20;

    // Contract state: exchange rate and token
    IERC20 public oldToken;

    IERC20 public newToken;

    constructor(address _oldToken, address _newToken) {
        oldToken = _oldToken;
        newToken = _newToken;
    }

    //@notice this function is to swap old tokens for new tokens at a 1:1 rate (?) 
    function swap(uint256 swapAmount) public {
        userBalance = IERC20(oldToken).balanceOf(msg.sender);

        if (userBalance < swapAmount) {
            revert('Swap amount exceeds balance');
        }

        IERC20(oldToken).safeTransfer(address.this, swapAmount);

        IERC20(newToken).safeTransfer(msg.sender, swapAmount);
    }

    function approve(address tokenAddress) public {
        IERC20(tokenAddress).approve(address.this, uint256(-1));
    }

    function transfer() external payable {
        uint256 tokens = msg.value.mul(rate);
        token.transfer(msg.sender, tokens);

    }

    // Initializer function (replaces constructor)

    // Send tokens back to the sender using predefined exchange rate
    
}