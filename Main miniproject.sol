// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20miniproject.sol";

contract ERC20 is IERC20miniproject {
    uint public override totalSupply; // Override pour differencier le state variable of this code and the function of the same name which is in the interface
    mapping(address => uint) public override balanceOf; // takes in the address of the owner and the money. We will use it to chexh the balance of the personn
    mapping(address => mapping(address => uint)) public override allowance; //takes the address of the sender, the second address takes in the address of the receiver and the last part is the amount of the money that the sender has to send
    string public name = "tech4dev";
    string public symbol = "T4D";
    uint8 public decimals = 18;

    function transfer(address recipient, uint amount) external override returns (bool) { 
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount); // the emit is the keyword to implement an event
        return true;
    }
        function approve (address spender, uint amount) external override returns (bool) { // It allows to spend money. It is the bank that allows 
        allowance[msg.sender][spender] = amount; //  It allows to another person to spend  a specific amount of money from my purse. Msg.sender is my purse, spender is the person I allow to take money from my account.Amount is the value.
        emit Approval(msg.sender, spender, amount); // the emit is the keyword to implement the event in the interface
        return true; 
    }

    function transferFrom(address sender,address recipient,uint amount) external override returns (bool) { // When you have multiple account in one bank. 
        allowance[sender][msg.sender] -= amount; // these brackets are arrays where we push values of sender and msg.sender 
        balanceOf[sender] -= amount; // taking or substract from the sender
        balanceOf[recipient] += amount; // adding to recipient 
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external { // Mint is to create more coins
        balanceOf[msg.sender] += amount; // Adding to the account
        totalSupply += amount; // When we add to the account, the totalsupply increases. The total suppply is the amounty of the coins every where in the world
        emit Transfer(address(0), msg.sender, amount); // address is 0  because it's coming to an unknown address to my own address
    }

    function burn(uint amount) external { // To reduce or destroy some of the coins. I reduce the total supply of the coins. They burn to create value. Scarcity  brings value sometimes
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount); // 
    }
}
