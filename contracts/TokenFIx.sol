pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract TokenFix {
    using SafeERC20 for IERC20;

    error OnlyAdmin();

    IERC20 public immutable oldToken;
    IERC20 public immutable newToken;
    address public admin;

    event tokenClaimed(address indexed claimer, uint256 claimAmount);
    event adminUpdated(address indexed oldAdmin, address indexed newAdmin);

    constructor(IERC20 _oldToken, IERC20 _newToken, address _admin) {
        oldToken = _oldToken;
        newToken = _newToken;
        admin = _admin;
    }

    //@notice this function is to swap old tokens for new tokens at a 1:1 rate
    function swap(uint256 swapAmount) external {
        oldToken.safeTransferFrom(msg.sender, address(this), swapAmount);

        newToken.safeTransferFrom(address(this), msg.sender, swapAmount);

        emit tokenClaimed(msg.sender, swapAmount);
    }

    //**ADMIN FUNCTIONS**

    function _setAdmin(address _newAdmin) external {
        address oldAdmin = admin;
        if (msg.sender != oldAdmin) { revert OnlyAdmin(); }
        admin = _newAdmin;
        emit adminUpdated(oldAdmin, _newAdmin);
    }

    function _adminTransferAll() external {
        if (msg.sender != admin) { revert OnlyAdmin(); }
        IERC20 _newToken = newToken;
        _newToken.safeTransferFrom(
            address(this),
            msg.sender,
            _newToken.balanceOf(address(this))
        );
    }

    function _adminTransfer(uint256 amount) external {
        if (msg.sender != admin) { revert OnlyAdmin(); }
        newToken.safeTransferFrom(address(this), msg.sender, amount);
    }
}
