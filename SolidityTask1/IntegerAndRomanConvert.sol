// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract IntegerAndRomanCovert {
    struct RomanNumeral {
        uint256 value;
        string symbol;
    }
    
    RomanNumeral[] private romanNumerals;
    
    constructor() {
        // 按从大到小顺序初始化罗马数字对应表
        romanNumerals.push(RomanNumeral(1000, "M"));
        romanNumerals.push(RomanNumeral(900, "CM"));
        romanNumerals.push(RomanNumeral(500, "D"));
        romanNumerals.push(RomanNumeral(400, "CD"));
        romanNumerals.push(RomanNumeral(100, "C"));
        romanNumerals.push(RomanNumeral(90, "XC"));
        romanNumerals.push(RomanNumeral(50, "L"));
        romanNumerals.push(RomanNumeral(40, "XL"));
        romanNumerals.push(RomanNumeral(10, "X"));
        romanNumerals.push(RomanNumeral(9, "IX"));
        romanNumerals.push(RomanNumeral(5, "V"));
        romanNumerals.push(RomanNumeral(4, "IV"));
        romanNumerals.push(RomanNumeral(1, "I"));
    }
    /*
      整数转罗马数字
    */
    function intToRoman(uint256 num) public view returns(string memory)  {
         require(num > 0 && num < 4000, "Number must be between 1 and 3999");
         string memory result;
         for (uint256 i = 0; i < romanNumerals.length; i++) {
            while (num >= romanNumerals[i].value) {
                result = string(abi.encodePacked(result, romanNumerals[i].symbol));
                num -= romanNumerals[i].value;
            }
        }
        
        return result;

    }

}



contract RomanToInteger {
    mapping(bytes1 => uint256) private romanValues;
    
    constructor() {
        // 初始化罗马字符映射表
        romanValues['I'] = 1;
        romanValues['V'] = 5;
        romanValues['X'] = 10;
        romanValues['L'] = 50;
        romanValues['C'] = 100;
        romanValues['D'] = 500;
        romanValues['M'] = 1000;
    }
    
    function romanToInt(string memory s) public view returns (uint256) {
        bytes memory roman = bytes(s);
        uint256 total = 0;
        uint256 prevValue = 0;
        
        for (uint256 i = roman.length; i > 0; i--) {
            uint256 currentValue = romanValues[roman[i-1]];
            
            if (currentValue < prevValue) {
                total -= currentValue;
            } else {
                total += currentValue;
            }
            
            prevValue = currentValue;
        }
        
        require(total > 0 && total < 4000, "Invalid Roman numeral");
        return total;
    }
}
