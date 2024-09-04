pragma solidity ^0.8.0;

// AdvancedReentrancy is a smart contract that allows users to deposit and withdraw funds.
// This contract has two withdrawal functions, both of which are vulnerable to reentrancy attacks.
contract AdvancedReentrancy {
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
        
        // Attempt to send the requested amount of Ether to the caller.
        // This call is vulnerable to reentrancy attacks because it allows the caller
        // to execute code (including re-calling withdraw) before the state change is made.
        if (msg.sender.call{value: _amount}("")) {
            // Subtract the withdrawn amount from the user's balance only if the transfer was successful.
            // This logic is still vulnerable to reentrancy attacks because the balance update
            // occurs after the Ether transfer.
            balances[msg.sender] -= _amount;
        }
    }

    // Function that allows users to withdraw their entire balance in an emergency.
    function emergencyWithdraw() public {
        // Get the user's balance.
        uint balance = balances[msg.sender];
        
        // Ensure the user has a balance to withdraw.
        require(balance > 0, "No balance to withdraw");
        
        // Attempt to send the user's entire balance back to them
