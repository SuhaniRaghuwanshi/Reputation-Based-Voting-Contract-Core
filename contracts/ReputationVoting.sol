// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ReputationVoting {
    address public owner;
    uint256 public totalProposals;

    mapping(address => uint256) public reputation;
    mapping(uint256 => Proposal) public proposals;

    struct Proposal {
        string description;
        uint256 voteCount;
        mapping(address => bool) voted;
    }

    event ProposalCreated(uint256 proposalId, string description);
    event Voted(address indexed voter, uint256 proposalId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function createProposal(string calldata description) external onlyOwner {
        uint256 proposalId = totalProposals++;
        proposals[proposalId].description = description;
        emit ProposalCreated(proposalId, description);
    }

    function vote(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.voted[msg.sender], "Already voted");
        
        uint256 weight = reputation[msg.sender];
        require(weight > 0, "No reputation");

        proposal.voteCount += weight;
        proposal.voted[msg.sender] = true;
        emit Voted(msg.sender, proposalId);
    }

    // Set reputation of an address
    function setReputation(address user, uint256 rep) external onlyOwner {
        reputation[user] = rep;
    }

    // Get the current reputation of an address
    function getReputation(address user) external view returns (uint256) {
        return reputation[user];
    }
}
