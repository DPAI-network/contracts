//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

interface IDPAIStaking {
    struct Staked {
        uint256 amountLocked;
        uint256 cliff;
        uint256 duration;
    }

    struct StakeMultiple {
        uint256 amount;
        address recipient;
    }

    error ZeroAddress();
    error ZeroAmount();
    error ZeroCliff();
    error ZeroDuration();
    error WrongCaller(address caller);

    function stake(
        uint256 amount,
        uint256 cliff,
        uint256 duration,
        address recipient
    ) external;

    function stake(
        uint256 cliff,
        uint256 duration,
        StakeMultiple[] memory staked
    ) external;
    function clearStaking(address recipient) external ;
    function stakedAmount(address recipient) external view returns (uint256);
    function vestedAmount(address recipient) external view returns (uint256);
}
