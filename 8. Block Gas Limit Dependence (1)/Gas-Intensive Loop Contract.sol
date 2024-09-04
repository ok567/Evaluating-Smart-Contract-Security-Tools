pragma solidity ^0.8.0;

// A contract that demonstrates a potential gas limit issue due to processing a large array
contract GasIntensiveLoop {
    // Array to store a large number of integers
    uint[] public largeArray;
    // Variable to keep track of the last processed index
    uint public lastIndex;

    // Constructor initializes the array with a specified size
    constructor(uint _size) {
        // Populate the array with values from 0 to _size - 1
        for (uint i = 0; i < _size; i++) {
            largeArray.push(i);
        }
    }

    // Function to process the array in a gas-efficient manner
    function processArray() public {
        // Record the starting gas available
        uint startGas = gasleft();
        uint i;

        // Loop through the array from the last processed index
        for (i = lastIndex; i < largeArray.length; i++) {
            // Increment each element of the array
            largeArray[i] = largeArray[i] + 1;

            // Check if more than half of the block's gas limit has been used
            if (startGas - gasleft() > block.gaslimit / 2) {
                break; // Exit the loop to avoid out-of-gas exception
            }
        }

        // Update the last processed index to resume from next time
        lastIndex = i;
    }
}
