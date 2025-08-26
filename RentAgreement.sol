// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RentAgreement {
    address payable public landlord;
    address payable public tenant;
    uint public rent;
    uint public deposit;
    uint public leaseEndDate;
    bool public depositPaid;
    bool public leaseEnded;

    event RentPaid(address tenant, uint amount, uint date);
    event DepositPaid(address tenant, uint amount);
    event LeaseEnded();

    modifier onlyTenant() {
        require(msg.sender == tenant, "Only tenant can call this");
        _;
    }

    modifier onlyLandlordOrTenant() {
        require(msg.sender == landlord || msg.sender == tenant, "Unauthorized");
        _;
    }

    modifier leaseActive() {
        require(!leaseEnded, "Lease already ended");
        _;
    }

    constructor(
        address payable _tenant,
        uint _rent,
        uint _deposit,
        uint _durationDays
    ) {
        landlord = payable(msg.sender);
        tenant = _tenant;
        rent = _rent;
        deposit = _deposit;
        leaseEndDate = block.timestamp + (_durationDays * 1 days);
    }

    function payDeposit() external payable onlyTenant leaseActive {
        require(msg.value == deposit, "Incorrect deposit amount");
        require(!depositPaid, "Deposit already paid");

        depositPaid = true;
        emit DepositPaid(msg.sender, msg.value);
    }

    function payRent() external payable onlyTenant leaseActive {
        require(msg.value == rent, "Incorrect rent amount");

        landlord.transfer(msg.value);
        emit RentPaid(msg.sender, msg.value, block.timestamp);
    }

    function endLease() external onlyLandlordOrTenant leaseActive {
        require(block.timestamp >= leaseEndDate, "Lease still active");

        leaseEnded = true;

        if (depositPaid) {
            tenant.transfer(deposit);
        }

        emit LeaseEnded();
        // No selfdestruct — contract remains on chain
    }
}
