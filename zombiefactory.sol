// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

// Import the "Ownable" contract for ownership management.
import "./ownable.sol";
// Import the SafeMath libraries for safe arithmetic operations.
import "./safemath.sol";

// Define a new contract named "ZombieFactory" that inherits from "Ownable."
contract ZombieFactory is Ownable {

  // Use SafeMath library for uint256, uint32, and uint16 to prevent overflow/underflow.
  using SafeMath for uint256;
  using SafeMath32 for uint32;
  using SafeMath16 for uint16;

  // Event to log the creation of a new zombie.
  event NewZombie(uint zombieId, string name, uint dna);

  // Constants for DNA representation and cooldown time.
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  // Struct to define the properties of a zombie.
  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  // Array to store zombie data.
  Zombie[] public zombies;

  // Mapping to track the owner of each zombie by its ID.
  mapping (uint => address) public zombieToOwner;

  // Mapping to track the number of zombies owned by each address.
  mapping (address => uint) ownerZombieCount;

  // Function to create a new zombie and emit a NewZombie event.
  function _createZombie(string memory _name, uint _dna) internal {
    uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    zombieToOwner[id] = msg.sender;
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
    emit NewZombie(id, _name, _dna);
  }

  // Function to generate a random DNA based on an input string.
  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  // Function to create a random zombie for a user.
  function createRandomZombie(string memory _name) public {
    // Ensure the user doesn't already own a zombie.
    require(ownerZombieCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createZombie(_name, randDna);
  }

}
