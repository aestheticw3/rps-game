// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

// ПЕРЕОРГАНИЗОВАТЬ РЕПОЗИТОРИИ

contract Rps {
    address public owner;

    constructor() {
        owner = msg.sender;
    }
}
