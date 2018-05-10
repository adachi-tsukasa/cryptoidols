pragma solidity ^0.4.20;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/IdolFactory.sol";
import "../contracts/IdolHelper.sol";
import "../contracts/IdolWork.sol";

contract TestIdolWork {

    // function beforeEach() public {
    //     IdolWork idolWork = IdolWork(DeployedAddresses.IdolWork());
    //     idolWork.createIdol("mayu", 16);
    // }

    function testStartVocalLesson() public {
        IdolWork idolWork = IdolWork(DeployedAddresses.IdolWork());
        idolWork.createIdol("mayu", 16);
        uint32 actualVocalLessonPoint = 0;
        bool result;

        result = idolWork.startVocalLesson(0);
        (,,,,,,,,actualVocalLessonPoint,,) = idolWork.getMyIdol(0);

        if (result) {
            Assert.equal(uint(actualVocalLessonPoint), 1, "");
        } else {
            Assert.equal(uint(actualVocalLessonPoint), 0, "");
        }
    }

    function testStartDanceLesson() public {
        IdolWork idolWork = IdolWork(DeployedAddresses.IdolWork());
        idolWork.createIdol("mayu", 16);
        uint32 actualDanceLessonPoint = 0;
        bool result;

        result = idolWork.startDanceLesson(1);
        (,,,,,,,,,actualDanceLessonPoint,) = idolWork.getMyIdol(1);

        if (result) {
            Assert.equal(uint(actualDanceLessonPoint), 1, "");
        } else {
            Assert.equal(uint(actualDanceLessonPoint), 0, "");
        }
    }

    function testStartVisualLesson() public {
        IdolWork idolWork = IdolWork(DeployedAddresses.IdolWork());
        idolWork.createIdol("mayu", 16);
        uint32 actualVisualLessonPoint = 0;
        bool result;

        result = idolWork.startVisualLesson(2);
        (,,,,,,,,,,actualVisualLessonPoint) = idolWork.getMyIdol(2);

        if (result) {
            Assert.equal(uint(actualVisualLessonPoint), 1, "");
        } else {
            Assert.equal(uint(actualVisualLessonPoint), 0, "");
        }
    }

}