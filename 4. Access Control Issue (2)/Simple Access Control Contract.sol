pragma solidity ^0.8.0;

// A simple contract to demonstrate access control by setting a secret value and changing ownership.
contract SimpleAccessControl {
    // The owner of the contract
    address public owner;
    // A secret value that can be set by the owner
    uint public secretValue;

    // Constructor function sets the owner of the contract to the deployer
    constructor() {
        owner = msg.sender;
    }

    // Function to set the secret value, callable by anyone (lacks proper access control)
    function setSecretValue(uint _secretValue) public {
        secretValue = _secretValue;
    }

    // Function to change the owner of the contract, callable by anyone (lacks proper access control)
    function changeOwner(address newOwner) public {
        owner = newOwner;
    }
}
