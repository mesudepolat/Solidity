// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


// Counter 
contract Counter{
    uint public count;

    function inc() external {
        count +=1;
    }

    function dec() external{
        count -=1;
    }

}


// IF-Else
contract IfElse{
    
    function example(uint _x) external pure returns(uint){
        if(_x < 10){
            return 1;
        }else if(_x < 20){
            return 2;
        }else{
            return 3;
        }
    }

    function ternary(uint _x) external pure returns(uint){
        return _x < 10 ? 1 : 2;
    }
}


// For-While
contract ForandWhile {

    function loops() external pure {
        for (uint i = 0; i < 10; i++){
            if(i == 3){
                continue;
            }
            if (i == 5){
                break;
            }
        }

        uint j = 0;
        while (j < 10){
            j++;
        }
    }

    function sum(uint _n) external pure returns(uint){
        uint s;
        for (uint i=1; i<=_n; i++){
            s += i;
        }
        return s;
    }
}