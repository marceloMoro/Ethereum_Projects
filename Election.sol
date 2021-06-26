pragma solidity >=0.4.24 <0.6.0;

contract Election {

	//Mode a candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	//Store account that have voted
	mapping(address => bool) public voters;

	//Store Candidates
	//Fetch Candidates
	mapping(uint => Candidate) public candidates;

	//Store Candidates count
	uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );


	constructor() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");		
	}

	function addCandidate(string memory _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "Erro! Este eleitor já votou");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount,"Erro! Este não é um candidato válido");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}