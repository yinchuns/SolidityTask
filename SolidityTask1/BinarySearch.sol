
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    /**
     * @dev 在有序数组中执行二分查找
     * @param arr 已排序的数组（升序）
     * @param target 要查找的目标值
     * @return 目标值的索引（找到时），未找到时返回type(uint256).max
     */
    function search(uint[] memory arr, uint target) public pure returns (uint) {
        uint left = 0;
        uint right = arr.length - 1;
        
        while (left <= right) {
            uint mid = left + (right - left) / 2;
            
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return type(uint256).max; // 返回最大值表示未找到
    }
}
