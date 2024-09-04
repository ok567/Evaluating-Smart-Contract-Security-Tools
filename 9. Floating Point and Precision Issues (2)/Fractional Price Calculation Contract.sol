pragma solidity ^0.8.0;

// A contract to calculate the discounted price of an item
contract FractionalPriceCalculation {
    // Variables to store the original price of the item and the discount percentage
    uint256 public itemPrice;
    uint256 public discountPercentage;

    // Constructor to initialize the item price and discount percentage
    constructor(uint256 _itemPrice, uint256 _discountPercentage) {
        itemPrice = _itemPrice;
        discountPercentage = _discountPercentage;
    }

    // Function to calculate and return the discounted price
    function getDiscountedPrice() public view returns (uint256) {
        // Calculate the discount based on the discount percentage
        uint256 discount = (itemPrice * discountPercentage) / 100; // Precision issue: Integer division can cause precision loss
        // Return the item price after applying the discount
        return itemPrice - discount;
    }
}
