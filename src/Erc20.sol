// SPDX-License-Identifier: MIT

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.13;

contract Erc20 is  ERC20{
   constructor() ERC20("Liam Token", "LTK") {
       
   }
}