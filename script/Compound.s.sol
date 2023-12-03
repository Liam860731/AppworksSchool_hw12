// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import { CErc20Delegator } from "../src/CErc20Delegator.sol";
import { Comptroller, ComptrollerInterface  } from "../src/Comptroller.sol";
import { WhitePaperInterestRateModel } from "../src/WhitePaperInterestRateModel.sol";
import { CErc20Delegate } from "../src/CErc20Delegate.sol";
import { SimplePriceOracle } from "../src/SimplePriceOracle.sol";
import { Erc20 } from "../src/Erc20.sol";
import { Unitroller } from "../src/Unitroller.sol";

contract CompoundScript is Script {
    CErc20Delegator public cErc20Delegator;
    CErc20Delegate public implementation;
    Comptroller public comptroller;
    WhitePaperInterestRateModel public interestRateModel;
    SimplePriceOracle public oracle;
    Erc20 public liamToken;
    Unitroller public unitroller;  

    function run() public {
        vm.startBroadcast();
        comptroller = new Comptroller();
        interestRateModel = new WhitePaperInterestRateModel(0,0);
        implementation = new CErc20Delegate();
        liamToken = new Erc20();
        oracle = new SimplePriceOracle();
        unitroller = new Unitroller();

        unitroller._setPendingImplementation(address(comptroller));
        comptroller._become(unitroller);
        comptroller._setPriceOracle(oracle);

        cErc20Delegator = new CErc20Delegator(
                address(liamToken),
                Comptroller(comptroller),
                WhitePaperInterestRateModel(interestRateModel),
                1*10**18,
                "Compound Liam Token",
                "cLTKN",
                18,
                payable(msg.sender),
                address(implementation),
                new bytes(0)
        );

        vm.stopBroadcast();
    }
}
