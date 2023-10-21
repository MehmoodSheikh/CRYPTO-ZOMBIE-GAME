// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

// Import the "ZombieAttack" and "ERC721" contracts.
import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";

/// @title A contract for Zombie ownership
/// @author MEHMOOD SHEIKH
contract ZombieOwnership is ZombieAttack, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) zombieApprovals; // Mapping to track zombie approvals.

  // Function to get the balance of zombies owned by a specific address.
  function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner];
  }

  // Function to get the owner of a specific zombie token.
  function ownerOf(uint256 _tokenId) external view returns (address) {
    return zombieToOwner[_tokenId];
  }

  // Private function to transfer a zombie token from one owner to another.
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1); // Increment recipient's zombie count.
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1); // Decrement sender's zombie count.
    zombieToOwner[_tokenId] = _to; // Update the ownership record.
    emit Transfer(_from, _to, _tokenId); // Log the transfer.
  }

  // Function to transfer a zombie token from one owner to another.
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require(zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId); // Execute the transfer.
  }

  // Function to approve another address to take ownership of a specific zombie token.
  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _approved; // Set the approval for the token.
    emit Approval(msg.sender, _approved, _tokenId); // Log the approval.
  }
}
