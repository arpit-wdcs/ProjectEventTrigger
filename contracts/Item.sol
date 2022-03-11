//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

import "./Ownable.sol";
import "./ItemManager.sol";


contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager __parentContract, uint _priceInWei, uint _index){
        priceInWei = _priceInWei;
        index = _index;
        parentContract = __parentContract;
    }

    receive() external payable {
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value,"only full payments allowed");
        pricePaid += msg.value;
        (bool success,) = address(parentContract).call{value:(msg.value)}(abi.encodeWithSignature( "triggerPayment(uint256)",index));
        require(success,"this transcation wasn't successfull, calceling");
    }

    fallback() external {}
}
