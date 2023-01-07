// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attacker {
   constructor() {
       assembly{
           mstore(0,0x602a60005260206000f3) // assmbly runtime code to store 42 and return it
           return(0x16,0x0a) // return the runtime code
       }
   }
}

