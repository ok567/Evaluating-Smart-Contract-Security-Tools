// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// SimpleReentrancy is a smart contract that allows users to deposit and withdraw funds.
// However, this contract is vulnerable to a reentrancy attack, where an attacker can
// repeatedly call the withdraw function before the previous calls complete, draining the contract's balance.
contract SimpleReentrancy {
    // Mapping to store the balance of each address that interacts with the contract.
    mapping(address => uint) public balances;

    // Function that allows users to deposit Ether into the contract.
    // The deposited amount is added to the sender's balance.
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Function that allows users to withdraw a specified amount of Ether from their balance.
    function withdraw(uint _amount) public {
        // Ensure the user has enough balance to withdraw the requested amount.
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Send the requested amount of Ether to the caller.
        // This call is vulnerable to reentrancy attacks because it allows the caller
        // to execute code (including re-calling withdraw) before the state change is made.
        (bool success, ) = msg.sender.call{value: _amount}("");
        
        // Check that the transfer was successful.
        require(success, "Transfer failed");

        // Subtract the withdrawn amount from the user's balance.
        // This line is executed after the Ether transfer, making the contract vulnerable to reentrancy attacks.
        balances[msg.sender] -= _amount;
    }

    // A helper function that returns the balance of the contract.
    // This is useful for checking how much Ether is stored in the contract.
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
