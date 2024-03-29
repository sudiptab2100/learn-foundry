// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function test_ModExp() public {
        // Verified from online calculator: https://www.dcode.fr/modular-exponentiation
        uint256 b = 81393320028874372971506050608887649831479533935234032636905594932227643625162;
        uint256 e = 35444162570359240694477526306393672083901136362216370936455275143503774375818;
        uint256 m = 34033936381220136781619490036994710610930251007014272201359535359609752889937;
        uint256 expected = 8904919252717246298510997806261208748307791719112493033822644872388079328686; // (b ** e) % m;
        uint256 result = counter.modExp(b, e, m);
        assertEq(result, expected);
    }
    
    function test_MudMult() public {
        // Verified from online calculator: https://planetcalc.com/8326/
        uint256 x = 81393320028874372971506050608887649831479533935234032636905594932227643625162;
        uint256 y = 35444162570359240694477526306393672083901136362216370936455275143503774375818;
        uint256 k = 34033936381220136781619490036994710610930251007014272201359535359609752889937;
        uint256 expected = 15883914155651364811892805982070488447113087144864895402817182354353227961462; // (x * y) % k;
        uint256 result = counter.mudMult(x, y, k);
        assertEq(result, expected);
    }

    function test_genHash() public {
        uint256 g = 52279513852451702160234370850105634868216222738374387234391881619514063939407;
        uint256 y = 52818641055238316610718595893565165252070645169495875782212820669243949584325;
        uint256 t = 46149910859312709216557877933346236465193674762570859014909684950458342885087;
        uint256 expected = 90763749166379030793800552444849410710405418652264153459311066418431809667586;
        uint256 result = counter.genHash(g, y, t);
        assertEq(result, expected);
    }
}
