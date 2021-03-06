/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract ZeroHooStandardToken at 0x4fa9340d2947047efdcdfe972134d05b0860ae4d
*/
pragma solidity ^ 0.4.21;

contract SafeMath {
    uint256 constant public MAX_UINT256 =
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    function safeAdd(uint256 x, uint256 y) pure internal returns (uint256 z) {
        if (x > MAX_UINT256 - y) revert();
        return x + y;
    }

    function safeSub(uint256 x, uint256 y) pure internal returns (uint256 z) {
        if (x < y) revert();
        return x - y;
    }

    function safeMul(uint256 x, uint256 y) pure internal returns (uint256 z) {
        if (y == 0) return 0;
        if (x > MAX_UINT256 / y) revert();
        return x * y;
    }
}
contract Token{
    // token???????public??????getter????????totalSupply().
    uint256 public totalSupply;

    /// ????_owner??token??? 
    function balanceOf(address _owner) public constant returns (uint256 balance);

    //??????????_to??????_value?token
    function transfer(address _to, uint256 _value) public returns(bool success);

    //???_from????_to????_value?token??approve??????
    function transferFrom(address _from, address _to, uint256 _value) public returns
        (bool success);

    //??????????_spender????????????_value?token
    function approve(address _spender, uint256 _value) public returns(bool success);

    //????_spender?????_owner???token???
    function allowance(address _owner, address _spender) public constant returns 
        (uint256 remaining);

    //????????????? 
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //???approve(address _spender, uint256 _value)????????????
    event Approval(address indexed _owner, address indexed _spender, uint256 
    _value);
}

contract StandardToken is Token, SafeMath {
    function transfer(address _to, uint256 _value) public returns(bool success) {
        //??totalSupply ??????? (2^256 - 1).
        //??????????????token??????????????????
        //require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);
        require(balances[msg.sender] >= _value);
        balances[msg.sender] = safeSub(balances[msg.sender], _value);//???????????token??_value
        balances[_to] = safeAdd(balances[_to], _value);//???????token??_value
        emit Transfer(msg.sender, _to, _value);//????????
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns
        (bool success) {
        //require(balances[_from] >= _value && allowed[_from][msg.sender] >= 
        // _value && balances[_to] + _value > balances[_to]);
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
        balances[_to] = safeAdd(balances[_to], _value);//??????token??_value
        balances[_from] = safeSub(balances[_from], _value); //????_from??token??_value
        allowed[_from][msg.sender] = safeSub(allowed[_from][msg.sender], _value);//??????????_from????????_value
        emit Transfer(_from, _to, _value);//????????
        return true;
    }
    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }


    function approve(address _spender, uint256 _value) public returns(bool success)
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }


    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
        return allowed[_owner][_spender];//??_spender?_owner????token?
    }
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
}

contract ZeroHooStandardToken is StandardToken { 

    /* Public variables of the token */
    string public name;                   //??: eg Simon Bucks
    uint8 public decimals;               //????????How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. It's like comparing 1 wei to 1 ether.
    string public symbol;               //token??: eg SBX
    string public version = 'zero 1.0.0';    //??

    function ZeroHooStandardToken(uint256 _initialAmount, string _tokenName, uint8 _decimalUnits, string _tokenSymbol) public {
        balances[msg.sender] = _initialAmount; // ??token?????????
        totalSupply = _initialAmount;         // ??????
        name = _tokenName;                   // token??
        decimals = _decimalUnits;           // ????
        symbol = _tokenSymbol;             // token??
    }

    /* Approves and then calls the receiving contract */

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns(bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        require(_spender.call(bytes4(bytes32(keccak256("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));
        return true;
    }

}