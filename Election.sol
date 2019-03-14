
pragma solidity >=0.4.0<=0.6.0;

/**
 *@title Election contract  
 */
contract Election {
    

    /**
     *@notice A state variable to Store Candidates Count
     */
    uint public candidatesCount;
    address public owner;



    /**
     *@notice constructor assigning the contract deployed address as the "owner"
     */
    constructor() public {
        owner=msg.sender;
    }


    /**
     *@notice a modifier "onlyOwner" is used to restrict the access to certain function
     */
     
     modifier onlyOwner {
         require(msg.sender==owner,"Can be called only by the contract deployer");
         _;
     }


    /**
     *@dev mapping to Store accounts that have voted
     */
    mapping(address => bool) public voters;
    /**
     *@dev mapping uint to candidate struct and stores in canditates
     */
    mapping(uint => Candidate) public candidates;
    

    /**
     *@dev A custome datatype "Candidate" to store the candidate details
     */
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }


    /**
     *@dev function to add candidate
     *@notice can be accessed by the contract deployer only
     */
    function election () public onlyOwner {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("Candidate 3");
    }

   
    /**
     *@dev function defining the candidate addition
     */
     function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

   
   /**
    *@dev function to cast vote
    */
    function vote (uint _candidateId) public {
        /**
         *@notice "require" to make sure they have not voted
         *@notice "require" to make sure it is valid candidate
         *@notice  recording the voter address as voted
         *@notice update candidates vote count
         */
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount ++;
    }
}
