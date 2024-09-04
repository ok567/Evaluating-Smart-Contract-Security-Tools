pragma solidity ^0.8.0;

// A contract that demonstrates unchecked call return values and its potential issues
contract UncheckedCallReturnValue {
    // Mapping to store balances of each address
    mapping(address => uint) public balances;

    // Function to deposit Ether into the sender's balance
    function deposit() public payable {
        // Increase the sender's balance by the deposited amount
        balances[msg.sender] += msg.value;
    }

    // Function to withdraw a specified amount of Ether from the sender's balance
    function withdraw(uint _amount) public {
        // Check if the sender has enough balance to withdraw
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Attempt to send the specified amount to the sender
        // Unchecked call return value could lead to unnoticed failures
        (bool sent, ) = msg.sender.call{value: _amount}("");
        if (sent) {
            // Decrement the sender's balance only if the transfer was successful
            balances[msg.sender] -= _amount;
        }
        // Lack of error handling could cause logical errors if the transfer fails
    }
}
