// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/*
ChairPerson: 0x17F6AD8Ef982297579C203069C1DbfFE4348c372

address public myAddress = 0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC;

function getBytes() public view returns(bytes32) {
    bytes32 myBytes32 = bytes32(bytes20(myAddress));
    return myBytes32;
}

ProposalNames
1: 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678 | 0x1234567890123456789012345678901234567890000000000000000000000000
2: 0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7 | 0x03c6fced478cbbc9a4fab34ef9f40767739d1ff7000000000000000000000000
3: 0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC | 0x0a098eda01ce92ff4a4ccb7a4fffb5a43ebc70dc000000000000000000000000

Contract input: ["0x1234567890123456789012345678901234567890000000000000000000000000", "0x03c6fced478cbbc9a4fab34ef9f40767739d1ff7000000000000000000000000", "0x0a098eda01ce92ff4a4ccb7a4fffb5a43ebc70dc000000000000000000000000"]

*/


contract Voting {

    struct Voter {
        uint weight; 
        bool voted;  
        address delegate; 
        uint vote;   
    }

    struct Proposal {
        bytes32 name;   
        uint voteCount; 
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;


    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function giveRightToVote(address voter) external {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }


    function delegate(address to) external {

        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You have no right to vote");
        require(!sender.voted, "You already voted.");

        require(to != msg.sender, "Self-delegation is disallowed.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loop in delegation.");
        }

        Voter storage delegate_ = voters[to];

        require(delegate_.weight >= 1);

        sender.voted = true;
        sender.delegate = to;

        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }


    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }


    function winnerName() external view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}