// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

/**
 * @title Interface for Permittable ERC20 Token Factory
 * @author Howard Lee
 * @notice This smart contract is an interface for the ERC20 Token Factory
 * @custom:experimental version 1.0.0
 */

interface IPermittableERC20Factory {
    /// @notice deploys token instance
    /// @param _owner specifies owner with owner address
    /// @param _tokenName provides a token name
    /// @param _tokenDecimals determines how many decimal places
    /// @param _tokenInitSupply provides a initial value to the total supply of this new token
    function deployTokens(
        address _owner,
        string memory _tokenName,
        string memory _tokenSymbol,
        uint8 _tokenDecimals,
        uint256 _tokenInitSupply
    ) external;

    /// @notice view only function to display adddresses of all deployed tokens
    /// @return address[] an array of addresses of all deployed ERC20 tokens
    function allTokens() external view returns (address[] memory);

    /// @notice allow owner to find details of an already deployed token
    /// @param _tokenAddr = requested token address
    /// @return tokenName = returned value of token name
    /// @return tokenSymbol = returned value of token symbol
    /// @return tokenDecimals = returned value of token decimal places
    /// @return totalSupply = return value of token total supply
    function findToken(
        address _tokenAddr
    )
        external
        returns (
            string memory tokenName,
            string memory tokenSymbol,
            uint8 tokenDecimals,
            uint256 totalSupply
        );
}
