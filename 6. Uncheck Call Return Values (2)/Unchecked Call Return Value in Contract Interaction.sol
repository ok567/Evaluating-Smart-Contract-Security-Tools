pragma solidity ^0.8.0;

// Interface defining a contract with a receiveFunds function
interface IReceiver {
    function receiveFunds() external payable;
}

// A contract that demonstrates unchecked call return values when interacting with another contract
contract UncheckedCallReturnValueInteraction {
    // Address of the receiver contract
    address public receiverContract;

    // Constructor to set the address of the receiver contract
    constructor(address _receiverContract) {
        receiverContract = _receiverContract;
    }

    // Function to send funds to the receiver contract
    function sendFunds() public payable {
        // Call the receiveFunds function on the receiver contract without checking if the call was successful
        IReceiver(receiverContract).receiveFunds{value: msg.value}();
        // The lack of error handling here could lead to a failure going unnoticed
    }
}
