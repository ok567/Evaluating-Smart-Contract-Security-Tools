pragma solidity ^0.8.0;

// This contract demonstrates a potential Denial of Service (DoS) vulnerability due to the use of revert.
contract DoSWithRevert {
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

    // Function to distribute the contract's balance equally among all users
    function distributeFunds() public {
        // Calculate each user's share of the contract balance
        uint share = address(this).balance / users.length;
        // Loop through all users and attempt to send them their share
        for (uint i = 0; i < users.length; i++) {
            // If sending the share fails, revert the transaction
            if (!payable(users[i]).send(share)) {
                revert("Transfer failed");
            }
        }
    }
}
