pragma solidity ^0.4.6;

contract Data{
    
    struct tree{
        bytes32 root;
        mapping(bytes32=>bytes32) leafAndRoot;
    }

    bytes32 public empty;                                           // Hard codded         
    
    mapping (address=>tree) public users;
    
    function newUser(){                                             // To do - Modifer "onlyNewUser" 
        users[msg.sender];
    }
    
    function addData(
            uint256 _data,              // To do - serialize data/non empty
            address _user)
            returns (bool success){  
        
        var leaf    = keccak256(_data);   // Hashing the input
        var oldRoot = getUserRoot(_user);
        var newRoot = hashTheTwo(leaf, oldRoot);
        
        users[_user].leafAndRoot[leaf] = newRoot;
        users[_user].root = newRoot;

        return true;
    }
    
    function getRoot(
            uint256 _leafData,      // The input is in plain uint256 and hashed format to allow for future UI to be devloped
            address _user)
            constant 
            returns (bytes32 root){ // The root of specific leaf
        
        var leaf = keccak256(_leafData);                                            // Hashing the input
        return users[_user].leafAndRoot[leaf];
    }
    
    function getUserRoot(
                address _user)
                constant
                returns (bytes32 root){ // The higest (last) root      
        return users[_user].root;
    }

    function hashTheTwo
                (bytes32 _a, // To do - serialize data/non empty
                bytes32 _b)  // To do - serialize data/non empty
                constant
                returns (bytes32 hashed){         
        return keccak256(_a, _b);
    }
    
    function checkDataIntegrity
            (uint256[] _data, // To do - serialize data/non empty
            address _user)
            constant         // Run localy
            returns (bool complete){ 
         
         

        var oldRoot = empty;                         // Hard codded                        
        for (uint i = 0; i < _data.length; i++) {    // Reconstructing the tree     
            var data = keccak256(_data[i]);          // Hashing the input
            var root = hashTheTwo(data, oldRoot);
            
            if(root == getRoot(_data[i], _user)){         
                oldRoot = root;
                continue;
            }else{
                return false;
            }
        }        

        if (oldRoot == getUserRoot(_user)){
            return true;
        }else{
            return false;
        }
    }
}
