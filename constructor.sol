// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;	
		
// Creating a contract
contract constructorExp {	
		
	// Declaring state variable
	string community;	
			
	// Creating a constructor to set value of 'community'
	constructor(string memory name) public {				
		community = name;	
	}	
	
	// Defining function to return the value of 'community'
	function getValue() public view returns (string memory) {	
		return community;	
	}	
}
