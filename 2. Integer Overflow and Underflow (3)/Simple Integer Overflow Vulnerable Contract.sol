pragma solidity ^0.8.0;

// This contract is a simplified version demonstrating overflow issues in balance handling.
contract SimpleOverflow {
    // Mapping to store balances for each address
    mapping(address => uint) public balances;

    // Function to deposit an amount to the sender's balance
    function deposit(uint _amount) public {
        balances[msg.sender] += _amount;  // Potential overflow point
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
