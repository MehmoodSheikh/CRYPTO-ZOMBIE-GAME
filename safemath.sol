// Specify the Solidity version range that this code is compatible with.
pragma solidity >=0.5.0 <0.6.0;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 * This library provides safe arithmetic operations to prevent overflows and underflows.
 */
library SafeMath {
  /**
   * @dev Multiplies two numbers, throws on overflow.
   * @param a The first number to multiply
   * @param b The second number to multiply
   * @return The product of a and b
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Check if 'a' is 0 and return 0 if true
    if (a == 0) {
      return 0;
    }
    // Multiply 'a' and 'b' and check for overflow
    uint256 c = a * b;
    assert(c / a == b); // Ensure no overflow occurred
    return c;
  }

  /**
   * @dev Integer division of two numbers, truncating the quotient.
   * @param a The dividend
   * @param b The divisor
   * @return The quotient of a divided by b
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // No overflow check needed
    return c;
  }

  /**
   * @dev Subtracts two numbers, throws on overflow (if subtrahend is greater than minuend).
   * @param a The minuend
   * @param b The subtrahend
   * @return The difference between a and b
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    // Check that 'b' is less than or equal to 'a'
    assert(b <= a);
    return a - b;
  }

  /**
   * @dev Adds two numbers, throws on overflow.
   * @param a The first number to add
   * @param b The second number to add
   * @return The sum of a and b
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    // Add 'a' and 'b' and check for overflow
    uint256 c = a + b;
    assert(c >= a); // Ensure no overflow occurred
    return c;
  }
}

/**
 * @title SafeMath32
 * @dev SafeMath library implemented for uint32
 * This library provides safe arithmetic operations for uint32 to prevent overflows and underflows.
 */
library SafeMath32 {
  // (Comments for the functions in this library are similar to those in SafeMath.)
  function mul(uint32 a, uint32 b) internal pure returns (uint32) {
    if (a == 0) {
      return 0;
    }
    uint32 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint32 a, uint32 b) internal pure returns (uint32) {
    // Solidity automatically throws when dividing by 0
    uint32 c = a / b;
    return c;
  }

  function sub(uint32 a, uint32 b) internal pure returns (uint32) {
    assert(b <= a);
    return a - b;
  }

  function add(uint32 a, uint32 b) internal pure returns (uint32) {
    uint32 c = a + b;
    assert(c >= a);
    return c;
  }
}

/**
 * @title SafeMath16
 * @dev SafeMath library implemented for uint16
 * This library provides safe arithmetic operations for uint16 to prevent overflows and underflows.
 */
library SafeMath16 {
  // (Comments for the functions in this library are similar to those in SafeMath32.)
  function mul(uint16 a, uint16 b) internal pure returns (uint16) {
    if (a == 0) {
      return 0;
    }
    uint16 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint16 a, uint16 b) internal pure returns (uint16) {
    // Solidity automatically throws when dividing by 0
    uint16 c = a / b;
    return c;
  }

  function sub(uint16 a, uint16 b) internal pure returns (uint16) {
    assert(b <= a);
    return a - b;
  }

  function add(uint16 a, uint16 b) internal pure returns (uint16) {
    uint16 c = a + b;
    assert(c >= a);
    return c;
  }
}
