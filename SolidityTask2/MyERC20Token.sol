// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/*
 作业 1：ERC20 代币
    任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
    合约包含以下标准 ERC20 功能：
    balanceOf：查询账户余额。
    transfer：转账。
    approve 和 transferFrom：授权和代扣转账。
    使用 event 记录转账和授权操作。
    提供 mint 函数，允许合约所有者增发代币。
    提示：
    使用 mapping 存储账户余额和授权信息。
    使用 event 定义 Transfer 和 Approval 事件。
    部署到sepolia 测试网，导入到自己的钱包
*/
contract MyERC20Token is  ERC20, Ownable  {
    // 存放余额
    mapping(address => uint256) private _balances;
    // 允许被授权的地址（spender）代表代币所有者（owner）进行代币转账
    mapping(address => mapping(address => uint256)) private _allowances;

    /*
      初始化铸造代币 传入name_代币名称  symbol_ 代币简称
      设置管理员权限
    */
    constructor(string memory name_,string memory symbol_) ERC20(name_,symbol_) Ownable(msg.sender) {
        _mint(msg.sender, 100 * 1 * 10 ** 18); // 10000个代币
    }


    /*
      向指定账户增发代币
      onlyOwner 限制只有管理员才能发币
    */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /*
      获取账户余额
    */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

     
     /*
       代币持有者账户向指定账户转账
     */
     function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    /*
     需预先通过approve设置授权额度，transfer无需授权
     授权账户可以将持有者的代币转给指定账户
    */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        // 检测转入地址是否传入为空值
        require(to != address(0), "ERC20: transfer to zero address");
        // 检余额是否足够
        require(_balances[from] >= amount, "ERC20: insufficient balance");
        // 检测转出账户是否有授权额度
        require(_allowances[from][msg.sender] >= amount, "ERC20: insufficient allowance");

        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        
        emit Transfer(from, to, amount);
        return true;
    }




    /*
       向指定账户授权
       允许被授权的地址（spender）代表代币所有者（owner）进行代币转账操作
       设置授权额度
    */
    function approve(address spender, uint256 amount) public override  returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit  Approval(msg.sender, spender, amount);
        return true;
    }



}