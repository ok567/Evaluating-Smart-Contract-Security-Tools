pragma solidity ^0.8.0;

// This contract represents a simple auction where users can place bids.
contract SimpleAuction {
    // The address of the current highest bidder
    address public highestBidder;
    // The value of the highest bid placed
    uint public highestBid;

    // Function to allow users to place a bid
    function bid() public payable {
        // Ensure the bid is higher than the current highest bid
        require(msg.value > highestBid, "There already is a higher bid.");
        
        // If there was a previous bid, refund the previous highest bidder
        if (highestBid != 0) {
            payable(highestBidder).transfer(highestBid);
        }

        // Update the highest bidder to the current sender
        highestBidder = msg.sender;
        // Update the highest bid to the current bid amount
        highestBid = msg.value;
    }
}
