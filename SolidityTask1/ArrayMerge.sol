
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
合并两个有序数组 (Merge Sorted Array)
题目描述：将两个有序数组合并为一个有序数组。
*/
contract ArrayMerger {
    function merge(uint[] memory arr1, uint[] memory arr2) public pure returns (uint[] memory) {
        uint[] memory result = new uint[](arr1.length + arr2.length);
        uint i = 0;
        uint j = 0;
        uint k = 0;
        
        while (i < arr1.length && j < arr2.length) {
            if (arr1[i] < arr2[j]) {
                result[k++] = arr1[i++];
            } else {
                result[k++] = arr2[j++];
            }
        }
        
        while (i < arr1.length) {
            result[k++] = arr1[i++];
        }
        
        while (j < arr2.length) {
            result[k++] = arr2[j++];
        }
        
        return result;
    }
}
