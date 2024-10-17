// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LetsToken is ERC20 {
    address public admin;
    mapping(address => bool) public whitelist;

    constructor(uint256 initialSupply) ERC20("LetsCodingToken", "LCT") {
        _mint(msg.sender, initialSupply);
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function addToWhitelist(address _address) public onlyAdmin {
        whitelist[_address] = true;
    }

    function removeFromWhitelist(address _address) public onlyAdmin {
        whitelist[_address] = false;
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(whitelist[msg.sender], "Sender is not whitelisted");
        require(whitelist[recipient], "Recipient is not whitelisted");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        require(whitelist[sender], "Sender is not whitelisted");
        require(whitelist[recipient], "Recipient is not whitelisted");
        return super.transferFrom(sender, recipient, amount);
    }
}