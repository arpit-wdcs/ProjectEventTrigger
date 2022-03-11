//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

contract Ownable{
    address owner;
    
    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(),"Only Owner has access") ;
        _;
    }

    function isOwner()public view returns(bool){
        return(owner==msg.sender);
    }
}