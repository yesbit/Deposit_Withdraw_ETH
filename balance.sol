pragma solidity ^0.4.11;

contract MyContract {

    /*
        Maps account addresses to the amount of ether on their balance.
    */
    mapping (address => uint256) public balances;

    /*
        msg.sender and msg.value are implicitly available, contain information
        about the adress of a caller and amount of ether they sent with the call (in wei)
    */
    function deposit() payable returns(bool success) {
        balances[msg.sender] += msg.value;
        return true;
    }
    
      function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /*
        First verify that method called has deposited greater or equal amount of ether than
        he wants to withdraw. 
        msg.sender.transfer function creates a transaction to send ether back to caller 
    */
    function withdraw(uint value) returns(bool success) {
        if(balances[msg.sender] < value) throw;
        balances[msg.sender] -= value;
        msg.sender.transfer(value);
        return true;
    }

    /*
        Similar to withdraw but ether is sent to specified address, not the caller
    */
    function transfer(address to, uint value) returns(bool success) {
        if(balances[msg.sender] < value) throw;
        balances[msg.sender] -= value;
        to.transfer(value);
        return true;
    }
}
