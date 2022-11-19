// contracts/TokenExchange.sol
pragma solidity ^0.8;

// Import base Initializable contract
import "@openzeppelin/upgrades/contracts/Initializable.sol";

// Import the IERC20 interface and and SafeMath library
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract TokenExchange is Initializable {
    using SafeMath for uint256;

    // Contract state: exchange rate and token
    uint256 public rate;
    IERC20 public token;

    // Initializer function (replaces constructor)
    function initialize(uint256 _rate, IERC20 _token) public initializer {
        rate = _rate;
        token = _token;
    }

    // Send tokens back to the sender using predefined exchange rate
    function() external payable {
        uint256 tokens = msg.value.mul(rate);
        token.transfer(msg.sender, tokens);
    }
}