// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    mapping(address => uint256) public balances;

    event Deposited(address indexed account, uint256 amount);
    event Withdrawn(address indexed account, uint256 amount);

    // Deposit function
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw function
    function withdraw() public {
        uint256 amountToWithdraw = balances[msg.sender];
        require(amountToWithdraw > 0, "Insufficient balance to withdraw.");

        // Send Ether back to sender
        (bool sent, ) = msg.sender.call{value: amountToWithdraw}("");
        require(sent, "Failed to send Ether");

        // Reset balance
        balances[msg.sender] = 0;

        emit Withdrawn(msg.sender, amountToWithdraw);
    }
}
