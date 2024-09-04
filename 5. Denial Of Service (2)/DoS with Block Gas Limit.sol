// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract demonstrates a potential Denial of Service (DoS) vulnerability due to block gas limit.
contract DoSWithBlockGasLimit {
    // Mapping to track balances of each user
    mapping(address => uint) public balances;
    // Array to keep track of users
    address[] public users;

    // Function to deposit Ether into the sender's balance and add the sender to the user list
    function deposit() public payable {
        // Increment the sender's balance by the deposited amount
        balances[msg.sender] += msg.value;
        // Add the sender to the list of users
        users.push(msg.sender);
    }

    // Function to withdraw the entire balance of the sender
    function withdraw() public {
        // Ensure the sender has a positive balance
        require(balances[msg.sender] > 0, "No balance to withdraw");
        // Get the amount to withdraw
        uint amount = balances[msg.sender];
        // Reset the sender's balance to zero
        balances[msg.sender] = 0;
        // Transfer the amount to the sender
        payable(msg.sender).transfer(amount);
    }

    // Function to clear all user balances and the user list
    function clearUsers() public {
        // Loop through all users and reset their balances to zero
        for (uint i = 0; i < users.length; i++) {
            balances[users[i]] = 0;
        }
        // Delete the user list
        delete users;
    }
}
