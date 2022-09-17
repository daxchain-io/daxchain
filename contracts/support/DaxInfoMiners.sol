// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "../DaxMining.sol";
import "../DaxToken.sol";

contract DaxInfoMiners is
    Initializable,
    AccessControlUpgradeable,
    ERC20Upgradeable,
    UUPSUpgradeable
{
    bytes32 public constant CONTRACT_ADMIN_ROLE = keccak256("CONTRACT_ADMIN_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

    DaxToken private _tokenContract;
    DaxMining private _miningContract;

    constructor() {
        _disableInitializers();
    }

    function initialize(DaxToken tokenContract, DaxMining miningContract)
    public initializer {
        __AccessControl_init();
        __ERC20_init("DaxInfo Miners", "DAX?-MINERS");
        __UUPSUpgradeable_init();

        address sender = _msgSender();
        _grantRole(DEFAULT_ADMIN_ROLE, sender);
        _grantRole(CONTRACT_ADMIN_ROLE, sender);
        _grantRole(UPGRADER_ROLE, sender);

        _tokenContract = tokenContract;
        _miningContract = miningContract;
        
        emit Transfer(address(this), address(this), 0);
    }

    function balanceOf(address account)
    public view virtual override
    returns (uint256) {
        uint256 index;
        uint256 total;
        while (index < _tokenContract.balanceOf(account)) {
            total += _miningContract.improvements(_tokenContract.tokenOfOwnerByIndex(account, index));
            index++;
        }
        return total;
    }

    function __config()
    public view
    returns (
        DaxMining miningContract,
        DaxToken tokenContract)
    {
        miningContract = _miningContract;
        tokenContract = _tokenContract;
    }

    function __miningContract()
    public view
    returns (DaxMining) {
        return _miningContract;
    }

    function __tokenContract()
    public view
    returns (DaxToken) {
        return _tokenContract;
    }

    function __setMiningContract(DaxMining miningContract)
    public onlyRole(CONTRACT_ADMIN_ROLE) {
        _miningContract = miningContract;
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
