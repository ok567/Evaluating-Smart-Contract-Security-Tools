pragma solidity ^0.8.0;

// A lottery contract that uses a timestamp-dependent randomness source
contract TimestampDependentLottery {
    // Address of the contract manager
    address public manager;
    // Array to store players who entered the lottery
    address[] public players;

    // Constructor sets the manager to the contract deployer
    constructor() {
        manager = msg.sender;
    }

    // Function to enter the lottery by sending Ether
    function enter() public payable {
        // Ensure the player sends at least 0.01 Ether to enter
        require(msg.value > .01 ether, "Minimum Ether not met");
        // Add the sender to the list of players
        players.push(msg.sender);
    }

    // Function to pick a random winner and reset the players array
    function pickWinner() public restricted {
        // Select a random player based on a timestamp-dependent value
        uint index = random() % players.length;
        // Transfer the contract balance to the randomly chosen winner
        payable(players[index]).transfer(address(this).balance);
        // Reset the players array for the next lottery round
        players = new address ; // Corrected syntax
    }

    // Private function to generate a pseudo-random number
    function random() private view returns (uint) {
        // Use block difficulty, timestamp, and players array as sources of randomness
        // This approach is vulnerable to timestamp dependence and can be exploited
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    // Modifier to restrict access to only the manager
    modifier restricted() {
        require(msg.sender == manager, "Caller is not manager");
        _;
    }
}
