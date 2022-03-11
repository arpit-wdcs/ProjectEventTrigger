const ItemManger = artifacts.require("./ItemManager.sol");

describe("Item Manager testing",  accounts => {
    ItemManger("it should be allowed to add item", async function(){
        const ItemManagerInstance = await ItemManager.deploy();
        const ItemName = "keyboard";
        const ItemPrice = 100;

        const result = await ItemManagerInstance.createItem(ItemName,ItemPrice,{from: accounts[0]});
        console.log(result);
    })
})