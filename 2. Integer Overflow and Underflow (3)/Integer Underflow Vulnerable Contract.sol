pragma solidity ^0.8.0;

// This contract demonstrates a simple staking system with potential for underflow issues.
contract SimpleUnderflow {
    // Mapping to store the stake amounts for each address
    mapping(address => uint) public stakes;

    // Function to allow users to add to their stake
    function stake(uint _amount) public {
        stakes[msg.sender] += _amount;
    }

    // Function to allow users to withdraw their stake
    // This could cause underflow if not checked properly
    function withdrawStake(uint _amount) public {
        require(stakes[msg.sender] >= _amount, "Insufficient stake");
        stakes[msg.sender] -= _amount;  // Potential underflow point
    }

    // Function to allow users to transfer their stake to another address
    // This could also cause underflow if the balance is insufficient
    function transferStake(address _to, uint _amount) public {
        require(stakes[msg.sender] >= _amount, "Insufficient stake");
        stakes[msg.sender] -= _amount;  // Potential underflow point
        stakes[_to] += _amount;
    }

    // Helper function to check the stake balance of a specific address
    function getStake(address _addr) public view returns (uint) {
        return stakes[_addr];
    }
}
