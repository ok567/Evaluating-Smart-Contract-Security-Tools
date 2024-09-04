pragma solidity ^0.8.0;

// This contract represents a simple crowdsale with a funding goal.
contract Crowdsale {
    // The funding goal for the crowdsale
    uint public fundingGoal;
    // The total amount raised from contributions
    uint public amountRaised;
    // A mapping to track the contribution balance of each address
    mapping(address => uint) public balanceOf;

    // Constructor to initialize the funding goal for the crowdsale
    constructor(uint _fundingGoal) {
        fundingGoal = _fundingGoal;
    }

    // Function to allow users to contribute funds to the crowdsale
    function contribute() public payable {
        // Increment the balance of the contributor by the sent value
        balanceOf[msg.sender] += msg.value;
        // Increment the total amount raised by the sent value
        amountRaised += msg.value;
    }

    // Function to allow users to withdraw their funds if the funding goal is reached
    function withdraw() public {
        // Check if the funding goal has been reached
        require(amountRaised >= fundingGoal, "Funding goal not reached.");
        // Get the amount contributed by the sender
        uint amount = balanceOf[msg.sender];
        // Reset the sender's contribution balance to zero
        balanceOf[msg.sender] = 0;
        // If the sender has contributed, transfer their contribution back to them
        if (amount > 0) {
            payable(msg.sender).transfer(amount);
        }
    }
}
