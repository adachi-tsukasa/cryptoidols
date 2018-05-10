pragma solidity ^0.4.20;

import "./Ownable.sol";

contract IdolFactory is Ownable {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 6 hours;

    uint levelUpFee = 0.001 ether;

    event IdolCreated(address indexed _address, string name);
    event IdolDestroyed(address indexed _address);
    
    struct Idol {
        string name;
        uint dna;
        uint8 age;
        uint8 level;
        uint8 hp;
        uint16 winCount;
        uint16 loseCount;
        uint32 readyTime;
        uint32 vocalLessonPoint;
        uint32 danceLessonPoint;
        uint32 visualLessonPoint;
    }
    
    Idol[] public allIdol;
    mapping (uint => address) idolToProducer;
    mapping (address => uint) producerToIdol;
    // mapping (address => uint) producerIdolCount;

    modifier onlyOwnerOf(uint _id) {
        require(msg.sender == idolToProducer[_id]);
        _;
    }

    
    function createIdol(string _name, uint8 _age) external {
        require(!idolExists(msg.sender));
        Idol memory idol;
        idol.name = _name;
        idol.dna = _createDna(_name);
        idol.age = _age;
        idol.level = 1;
        idol.hp = 10;
        idol.winCount = 0;
        idol.loseCount = 0;
        idol.readyTime = 0;
        idol.vocalLessonPoint = 0;
        idol.danceLessonPoint = 0;
        idol.visualLessonPoint = 0;

        uint id = allIdol.push(idol) - 1;
        idolToProducer[id] = msg.sender;
        producerToIdol[msg.sender] = id;
        // producerIdolCount[msg.sender]++;

        emit IdolCreated(msg.sender, _name);
    }

    function getMyIdol(uint _id) view external onlyOwnerOf(_id) 
        returns(string, uint, uint8, uint8, uint8, uint16, uint16, uint32, uint32, uint32, uint32) {
        Idol memory idol = allIdol[_id];
        return (idol.name, idol.dna, idol.age, idol.level, idol.hp, 
            idol.winCount, idol.loseCount, idol.readyTime, idol.vocalLessonPoint, idol.danceLessonPoint, idol.visualLessonPoint);
    }
    
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str, now));
        return rand % dnaModulus;
    }

    function _createDna(string _name) private view returns (uint){
        uint randDna = _generateRandomDna(_name);
        return randDna - randDna % 100;

    }

    function idolExists(address _address) public view returns (bool) {
        return (producerToIdol[_address] > 0);
    }

    function destroyIdol() public {
        require(idolExists(msg.sender));
        uint idolID = producerToIdol[msg.sender];
        delete producerToIdol[msg.sender];
        delete idolToProducer[idolID];

        emit IdolDestroyed(msg.sender);
    }
}