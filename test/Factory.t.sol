// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/NFT.sol";
import "../src/Factory.sol";
import "forge-std/Test.sol";

contract FactoryTest is Test, Factory {
    NFT internal nft;

    function setUp() public {
        nft = new NFT();
    }

    function testDeploy() public {
        vm.expectEmit(true, true, false, true); // 3rd arg will not be checked
        // The event we expect
        emit Deployed(
            msg.sender,
            address(nft),
            address(0), // deployed address not checked.
            "Sample token",
            "SAMPLE"
        );
        deploy(address(nft), "Sample token", "SAMPLE");
    }

    function testDuplicateDeployFail() public {
        deploy(address(nft), "Sample token", "SAMPLE");
        vm.expectRevert(bytes("ERC1167: create2 failed"));
        deploy(address(nft), "Sample token", "SAMPLE");
    }
}
