pragma solidity ^0.4.20;

import "./IdolFactory.sol";

contract OwnerHelper is IdolFactory {

    function withdraw() external onlyOwner {
        owner.transfer(address(this).balance);
    }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

}