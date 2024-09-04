pragma solidity ^0.8.0;

// A contract to distribute tokens among multiple recipients based on percentages
contract TokenDistribution {
    // Mapping to store balances of each address
    mapping(address => uint256) public balances;
    // Variable to store the total supply of tokens
    uint256 public totalSupply;

    // Constructor to initialize the total supply of tokens and assign it to the contract deployer
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balances[msg.sender] = _initialSupply;
    }

    // Function to distribute tokens to recipients based on the given percentages
    function distributeTokens(address[] memory recipients, uint256[] memory percentages) public {
        // Ensure the number of recipients matches the number of percentages
        require(recipients.length == percentages.length, "Recipients and percentages arrays must be the same length");

        // Loop through each recipient to distribute tokens
        for (uint256 i = 0; i < recipients.length; i++) {
            // Calculate the amount of tokens to distribute based on the percentage
            uint256 amount = (totalSupply * percentages[i]) / 100; // Precision issue: Integer division can cause precision loss
            // Decrement the sender's balance
            balances[msg.sender] -= amount;
            // Increment the recipient's balance
            balances[recipients[i]] += amount;
        }
    }
}
