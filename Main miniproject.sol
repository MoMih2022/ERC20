// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0; //specify the Solidity version the compiler should use to build our code

import "./IERC20miniproject.sol"; // import the interface file named IERC20miniproject.sol

contract ERC20 is IERC20miniproject { // Creation of the contract
    uint public override totalSupply; // "Override" to differentiate the state variable of this code and the function of the same name that is in the interface. We create a state variable total supply which is the number of existing tokens 
    mapping(address => uint) public override balanceOf; // takes in the address of the owner and the money. We will use it to check the balance of the caller
    mapping(address => mapping(address => uint)) public override allowance; //takes the address of the sender, the second address takes in the address of the receiver and the last part is the amount that the sender has to send
    string public name = "tech4dev"; // name of the token
    string public symbol = "T4D"; // Symbol of teh token
    uint8 public decimals = 18; // number of decimals

    function transfer(address recipient, uint amount) external override returns (bool) { //Moves the amount of tokens from the function caller address (msg.sender) to the recipient address.  
        balanceOf[msg.sender] -= amount;  // taking or substract from the caller 
        balanceOf[recipient] += amount; // Takes the same amount took from the caller balance and adds in the recipient's balance
        emit Transfer(msg.sender, recipient, amount); // the emit is the keyword to implement an event. This line specifies that the function emits the Transfer event
        return true; // It returns true if the transfer was possible.
    }
        function approve (address spender, uint amount) external override returns (bool) { // It allows to spend money. Set the amount of allowance the spender is allowed to transfer from the function caller (msg.sender) balance. 
        allowance[msg.sender][spender] = amount; //  It allows to another person to spend  a specific amount of money from my purse. Msg.sender is my purse, spender is the person I allow to take money from my account.Amount is the value.
        emit Approval(msg.sender, spender, amount); // the emit is the keyword to implement the event in the interface. This function emits the Approval event. 
        return true; // The function returns whether the allowance was successfully set.
    }

    function transferFrom(address sender,address recipient,uint amount) external override returns (bool) { // When you have multiple accounnts: Moves the amount of tokens from sender to recipient using the allowance mechanism. amount is then deducted from the caller’s allowance. 
        allowance[sender][msg.sender] -= amount; // these brackets are arrays where we push values of sender and msg.sender 
        balanceOf[sender] -= amount; // taking or substract from the sender
        balanceOf[recipient] += amount; // adding to recipient 
        emit Transfer(sender, recipient, amount); // This function emits the Transfer event. 
        return true;  // It returns true if the transfer was possible.
    }

    function mint(uint amount) external { // Mint means to create more coins
        balanceOf[msg.sender] += amount; // Adding to the account a specific ammount to the caller's balane
        totalSupply += amount; // When we add an amount to the account, the totalsupply increases. The total suppply is the amount of the coins every where in the world
        emit Transfer(address(0), msg.sender, amount); // address is 0  because it's coming from an unknown address to the caller's address
    }

    function burn(uint amount) external { // means to reduce or destroy some of the coins. They burn to create value. Scarcity  brings value sometimes
        balanceOf[msg.sender] -= amount; // Destroys a specific amount from the caller's balance
        totalSupply -= amount; // The same amount destroyed from he caller's balance is substracted from the total supply. It reduces total supply of the coins.
        emit Transfer(msg.sender, address(0), amount); // // address is 0  because it's going to nowhere, to an unexisting address
    }
}
