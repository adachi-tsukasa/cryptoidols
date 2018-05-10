pragma solidity ^0.4.20;

import "./IdolFactory.sol";

contract IdolHelper is IdolFactory {

    function levelUp(uint _id) external payable onlyOwnerOf(_id) {
        require(msg.value == levelUpFee);
        allIdol[_id].level++;
        allIdol[_id].hp += 10;
    }

    function isReady(Idol storage _idol) internal view returns (bool) {
        return (_idol.readyTime <= now);
    }
    
    function initializeReadyTime(Idol storage _idol) internal {
        _idol.readyTime = uint32(now + cooldownTime);
    }

    function triggerCooldown(Idol storage _idol) internal {
        _idol.readyTime = uint32(now + cooldownTime);
    }

}