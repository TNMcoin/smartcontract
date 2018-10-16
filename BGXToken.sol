/* 
 source code generate by Bui Dinh Ngoc aka ngocbd<buidinhngoc.aiti@gmail.com> for smartcontract BGXToken at 0xbf3f09e4eba5f7805e5fac0ee09fd6ee8eebe4cb
*/
pragma solidity ^0.4.18;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract BGXToken {
    // ???????????????????????????? ======>
    string public name = "BIT GAME EXCHANGE";
    string public symbol = "BGX";

    address ethFundAddress = 0x7C235ac7b006d829990384018B0E98fDf0bA5EF7; // ???????
    address icoAddress = 0xC817a2afe8F6ba1a697dAaA1df834e18Be9403e7; // ICO??
    address[] foundationAddresses = [0xBc9d9A1EE11dC2803BA2daaAa892483052Ed97f5,
                                     0x3CA55e25C110b175B6622586aC31a6682a916670,
                                     0xF13b2d7c5d6d6E93f79D41FA72cFD33A75c0607d,
                                     0xc321Cf1D0ab11743cB5dDB4d77F6Ede8a08D3281,
                                     0xf7179c8A47F511E4fcAcA9b6187ED4052cBBB7BB,
                                     0x516c06F2A390E62c2F6cB3C2E38c5c6dF5A17141,
                                     0xE71a86f7FFa3E3aA92e5cA6b6df8B56d8600c7D9]; // ??????7?
    address[] teamAddresses = [0x3CFdEC9041b04a7eEb07a732B964a5B33f9Ebe1F]; // ?????1?
    address[] miningAddresses = [0x710967a31D79BCFBF053292aB21Bbc559e288407,
                                 0x7bF52Ef4b6e8bEeB24c4Dea4c8e94177739561a0]; // ?????2?
    address[] angelAddresses = [0x122399734D64d6c4aa46b85959A3304CA812161f]; // ?????1?
    address[] cornerstoneAddresses = [0x9d35F83982A479F611fa893452f6876972Ec6348,
                                      0x1EAf530897EB1D93fF4373889d9cfd5a1E405D1B,
                                      0x377221D5b7776C1Ba4B8e8d11a32CF9a7469A095,
                                      0xc4381bc9dDFaa8A9954CF2615F80F8Fc145E024F,
                                      0x699a3be17F729F3eB965fBb7d71Db185016B1215,
                                      0x9F793B134E41Bb404142B598E05Ea6ed5477D392,
                                      0xA7FF388DAfD240505f9a1d3ca37c15E058B9D4ea]; // ?????7?
    address[] preIcoAddresses = [0x4d1Ffd49d47552adcaf1729b9C4A2320419b81E1]; // PreICO???1?

    uint256 startTime = 1525708800; // ??????2018/5/8 0:0:0 UTC-0
    uint256 endTime = 1528473600; // ??????2018/6/9 0:0:0 UTC-0
    uint256 lockEndTime = 1528473600; // ????????2018/6/9 0:0:0 UTC-0
    // <====== ???????????

    uint256 public decimals = 18;
    uint256 DECIMALSFACTOR = 10 ** decimals;
    uint256 constant weiDECIMALS = 18; // ???????
    uint256 weiFACTOR = 10 ** weiDECIMALS; // ?????????

    uint256[] foundationAmounts = [5 * (10**8) * DECIMALSFACTOR,
                                   5 * (10**8) * DECIMALSFACTOR,
                                   1 * (10**8) * DECIMALSFACTOR,
                                   1 * (10**8) * DECIMALSFACTOR,
                                   1 * (10**8) * DECIMALSFACTOR,
                                   1 * (10**8) * DECIMALSFACTOR,
                                   1 * (10**8) * DECIMALSFACTOR];
    uint256[] teamAmounts = [15 * (10**8) * DECIMALSFACTOR];
    uint256[] miningAmounts = [15 * (10**8) * DECIMALSFACTOR,
                               15 * (10**8) * DECIMALSFACTOR];
    uint256[] angelAmounts = [5 * (10**8) * DECIMALSFACTOR];
    uint256[] cornerstoneAmounts = [1 * (10**8) * DECIMALSFACTOR,
                                    1 * (10**8) * DECIMALSFACTOR,
                                    1 * (10**8) * DECIMALSFACTOR,
                                    1 * (10**8) * DECIMALSFACTOR,
                                    1 * (10**8) * DECIMALSFACTOR,
                                    2 * (10**8) * DECIMALSFACTOR,
                                    3 * (10**8) * DECIMALSFACTOR];
    uint256[] preIcoAmounts = [5 * (10**8) * DECIMALSFACTOR];

    address contractOwner;
    uint256 ethRaised = 0; // ???ETH??????Wei
    uint256 donationCount; // ??????

    uint256 public totalSupply = 100 * (10**8) * DECIMALSFACTOR; // ??100?
    uint256 public availableSupply = totalSupply; // ???????
    uint256 hardCap = 30000 * weiFACTOR; // ??3?ETH
    uint256 minimumDonation = 1 * 10 ** (weiDECIMALS - 1); // ????0.1ETH????

    bool public finalised = false;

    // ????????????
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);

    // This notifies clients about the amount burnt
    event Burn(address indexed from, uint256 value);

    function BGXToken() public {
        contractOwner = msg.sender;

        // ??????????????
        uint i = 0;
        for (i = 0; i < foundationAddresses.length; i++){
            balanceOf[foundationAddresses[i]] += foundationAmounts[i];
            availableSupply -= foundationAmounts[i];
            emit Transfer(address(0), foundationAddresses[i], foundationAmounts[i]);
        }
        for (i = 0; i < teamAddresses.length; i++){
            balanceOf[teamAddresses[i]] += teamAmounts[i];
            availableSupply -= teamAmounts[i];
            emit Transfer(address(0), teamAddresses[i], teamAmounts[i]);
        }
        for (i = 0; i < miningAddresses.length; i++){
            balanceOf[miningAddresses[i]] += miningAmounts[i];
            availableSupply -= miningAmounts[i];
            emit Transfer(address(0), miningAddresses[i], miningAmounts[i]);
        }
        for (i = 0; i < angelAddresses.length; i++){
            balanceOf[angelAddresses[i]] += angelAmounts[i];
            availableSupply -= angelAmounts[i];
            emit Transfer(address(0), angelAddresses[i], angelAmounts[i]);
        }
        for (i = 0; i < cornerstoneAddresses.length; i++){
            balanceOf[cornerstoneAddresses[i]] += cornerstoneAmounts[i];
            availableSupply -= cornerstoneAmounts[i];
            emit Transfer(address(0), cornerstoneAddresses[i], cornerstoneAmounts[i]);
        }
        for (i = 0; i < preIcoAddresses.length; i++){
            balanceOf[preIcoAddresses[i]] += preIcoAmounts[i];
            availableSupply -= preIcoAmounts[i];
            emit Transfer(address(0), preIcoAddresses[i], preIcoAmounts[i]);
        }

        // ??????????ICO????
        balanceOf[icoAddress] = availableSupply;
        emit Transfer(address(0), icoAddress, availableSupply);
    }

    // fallback???????????data??????????????
    function () payable public {
        require(!finalised);

        // ???????????????
        require(block.timestamp >= startTime);
        require(block.timestamp <= endTime);

        // ????
        require(ethRaised < hardCap);

        // ?????????????????
        require(msg.value >= minimumDonation);

        uint256 etherValue = msg.value;

        // ???????????ETH???????????????
        if (ethRaised + etherValue > hardCap){
            etherValue = hardCap - ethRaised;
            // ??????????
            assert(msg.value > etherValue);
            msg.sender.transfer(msg.value - etherValue);
        }

        // ??ETH???ETH????
        ethFundAddress.transfer(etherValue);

        donationCount += 1;
        ethRaised += etherValue;
    }

    /**
     * Internal transfer, only can be called by this contract
     */
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balanceOf[_from] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value > balanceOf[_to]);
        // Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // Subtract from the sender
        balanceOf[_from] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    function _isInWhiteAddresses(address _from) internal view returns (bool success) {
        if (icoAddress == _from){
            return true;
        }
        uint i = 0;
        for (i = 0; i < foundationAddresses.length; i++){
            if (foundationAddresses[i] == _from){
                return true;
            }
        }
        for (i = 0; i < teamAddresses.length; i++){
            if (teamAddresses[i] == _from){
                return true;
            }
        }
        for (i = 0; i < miningAddresses.length; i++){
            if (miningAddresses[i] == _from){
                return true;
            }
        }
        for (i = 0; i < angelAddresses.length; i++){
            if (angelAddresses[i] == _from){
                return true;
            }
        }
        for (i = 0; i < cornerstoneAddresses.length; i++){
            if (cornerstoneAddresses[i] == _from){
                return true;
            }
        }
        for (i = 0; i < preIcoAddresses.length; i++){
            if (preIcoAddresses[i] == _from){
                return true;
            }
        }
        return false;
    }

    function transfer(address _to, uint256 _value) public {
        require(block.timestamp > lockEndTime || _isInWhiteAddresses(msg.sender));
        _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(block.timestamp > lockEndTime || _isInWhiteAddresses(_from));
        require(_value <= allowance[_from][msg.sender]);     // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }

    function burn(uint256 _value) public returns (bool success) {
        require(block.timestamp > lockEndTime);
        require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
        balanceOf[msg.sender] -= _value;            // Subtract from the sender
        totalSupply -= _value;                      // Update totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }

    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(block.timestamp > lockEndTime);
        require(balanceOf[_from] >= _value);                // Check if the targeted balance is enough
        require(_value <= allowance[_from][msg.sender]);    // Check allowance
        balanceOf[_from] -= _value;                         // Subtract from the targeted balance
        allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
        totalSupply -= _value;                              // Update totalSupply
        emit Burn(_from, _value);
        return true;
    }

    function finalise() public {
        require(msg.sender == contractOwner);
        require(!finalised);

        finalised = true;
    }

    function setLockEndTime(uint256 t) public {
        require(msg.sender == contractOwner);
        lockEndTime = t;
    }
}