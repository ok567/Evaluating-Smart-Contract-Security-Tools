pragma solidity ^0.8.0;

// This contract allows users to vote for candidates and revoke their votes.
contract Voting {
    // Mapping to track whether an address has voted
    mapping(address => bool) public hasVoted;
    // Mapping to track the number of votes each candidate has received
    mapping(uint => uint) public votes;
    // Counter to track the total number of votes cast
    uint public totalVotes;

    // Function to allow users to vote for a candidate
    function vote(uint candidate) public {
        // Ensure the sender has not already voted
        require(!hasVoted[msg.sender], "Already voted.");

        // Mark the sender as having voted
        hasVoted[msg.sender] = true;
        // Increment the vote count for the chosen candidate
        votes[candidate] += 1;
        // Increment the total vote count
        totalVotes += 1;
    }

    // Function to allow users to revoke their vote for a candidate
    function revokeVote(uint candidate) public {
        // Ensure the sender has voted before
        require(hasVoted[msg.sender], "Has not voted yet.");

        // Mark the sender as not having voted
        hasVoted[msg.sender] = false;
        // Decrement the vote count for the chosen candidate
        votes[candidate] -= 1;
        // Decrement the total vote count
        totalVotes -= 1;
    }
}
