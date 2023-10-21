// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

// Import the "ZombieFeeding" contract from another file.
import "./zombiefeeding.sol";

// Define a new contract named "ZombieHelper" that inherits from "ZombieFeeding."
contract ZombieHelper is ZombieFeeding {

  // Declare a state variable to set the fee required to level up a zombie.
  uint levelUpFee = 0.001 ether;

  // Modifier to require that a zombie's level is above or equal to a specified level.
  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  // Function to allow the contract owner to withdraw funds from the contract.
  function withdraw() external onlyOwner {
    address _owner = owner();
    _owner.transfer(address(this).balance);
  }

  // Function to set the level up fee, which can be called by the contract owner.
  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  // Function to increase a zombie's level, requiring a fee in Ether to be paid.
  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee); // Check if the paid fee matches the level up fee.
    zombies[_zombieId].level = zombies[_zombieId].level.add(1);
  }

  // Function to change a zombie's name, requiring a specified level and ownership.
  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].name = _newName;
  }

  // Function to change a zombie's DNA, requiring a specified level and ownership.
  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
    zombies[_zombieId].dna = _newDna;
  }

  // Function to retrieve an array of zombie IDs owned by a specific address.
  function getZombiesByOwner(address _owner) external view returns (uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }
}
