//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transaction{
   struct Details 
   {
	int AccountNumber;
	int AccountBalance;
	string AccountName;
   }

   struct tDetails 
   {
	Details senderAcc;
	Details recieverAcc;
	int tAmount;
	address addr;
   }

   struct oDetails {
	bytes32 transactionDetails;
	bytes32 currentHash;
	bytes32 previousHash;
   }

   oDetails[] blockChain;
	
   modifier costs(uint _amount) 
   {
        require(msg.value >= _amount,"Not enough Ether provided.");
            msg.sender.transfer(msg.value - _amount);
   }
   
   function emptyBlockchain(tDetails transacDetails) public returns oDetails{
     oDetails.transactionDetails = transacDetails;
     oDetails.currentHash = sha256(abi.encodePacked(transacDetails));
     oDetails.previousHash = 0;  //genisis block
     returns oDetails
   }
 
   function nonEmptyBlockchain(tDetails transacDetails) public returns oDetails{
     oDetails.transactionDetails = transacDetails;
     oDetails.currentHash = sha256(abi.encodePacked(transacDetails));
     oDetails.previousHash = blockChain[blockChain.length-1];  //previous block
     returns oDetails;
   }
   
   function insertTransaction(tDetails transacDetails) public returns oDetails[]{
	  (bool success,) = address(oDetails.tDetails.recieverAcc).call(abi.encodeWithSignature("nonExistingFunction()"));
          require(success);
	  costs(transacDetails.tAmount);
	  if(blockChain.length == 0){
	    blockChain.push(emptyBlockchain(transacDetails));
	  } else {
	    blockChain.push(nonEmptyBlockchain(transacDetails));
          }
	  returns blockChain;
	}
}
