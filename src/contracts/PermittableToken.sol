// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

/**
 * @title ERC20 compliant token contract that also includes the ERC20 Permit extension using EIP-2612
 * @author Howard Lee
 * @notice This smart contract will create a ERC20 Compliant Token that allows users to sign approvals with the ERC20 Permit extension
 * @custom:experimental version 1.0.0
 */

contract PermittableToken is ERC20Permit, Ownable {
    /// @notice used to multiply with initial supply and display when decimals() is triggered
    /// @dev for display purposes, refer: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/8d633cb7d169f2f8595b273660b00b69e845c2fe/contracts/token/ERC20/ERC20.sol#L82-L90
    uint8 immutable DECIMALS;

    /// @notice constructor function to initiate tokens upon deployment, DO NOT convert input value with decimals EG.1_000_000 tokens = 1_000_000_000 * DECIMALS
    /// @param _owner = owner of this tokens contract, will also transfer initial supply to owner address
    /// @param _tokenName = token name
    /// @param _tokenSymbol = token symbol, could be the same as token name
    /// @param _tokenDecimals = token decimal places, best practices are ERC20 = 18, Stablecoin = 6
    /// @param _tokenInitSupply = token initial supply upon deployment
    constructor(
        address _owner,
        string memory _tokenName,
        string memory _tokenSymbol,
        uint8 _tokenDecimals,
        uint256 _tokenInitSupply
    ) ERC20(_tokenName, _tokenSymbol) ERC20Permit(_tokenName) {
        _transferOwnership(_owner);
        DECIMALS = _tokenDecimals;
        _mint(_owner, _tokenInitSupply * 10 ** DECIMALS);
    }

    /// @notice only owner allowed to mint tokens
    /// @param _to is the reciever of the newly minted tokens
    /// @param _amount is the amount of newly minted tokens
    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    /// @notice only owner allowed to burn tokens, requires _from to have enough balance to burn
    /// @dev can remove this function if not implementing burn feature
    /// @param _from is the address owner whose tokens are being burned
    /// @param _amount is the amount of tokens being burned
    function burn(address _from, uint256 _amount) external onlyOwner {
        _burn(_from, _amount);
    }

    /// @notice a display only function to display how many decimal places this ERC20 token has
    /// @return uint8 the decimal places of this current ERC20 token
    function decimals() public view override returns (uint8) {
        return DECIMALS;
    }
}
