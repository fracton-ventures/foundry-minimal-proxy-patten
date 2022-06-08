// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/access/Ownable.sol";
// import "openzeppelin-contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
// import "openzeppelin-contracts-upgradeable/access/OwnableUpgradeable.sol";
import "openzeppelin-contracts/utils/Counters.sol";
import "openzeppelin-contracts-upgradeable/proxy/utils/Initializable.sol";

contract NFT is Initializable, Ownable, ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string private _name;
    string private _symbol;

    function initialize(
        address owner,
        string memory name,
        string memory symbol
    ) public initializer {
        transferOwnership(owner);
        _name = name;
        _symbol = symbol;
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function mintNft(address receiver) external onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newNftTokenId = _tokenIds.current();
        _mint(receiver, newNftTokenId);

        return newNftTokenId;
    }
}
