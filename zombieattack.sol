// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

// Import the "ZombieHelper" contract from another file.
import "./zombiehelper.sol";

// Define a new contract named "ZombieAttack" that inherits from "ZombieHelper".
contract ZombieAttack is ZombieHelper {
  // Declare state variables to be used in this contract.
  uint randNonce = 0; // A variable to track a random nonce.
  uint attackVictoryProbability = 70; // A variable to set the probability of winning an attack.

  // Function to generate a random number within a specified modulus.
  function randMod(uint _modulus) internal returns (uint) {
    randNonce = randNonce.add(1); // Increment the nonce.
    // Generate a pseudo-random number using the current time, sender's address, and nonce.
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce)) % _modulus);
  }

  // Function to initiate an attack between a user's zombie and a target zombie.
  function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
    // Declare storage references to the user's zombie and the target zombie.
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];

    // Generate a random number between 0 and 99.
    uint rand = randMod(100);

    // Check if the user's zombie wins the attack based on the generated random number.
    if (rand <= attackVictoryProbability) {
      // If the user's zombie wins, update its statistics and level.
      myZombie.winCount = myZombie.winCount.add(1);
      myZombie.level = myZombie.level.add(1);
      enemyZombie.lossCount = enemyZombie.lossCount.add(1);

      // Feed and multiply the user's zombie with the target zombie's DNA.
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } else {
      // If the user's zombie loses, update its statistics and trigger cooldown.
      myZombie.lossCount = myZombie.lossCount.add(1);
      enemyZombie.winCount = enemyZombie.winCount.add(1);
      _triggerCooldown(myZombie);
    }
  }
}
