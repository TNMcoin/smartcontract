/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract UUB at 0x243b6465ffe95fd7985b414696f7feba7892973e
*/
pragma solidity ^0.4.4;

contract Token {
    function totalSupply() constant returns (uint256 supply) {}
    function balanceOf(address _owner) constant returns (uint256 balance) {}
    function transfer(address _to, uint256 _value) returns (bool success) {}
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
contract StandardToken is Token {

    function transfer(address _to, uint256 _value) returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
       // require(_to!=0x0);
        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
}
contract UUB is StandardToken { 

    string public name;                  
    uint8 public decimals;              
    string public symbol;                 
    string public version = '1.0'; 
    uint256 public Rate;     
    uint256 public totalEthInWei;      
    address public fundsWallet; 

    function UUB(
        ) {
        totalSupply = 100000000000;                   
        fundsWallet = 0x6F53934a8126CE68c364c199481c0F0eE3550e9E;   
        balances[fundsWallet] = 100000000000;
        name = "UUB";                                        
        decimals = 18;                                  
        symbol = "UUB";                                            
        Rate = 1;                                      
    }
    
    function setCurrentRate(uint256 _rate) public {
        if(msg.sender != fundsWallet) { throw; }
        Rate = _rate;
    }    

    function setCurrentVersion(string _ver) public {
        if(msg.sender != fundsWallet) { throw; }
        version = _ver;
    }  

    function() payable{
 
        totalEthInWei = totalEthInWei + msg.value;
  
        uint256 amount = msg.value * Rate;

        //require(balances[fundsWallet] >= amount);


        balances[fundsWallet] = balances[fundsWallet] - amount;

        balances[msg.sender] = balances[msg.sender] + amount;


        Transfer(fundsWallet, msg.sender, amount); 

 
       // fundsWallet.transfer(msg.value);                               
    }


    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}