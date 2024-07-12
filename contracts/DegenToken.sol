// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    
    mapping(address => string[]) private purchases;

    constructor() ERC20("Degen", "DGN") {}

    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public override {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
    }
    
    function transferTokens(address to, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, to, amount);
    }

    function StoreItems() public pure returns(string memory){
        return"Items to Purchase: 1.Sword [100 DGN],2.Shield [50 DGN],3. Healing Potion[10 DGN] ";
    }

    function redeemItems(uint id) public {
        require(id <= 3, "Wrong Option Selected!!");

        if (id == 1) {
            require(balanceOf(msg.sender) >= 100, "Insufficient Tokens");
            _burn(msg.sender, 100);
            purchases[msg.sender].push("Sword");
        } else if (id == 2) {
            require(balanceOf(msg.sender) >= 50, "Insufficient Tokens");
            _burn(msg.sender, 50);
            purchases[msg.sender].push("Shield");
        } else if (id == 3) {
            require(balanceOf(msg.sender) >= 10, "Insufficient Tokens");
            _burn(msg.sender, 10);
            purchases[msg.sender].push("Healing Potion");
        }
    }

    function myPurchases() public view returns (string[] memory) {
        return purchases[msg.sender];
    }
    
}

