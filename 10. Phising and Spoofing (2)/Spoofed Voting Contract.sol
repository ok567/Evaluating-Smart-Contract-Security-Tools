pragma solidity ^0.8.0;

// A contract to simulate a voting process with a potential spoofing vulnerability
contract SpoofedVoting {
    // Variable to store the owner of the contract
    address public owner;
    // Mapping to track whether an address has voted or not
    mapping(address => bool) public hasVoted;
    // Mapping to count votes for each proposal
    mapping(uint256 => uint256) public votes;

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to allow users to vote for a specific proposal
    function vote(uint256 proposal) public {
        // Ensure the sender has not already voted
        require(!hasVoted[msg.sender], "You have already voted");

        // Register the sender's vote
        hasVoted[msg.sender] = true;
        // Increment the vote count for the specified proposal
        votes[proposal] += 1;

        // Spoofing vulnerability: No validation on the origin of the message
        // This allows a malicious contract to impersonate legitimate voters,
        // potentially leading to vote manipulation or fraud.
    }
}
