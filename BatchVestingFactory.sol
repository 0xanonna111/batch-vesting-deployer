// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IVestingLogic {
    function initialize(address _token, address _beneficiary, uint256 _start, uint256 _duration) external;
}

contract BatchVestingFactory is Ownable {
    address public immutable implementation;
    address[] public allVaults;

    event BatchCreated(uint256 count);
    event VaultCreated(address indexed proxy, address indexed beneficiary);

    constructor(address _implementation) Ownable(msg.sender) {
        implementation = _implementation;
    }

    /**
     * @dev Deploys multiple vesting proxies in a single transaction.
     */
    function batchDeployVesting(
        address _token,
        address[] calldata _beneficiaries,
        uint256[] calldata _starts,
        uint256[] calldata _durations
    ) external onlyOwner {
        uint256 count = _beneficiaries.length;
        require(count == _starts.length && count == _durations.length, "Array length mismatch");

        for (uint256 i = 0; i < count; i++) {
            address proxy = Clones.clone(implementation);
            IVestingLogic(proxy).initialize(
                _token, 
                _beneficiaries[i], 
                _starts[i], 
                _durations[i]
            );
            
            allVaults.push(proxy);
            emit VaultCreated(proxy, _beneficiaries[i]);
        }

        emit BatchCreated(count);
    }

    function getVaults() external view returns (address[] memory) {
        return allVaults;
    }
}
