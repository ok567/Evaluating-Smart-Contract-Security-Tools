pragma solidity ^0.8.0;

// An auction contract with a fixed end time based on a timestamp
contract TimestampDependentAuction {
    // Address of the highest bidder and value of the highest bid
    address public highestBidder;
    uint public highestBid;
    // Timestamp for the end of the auction
    uint public auctionEnd;

    // Constructor to set the auction end time relative to current block timestamp
    constructor(uint _biddingTime) {
        // Auction end time is set by adding bidding time to current timestamp
        auctionEnd = block.timestamp + _biddingTime;
    }

    // Function to place a bid in the auction
    function bid() public payable {
        // Ensure the auction has not ended
        require(block.timestamp < auctionEnd, "Auction already ended");
        // Ensure the bid is higher than the current highest bid
        require(msg.value > highestBid, "There already is a higher bid");

        // Refund the previous highest bidder
        if (highestBid != 0) {
            payable(highestBidder).transfer(highestBid);
        }

        // Update the highest bid and bidder
        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    // Function to end the auction, can be called only after auction end time
    function endAuction() public {
        require(block.timestamp >= auctionEnd, "Auction not yet ended");
        // Logic to finalize the auction and transfer funds to the owner
    }
}
