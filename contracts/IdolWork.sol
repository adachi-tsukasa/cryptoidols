pragma solidity ^0.4.20;

import "./IdolHelper.sol";

contract IdolWork is IdolHelper {

    uint workSuccessProbability = 5;
    uint8 powerOfLesson = 5; 

    modifier useHpForLesson(uint _id) {
        uint currentHp = allIdol[_id].hp;
        require(currentHp - powerOfLesson >= 0);
        _;
    }

    modifier useHpForLive(uint _id) {
        uint hp = allIdol[_id].hp - 15;
        require(allIdol[_id].hp >= 0);
        _;
    }

    function startVocalLesson(uint _id) external useHpForLesson(_id) returns (bool) {
        Idol storage idol = allIdol[_id];
        _commonLesson(idol);
        if (_isSuccess()) {
            idol.vocalLessonPoint++;
            return true;
        }
        triggerCooldown(idol);
        return false;
    }

    function startDanceLesson(uint _id) external useHpForLesson(_id) returns (bool) {
        Idol storage idol = allIdol[_id];
        _commonLesson(idol);
        if (_isSuccess()) {
            idol.danceLessonPoint++;
            return true;
        }
        triggerCooldown(idol);
        return false;
    }

    function startVisualLesson(uint _id) external useHpForLesson(_id) returns (bool) {
        Idol storage idol = allIdol[_id];
        _commonLesson(idol);
        if (_isSuccess()) {
            allIdol[_id].visualLessonPoint++;
            return true;
        }
        triggerCooldown(idol);
        return false;
    }
    
    function _commonLesson(Idol storage _idol) private {
        if (!_isFirstTimeLesson(_idol)) {
            require(isReady(_idol));
        }
        _idol.hp -= powerOfLesson;
    }

    function _isSuccess() private view returns(bool) {
        uint rand = uint(blockhash(block.number-1))%10 + 1;
        if (rand <= workSuccessProbability) {
            return true;
        }
        return false;
    }
    
    function _isFirstTimeLesson(Idol storage _idol) private returns (bool) {
        if (_idol.readyTime == 0) {
            initializeReadyTime(_idol);
            return true;
        } else {
            return false;
        }
    }
    
    // FIXME:
    // function startLive(uint _id) private useHpForLive(_id) {
    //     if (_isSuccess()) {
    //         allIdol[_id].vocalLessonPoint++;
    //         allIdol[_id].danceLessonPoint++;
    //         allIdol[_id].visualLessonPoint++;
    //     }
    // }
}