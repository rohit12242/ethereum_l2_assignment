pragma solidity ^0.5.0;

contract ProductSmart {
    struct Product {
        address Owner;
        string  Id;
        string  Name;
        string  Colour;
        uint    Status;
    }
    
    string[] ProductId;
    mapping(string => Product) products;
    
    event productCreation(string indexed id,string  indexed name,string indexed colour);
    event ownerChanged(string indexed id,address indexed newOwner);
    
    function addProduct(string memory id,string memory name,string memory colour) public {
        products[id].Id=id;
        products[id].Name= name;
        products[id].Colour=colour;
        products[id].Owner=msg.sender;
        products[id].Status=0;
        
        ProductId.push(id);
        emit productCreation(id,name,colour);
    }
    
    function changeProductOwner(string memory id,address to) public {
        require(msg.sender==products[id].Owner,"Only owner can change status");
        products[id].Owner= to;
        emit ownerChanged(id,to);
    }
    
    
    function getProductById(string memory productid) public view returns(address Owner,string memory Id,string memory Name,string memory Colour,uint Status){
            Product memory p = products[productid];
            return (p.Owner,p.Id,p.Name,p.Colour,p.Status);
        
    }
    
    function getProductCounts() public view returns(uint){
        return ProductId.length;
    }
    function getProductByPos(uint index) public view returns(address Owner,string memory Id,string memory Name,string memory Colour,uint Status) {
        Product memory po = products[ProductId[index]];
        return (po.Owner,po.Id,po.Name,po.Colour,po.Status);
    }
}
