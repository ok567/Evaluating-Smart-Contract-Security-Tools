// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract demonstrates both potential overflow and underflow issues with balances.
contract OverflowUnderflow {
    // Mapping to store balances for each address
    mapping(address => uint) public balances;

    // Function to deposit an amount to the sender's balance
    function deposit(uint _amount) public {
        balances[msg.sender] += _amount;  // Potential overflow point
    }

    // Function to reward the sender with an additional amount
    function reward(uint _amount) public {
        balances[msg.sender] += _amount;  // Potential overflow point
    }

    // Function to penalize the sender by subtracting an amount
    // This could cause underflow if not checked properly
    function penalize(uint _amount) public {
        balances[msg.sender] -= _amount;  // Potential underflow point
    }

    // Function to withdraw an amount from the sender's balance
    // Ensures the sender has enough balance before proceeding
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
    }

    // Function to transfer an amount from the sender's balance to another address
    // Checks for sufficient balance before proceeding
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;  // Potential overflow point
    }

    // Helper function to check the balance of a specific address
    function getBalance(address _addr) public view returns (uint) {
        return balances[_addr];
    }
}
