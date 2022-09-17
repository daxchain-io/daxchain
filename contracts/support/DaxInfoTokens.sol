// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "../DaxToken.sol";

contract DaxInfoTokens is
    Initializable,
    AccessControlUpgradeable,
    ERC20Upgradeable,
    UUPSUpgradeable
{
    bytes32 public constant CONTRACT_ADMIN_ROLE = keccak256("CONTRACT_ADMIN_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

    DaxToken private _tokenContract;

    constructor() {
        _disableInitializers();
    }

    function initialize(DaxToken tokenContract)
    public initializer {
        __AccessControl_init();
        __ERC20_init("DaxInfo Tokens", "DAX?-TOKENS");
        __UUPSUpgradeable_init();

        address sender = _msgSender();
        _grantRole(DEFAULT_ADMIN_ROLE, sender);
        _grantRole(CONTRACT_ADMIN_ROLE, sender);
        _grantRole(UPGRADER_ROLE, sender);

        _tokenContract = tokenContract;

        emit Transfer(address(this), address(this), 0);
    }

    function balanceOf(address account)
    public view virtual override
    returns (uint256) {
        return _tokenContract.balanceOf(account);
    }

    function decimals()
    public view virtual override
    returns (uint8) {
        return 0;
    }

    function __config()
    public view
    returns (DaxToken tokenContract) {
        tokenContract = _tokenContract;
    }

    function __tokenContract()
    public view
    returns (DaxToken) {
        return _tokenContract;
    }

    function __setTokenContract(DaxToken tokenContract)
    public onlyRole(CONTRACT_ADMIN_ROLE) {
        _tokenContract = tokenContract;
    }

    function _authorizeUpgrade(address newImplementation)
    internal onlyRole(UPGRADER_ROLE) override {}

    function _burn(address account, uint256 amount)
    internal pure override {}

    function _mint(address account, uint256 amount)
    internal pure override {}

    function _transfer(address from, address to, uint256 amount)
    internal pure override {}
}
