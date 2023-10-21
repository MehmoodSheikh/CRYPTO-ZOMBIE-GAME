// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address and provides basic authorization control
 * functions, simplifying the implementation of "user permissions."
 */
contract Ownable {
  address private _owner; // Private state variable to store the owner's address.

  event OwnershipTransferred( // Event to log ownership transfer.
    address indexed previousOwner,
    address indexed newOwner
  );

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender's
   * account when the contract is deployed.
   */
  constructor() internal {
    _owner = msg.sender; // Set the contract creator's address as the owner.
    emit OwnershipTransferred(address(0), _owner); // Log the ownership transfer.
  }

  /**
   * @return the address of the owner.
   */
  function owner() public view returns (address) {
    return _owner; // Public function to get the current owner's address.
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner()); // Modifier to restrict functions to the owner of the contract.
    _;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isOwner() public view returns (bool) {
    return msg.sender == _owner; // Check if the sender is the owner.
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0)); // Log the ownership transfer to address(0).
    _owner = address(0); // Set the owner's address to address(0) to renounce ownership.
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner); // Initiate the ownership transfer.
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0)); // Check that the new owner's address is not 0x0.
    emit OwnershipTransferred(_owner, newOwner); // Log the ownership transfer.
    _owner = newOwner; // Set the owner's address to the new owner.
  }
}
