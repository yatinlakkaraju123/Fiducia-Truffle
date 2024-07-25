
pragma solidity ^0.8.17;

// SPDX-License-Identifier: GPL-3.0

contract Feedback {
    address public chairperson;
    string public Ipfs;
    uint256 public questionsCount;
    uint256 public candidatescount;
    uint256 public StartRegisterTime;
    uint256 public StopRegisterTime;
    uint256 public StartFeedbackTime;
    uint256 public StopFeedbackTime;
    uint256 public StartResultTime;
    string[] public RegNo;
    string[] public Phone;
    string[] public Email;
   struct Feedbacks
   {
    uint qid;
    string answer;
   }
       struct User
    {
        address user_address;
        
        bool registered;
    }
     mapping(address=>User) public users;
   Feedbacks[] public feedbacks;
   bool[] public RegisterDone;
    
    constructor(
        string memory ipfs,
        string[] memory regNo,
        string[] memory phone,
        string[] memory email,
        uint256[5] memory Times,
        uint256 NoOfQuestions
    ) {
        chairperson = msg.sender;
        Ipfs = ipfs;
        RegNo = regNo;
        Phone = phone;
        Email = email;
        StartRegisterTime = Times[0];
        StopRegisterTime = Times[1];
        StartFeedbackTime = Times[2];
        StopFeedbackTime = Times[3];
        StartResultTime = Times[4];
        questionsCount = NoOfQuestions;
        RegisterDone = new bool[](RegNo.length);
        for(uint i=0;i<RegNo.length;i++)
        {
            RegisterDone[i] = false;
        }
    }
     function register(uint regIndx) public 
    {     
          address person = msg.sender;
          
        require(msg.sender!=chairperson,"chairperson cannot register");
        require(users[person].registered==false,"user is already registered");
      
        users[person].user_address = person;
        users[person].registered = true;
        RegisterDone[regIndx] = true;
        

    }
    function getIsRegNoRegistered(uint index) public view returns(bool){
        return RegisterDone[index];
     }
     function getLengthRegNo() public view returns(uint)
     {
        return RegNo.length;
     }
     function getLengthPhone() public view returns(uint)
     {
        return Phone.length;
     }
     function getLengthEmail() public view returns(uint)
     {
        return Email.length;
     }
     function isRegistered(address addr) public view returns(bool)
     {
        return(users[addr].registered);
     }
    function giveFeedback(string[] memory Answers) public {
        address person = msg.sender;
    require(users[person].registered == true, "User is not registered.");
        require(Answers.length==questionsCount);
        for(uint i=0;i<Answers.length;i++)
        {
            feedbacks.push(Feedbacks({
                qid:i,
                answer:Answers[i]
        }));
        }
        
       
    }
       // Function to retrieve all answers for a specific qid
    function getAnswersForQid(uint _qid) public view returns (string[] memory) {
        // Create a dynamic array to store answers for the given qid
        string[] memory answersForQid = new string[](feedbacks.length);
        uint count = 0;

        // Loop through the feedbacks array
        for (uint i = 0; i < feedbacks.length; i++) {
            // Check if the qid matches
            if (feedbacks[i].qid == _qid) {
                // Add the answer to the dynamic array
                answersForQid[count] = feedbacks[i].answer;
                count++;
            }
        }

        // Resize the array to remove unused space
        assembly {
            mstore(answersForQid, count)
        }

        return answersForQid;
    }
    
}