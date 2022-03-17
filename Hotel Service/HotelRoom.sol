pragma solidity ^0.8.7;

// SPDX-License-Identifier: MIT
contract HotelRoom {

    enum Statuses { available , occupied }
    Statuses currentStatus;  

    event Occupy(address _occupant, uint _value);        
    
    
    address payable public owner;
    uint public time;
    address public occupant;
    

    constructor () {
        owner = payable(msg.sender);
        currentStatus = Statuses.available;
        time = block.timestamp;
       
    }

    modifier onlyWhileAvailable {
        require (currentStatus == Statuses.available, "Room is already booked");
        _;
    }
    modifier costs(uint _price) {
        require (msg.value > _price, "Not enough funds");
        _;
    }

    receive() external payable onlyWhileAvailable costs(2 ether) {

        currentStatus = Statuses.occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value); 
        occupant = msg.sender;    
    }

    
    function freeRoom() public {
            assert ( block.timestamp > time + 20 seconds);
                currentStatus = Statuses.available;
                time = block.timestamp;
                occupant = address(0);
            
    }

    /*function whoIsInTheRoom () public view returns (address) {
            return occupant;
    }
    */
    

    
    
}