pragma solidity ^0.8.0;

// A contract to simulate a token sale with a potential phishing vulnerability
contract FakeTokenSale {
    // Variable to store the owner of the contract
    address public owner;
    // Mapping to store balances of each address
    mapping(address => uint256) public balances;

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to buy tokens, with the option to send a commission to a referrer
    function buyTokens(address payable _referrer) public payable {
        // Ensure that the sender is sending Ether to buy tokens
        require(msg.value > 0, "Send ETH to buy tokens");

        // Transfer the sent Ether to the referrer
        // Phishing vulnerability: The _referrer address can be controlled by an attacker
        // who could trick users into sending funds to a malicious address.
        _referrer.transfer(msg.value);

        // Calculate the amount of tokens to give based on the Ether sent
        uint256 tokens = msg.value * 100; // Example rate: 1 ETH = 100 tokens
        // Update the sender's balance with the purchased tokens
        balances[msg.sender] += tokens;
    }
}

