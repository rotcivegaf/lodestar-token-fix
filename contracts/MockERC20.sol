pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20("TEST", "TEST") {
    function mint(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }
}
