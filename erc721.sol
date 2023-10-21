// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

// Define an interface for the ERC-721 standard.
contract ERC721 {
  // Event to log the transfer of a token from one address to another.
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

  // Event to log the approval of an address to take ownership of a specific token.
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  // Function to get the balance of tokens owned by a specific address.
  function balanceOf(address _owner) external view returns (uint256);

  // Function to get the owner of a specific token.
  function ownerOf(uint256 _tokenId) external view returns (address);

  // Function to transfer a token from one address to another.
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

  // Function to approve another address to take ownership of a specific token.
  function approve(address _approved, uint256 _tokenId) external payable;
}

