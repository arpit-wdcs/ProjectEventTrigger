//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

import "./Ownable.sol";
import "./Item.sol";

contract ItemManager is Ownable{

    enum SupplychainState{Created, Paid, Delivered}

    struct S_Item{
        Item _item;
        string _identifier;
        uint   _itemPrice;
        ItemManager.SupplychainState _state;
    }

    mapping(uint =>S_Item) items;
    uint itemIndex;

    event SupplyChainStep(uint _itemIndex,uint _step,address _itemAddress);

    function createItem(string memory _identifier,uint _itemPrice)public onlyOwner{
        Item item = new Item(this,_itemPrice,itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice  = _itemPrice;
        items[itemIndex]._state      = SupplychainState.Created;
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state),address(item));
        itemIndex ++;

    }

    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value,"Only full payment are accepted");
        require(items[_itemIndex]._state == SupplychainState.Created,"items are not created to payment");
        items[_itemIndex]._state = SupplychainState.Paid;

        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state),address(items[_itemIndex]._item));
        

    }

    function triggerDelivery(uint _itemIndex) public onlyOwner {
        require(items[_itemIndex]._state == SupplychainState.Paid,"item in the further in the chain");
        items[_itemIndex]._state = SupplychainState.Delivered;

        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state),address(items[_itemIndex]._item));

    }

}