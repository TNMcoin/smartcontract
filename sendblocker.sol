/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract sendblocker at 0x8EfCE6E8f95cF74340c8c836Fca8e16894490183
*/
// sendblocker
// prevent any funds from incoming
// @authors:
// Cody Burns <dontpanic@codywburns.com>
// license: Apache 2.0
// version:

pragma solidity ^0.4.19;

// Intended use:  
// cross deploy to prevent unintended chain getting funds
// Status: functional
// still needs:
// submit pr and issues to https://github.com/realcodywburns/
//version 0.1.0

contract sendblocker{
 function () public {assert(0>0);}
    
}