// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MappingExp{

    struct Member {
        string name;
        string department;
        uint favNums;
    }
	
	mapping (address => Member[]) public membership;
	address[] public member_result;
    mapping(address => bool) public registered;


    function add_member() public{

        require(!isRegistered(),"Uye onceden eklenmis.");
        registered[msg.sender] = true;
        Member memory newMember = Member("Mesude", "Ceng", 7);
        membership[msg.sender].push(newMember);
        member_result.push(msg.sender);
    }

    function isRegistered() public view returns(bool){
        return registered[msg.sender];
    }

    

    function get_member() public view returns(address[] memory){
        return member_result;
    }
 



}