// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WarehouseInventory {
    struct Item {
        string name;
        uint quantity;
    }

    mapping(uint => Item) public items;
    uint public count;

    function add(string memory _name, uint _quantity) public {
        // Use require to check valid input
        require(bytes(_name).length > 0, "Item name cannot be empty");
        require(_quantity > 0, "Quantity must be greater than zero");

        count++;
        items[count] = Item(_name, _quantity);
    }

    function remove(uint _itemId, uint _quantity) public {
        require(_itemId > 0 && _itemId <= count, "Invalid item ID");//check if the item exists
        
        Item storage item = items[_itemId];

        if (_quantity > item.quantity) {
            revert("Cannot remove more items than available");
        }
        item.quantity -= _quantity;
    }

    function check() public view {
        // Assert that item count cannot be negative
        assert(count >= 0);
    }
}
