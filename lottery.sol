// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    address public manager;
    address payable[] public participants;

    // Constructor to set the manager of the contract
    constructor() {
        manager = msg.sender; // Assigning the manager to the deployer's address
    }

    // Function to receive Ether and add sender to participants
    receive() external payable {
        require(msg.value == 1 ether); 
        participants.push(payable(msg.sender)); // Add sender as a participant
    }

    // Additional functions like picking a winner would need to be implemented
function getBalance() public view returns(uint)
{require(msg.sender==manager);
    return address(this).balance;
}
function random() public view returns(uint){
 return  uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length))) ;
}
function selectWinner() public view returns(address){
    require(msg.sender==manager);
    require(participants.length>=3);
uint r=random();
address payable winner;
uint256 index = r % participants.length;
 winner =participants[index];
 winner.transfer(getBalance());
 participants=new address payable[](0);
}
}
