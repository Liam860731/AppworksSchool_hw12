// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20{
   constructor() ERC20("Token A", "LTKA") {
       
   }
}

contract TokenB is ERC20{
   constructor() ERC20("Token B", "LTKB") {
   }
}