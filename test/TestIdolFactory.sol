pragma solidity ^0.4.20;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/IdolFactory.sol";

contract TestIdolFactory {

    function testCreateAndGetMyIdol() public {
        IdolFactory idolFactory = IdolFactory(DeployedAddresses.IdolFactory());
        
        string memory expecetedName = "mayu";
        uint8 expectedAge = 16;
        uint8 expectedLevel = 1;
        uint8 expectedHp = 10;

        string memory actualName = "";
        uint8 actualAge;
        uint8 actualLevel;
        uint8 actualHp;

        idolFactory.createIdol(expecetedName, expectedAge);
        (actualName,,actualAge,actualLevel,actualHp,,,,,,) = idolFactory.getMyIdol(0);
        Assert.equal(actualName, expecetedName, "Producer should has idol, idol's name is 'mayu'. ");
        Assert.equal(uint(actualAge), uint(expectedAge), "Producer should has idol, idol's age is 16. ");
        Assert.equal(uint(actualLevel), uint(expectedLevel), "Producer should has idol, idol is just born.");
        Assert.equal(uint(actualHp), uint(expectedHp), "Producer should has idol, idol is just born.");
    }

    function testCreateIdolAndGetMyIdolDetail() public {
        IdolFactory idolFactory = IdolFactory(DeployedAddresses.IdolFactory());
        
        string memory expecetedName = "mayu";
        uint8 expectedAge = 16;
        uint expectedZero = 0;

        uint16 actualWinCount;
        uint16 actualLoseCount;
        uint32 actualReadyTime;
        uint32 actualVocalLessonPoint;
        uint32 actualDanceLessonPoint;
        uint32 actualVisualLessonPoint;

        idolFactory.createIdol(expecetedName, expectedAge);
        (,,,,, actualWinCount,actualLoseCount,actualReadyTime,
            actualVocalLessonPoint,actualDanceLessonPoint,actualVisualLessonPoint) = idolFactory.getMyIdol(0);
        Assert.equal(uint(actualWinCount), expectedZero, "Producer should has idol, idol is just born.");
        Assert.equal(uint(actualLoseCount), expectedZero, "Producer should has idol, idol is just born.");
        Assert.equal(uint(actualReadyTime), expectedZero, "Producer should has idol, idol is just born.");
        Assert.equal(uint(actualVocalLessonPoint), expectedZero, "Producer should has idol, idol is just born.");
        Assert.equal(uint(actualDanceLessonPoint), expectedZero, "Producer should has idol, idol is just born.");
        Assert.equal(uint(actualVisualLessonPoint), expectedZero, "Producer should has idol, idol is just born.");
        
    }
}