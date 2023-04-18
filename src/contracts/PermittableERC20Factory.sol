// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "../interfaces/IPermittableERC20Factory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "./PermittableToken.sol";

/**
 * @title Contract for Permittable ERC20 Token Factory
 * @author Howard Lee
 * @notice This smart contract is used to manage deployed ERC20 tokens with the ERC20 Permit extension using EIP-2612
 * @custom:experimental version 1.0.0
 */

contract PermittableERC20Factory is IPermittableERC20Factory, Ownable {
    // =============================================
    //                  ERRORS
    // =============================================

    error tokenNotFound();

    // =============================================
    //                  MEMORY
    // =============================================

    address[] private deployedTokens;

    // =============================================
    //            EXTERNAL FUNCTIONS
    // =============================================

    /// @notice deploys token instance
    /// @dev note that the defined decimals will be used to multiply with the tokenInitSupply to get total supply of tokens upon deploying
    /// @dev refer to the constructor in `PermittableToken.sol`
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
    ) external onlyOwner {
        PermittableToken newToken = new PermittableToken(
            _owner,
            _tokenName,
            _tokenSymbol,
            _tokenDecimals,
            _tokenInitSupply
        );
        deployedTokens.push(address(newToken));
    }

    /// @notice view only function to display adddresses of all deployed tokens
    /// @return address[] an array of addresses of all deployed tokens
    function allTokens() external view onlyOwner returns (address[] memory) {
        return deployedTokens;
    }

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
        view
        onlyOwner
        returns (
            string memory tokenName,
            string memory tokenSymbol,
            uint8 tokenDecimals,
            uint256 totalSupply
        )
    {
        if (_filterTokens(_tokenAddr) == false) {
            revert tokenNotFound();
        }
        IERC20Metadata token = IERC20Metadata(_tokenAddr);
        tokenName = token.name();
        tokenSymbol = token.symbol();
        tokenDecimals = token.decimals();
        totalSupply = token.totalSupply();
    }

    // =============================================
    //            INTERNAL FUNCTIONS
    // =============================================

    /// @notice internal function to iterate through deployed tokens array and returns a boolean
    /// @param _addr = address to filter for
    /// @return result = result of the filter
    function _filterTokens(address _addr) internal view returns (bool result) {
        for (uint256 i = 0; i < deployedTokens.length; i++) {
            if (deployedTokens[i] == _addr) {
                return result = true;
            }
            result = false;
        }
        return result;
    }
}
