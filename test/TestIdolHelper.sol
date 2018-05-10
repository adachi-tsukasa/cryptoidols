pragma solidity ^0.4.20;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/IdolFactory.sol";
import "../contracts/IdolHelper.sol";

contract TestIdolHelper {

    uint public initialBalance = 1 ether;

    function beforeEach() public {
        IdolHelper idolHelper = IdolHelper(DeployedAddresses.IdolHelper());
        idolHelper.createIdol("mayu", 16);
    }

    function testLevelUp() public {
        IdolHelper idolHelper = IdolHelper(DeployedAddresses.IdolHelper());

        uint8 expectedLevel = 2;
        uint8 expectedHp = 20;
        uint8 actualLevel = 0;
        uint8 actualHp = 0;
        
        idolHelper.levelUp.value(0.001 ether)(0);

        (,,,actualLevel, actualHp,,,,,,) = idolHelper.getMyIdol(0);
        Assert.equal(uint(actualLevel), uint(expectedLevel), "The IDOL should be levelup for Producer's wallet. Level should have been 2.");
        Assert.equal(uint(actualHp), uint(expectedHp), "The IDOL should be Powerful. HP should have been 20.");
    }
}