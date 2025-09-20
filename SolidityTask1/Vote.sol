// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
/*
创建一个名为Voting的合约，包含以下功能：
一个mapping来存储候选人的得票数
一个vote函数，允许用户投票给某个候选人
一个getVotes函数，返回某个候选人的得票数
一个resetVotes函数，重置所有候选人的得票数
*/

contract Vote {
    mapping (string => uint256 ) public  candidateVotes;

    event Voted(address indexed  voter, string candidate);

    function vote(string memory candidate) public {
        candidateVotes[candidate] += 1;
        emit Voted(msg.sender, candidate);
    }

    // 查询票数
    function getVotes(string memory candidate) public  view returns(uint256){
        return candidateVotes[candidate];
    }

    // 重置票数
    function resetVotes(string memory candidate) public {
        candidateVotes[candidate] = 0;
    }
}