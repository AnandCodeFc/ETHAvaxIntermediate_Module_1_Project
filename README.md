# Metacrafters Eth_Avax Intermediate Module 1 Errors and Function 

## WarehouseInventory

## Overview
The `WarehouseInventory` smart contract is a Solidity-based contract designed to manage an inventory system for a warehouse. It allows users to add items with specified quantities, remove quantities of existing items, and perform integrity checks on the item count. The contract ensures basic validation and data consistency, making it suitable as a foundational example for inventory management on the blockchain.

## Prerequisites
- Solidity ^0.8.0
- Ethereum development environment (e.g., Hardhat, Truffle, or Remix)

## Features
- **Add Items:** Add new items with a specified name and quantity.
- **Remove Items:** Decrease the quantity of an existing item by a specified amount.
- **Check Inventory:** Ensures that the item count remains non-negative.

## Contract Explanation

```solidity
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
```

### Contract Name: `WarehouseInventory`

The contract is implemented in Solidity and uses the **MIT License** for open-source distribution.

### 1. `struct Item`
The `Item` structure represents an item in the warehouse inventory, defined by two properties:
- `name`: A `string` that holds the name of the item.
- `quantity`: A `uint` that represents the number of units available for that item.

### 2. `mapping(uint => Item) public items`
This mapping stores the items in the inventory using a unique `uint` ID as a key, which maps to the `Item` structure. This allows efficient retrieval and storage of items using their IDs.

### 3. `uint public count`
The `count` variable tracks the total number of items added to the inventory. It serves as an identifier for newly added items and helps maintain the order of item IDs.

### 4. `function add(string memory _name, uint _quantity) public`
This function allows users to add a new item to the inventory.

- **Parameters:**
  - `_name`: The name of the item (must be non-empty).
  - `_quantity`: The quantity of the item to be added (must be greater than zero).

- **Logic:**
  - Uses `require` statements to ensure:
    - `_name` is not an empty string (`bytes(_name).length > 0`).
    - `_quantity` is greater than zero.
  - Increments `count` to assign a new ID to the item.
  - Stores the `Item` struct in the `items` mapping using `count` as the key.

### 5. `function remove(uint _itemId, uint _quantity) public`
This function allows users to remove a specified quantity of an existing item from the inventory.

- **Parameters:**
  - `_itemId`: The ID of the item to be updated (must be a valid ID).
  - `_quantity`: The number of units to be removed.

- **Logic:**
  - Uses a `require` statement to ensure that `_itemId` is valid (i.e., greater than zero and less than or equal to `count`).
  - Retrieves the item using the `_itemId`.
  - Uses a conditional `if` statement with `revert` to ensure that the requested quantity to remove does not exceed the current available quantity.
  - Decreases the `quantity` of the specified item by `_quantity`.

### 6. `function check() public view`
This function checks the integrity of the item count.

- **Logic:**
  - Uses an `assert` statement to verify that the `count` variable is non-negative.
  - This function acts as a safeguard to ensure that the contract's state remains consistent during execution.

### Security Considerations
- **Input Validation:** The `add` and `remove` functions use `require` statements to validate inputs, ensuring that the inventory remains accurate.
- **Data Integrity:** The `check` function uses an `assert` to confirm the integrity of the `count` variable, preventing negative values that could indicate a logic error.
- **Revert Condition:** The `remove` function uses `revert` when attempting to remove more items than are available, ensuring that inventory levels are not improperly reduced.

## Usage
1. **Deploy the Contract**: Deploy the `WarehouseInventory` contract to an Ethereum-compatible blockchain using your preferred development environment.
2. **Add Items**: Call the `add` function with the desired item name and quantity to add new items.
3. **Remove Items**: Call the `remove` function with the item's ID and the quantity to decrease the inventory.
4. **Check Integrity**: Use the `check` function to ensure that the item count remains non-negative.

## Disclaimer
This contract is a simplified demonstration for managing a warehouse inventory and should not be used in production without further security reviews and testing.
