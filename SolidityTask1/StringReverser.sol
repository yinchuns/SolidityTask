// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*
  反转字符串 (Reverse String)
  题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
*/
contract StringReverser {
    function revers(string memory _input) public pure returns (string memory){
        bytes memory inputBytes = bytes(_input);
        uint  length = inputBytes.length; // 将字符串转换为字节数组
        bytes memory reversed = new bytes(length); // 创建一个新的字节数组来存储反转后的字符串
        for (uint i = 0;i < length; i++ ){
            reversed[i] = inputBytes[length - 1 - i];
        }
        return string(reversed);
    }

}