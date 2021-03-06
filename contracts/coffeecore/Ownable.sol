pragma solidity ^0.5.0;

/// Provides basic authorization control
contract Ownable {
    address payable private origOwner;

    // Define an Event
    event TransferOwnership(address indexed oldOwner, address indexed newOwner);

    /// Assign the contract to an owner
    constructor () internal {
        origOwner = msg.sender;
        emit TransferOwnership(address(0), origOwner);
    }

    /// Look up the address of the owner
    function getOwner() public view returns (address payable) {
        return origOwner;
    }

    /// Define a function modifier 'onlyOwner'
    modifier onlyOwner() {
        require(isOwner(), "Only the owner can call this function");
        _;
    }

    /// Check if the calling address is the owner of the contract
    function isOwner() public view returns (bool) {
        return msg.sender == origOwner;
    }

    /// Define a function to renounce ownerhip
    function renounceOwnership() public onlyOwner {
        emit TransferOwnership(origOwner, address(0));
        origOwner = address(0);
    }

    /// Define a public function to transfer ownership
    function transferOwnership(address payable newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /// Define an internal function to transfer ownership
    function _transferOwnership(address payable newOwner) internal {
        require(newOwner != address(0), "This is not a real address");
        emit TransferOwnership(origOwner, newOwner);
        origOwner = newOwner;
    }
}
