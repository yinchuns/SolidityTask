// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyFirstNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {

     uint256 private _nextTokenId;
     
     /*
       初始化 铸造nft代币 名称mtNFT  简称mt
       初始化指定管理员Ownable(owner)
     */
     constructor(address owner)ERC721("mtNFT", "mt") Ownable(owner){
         
     }
     
     /*
       to：铸造的NFT指定给哪一个账户
       url：所铸造的元数据的URL
        onlyOwner : 权限控制，只能管理员才有铸造权限
     */
     function safeMint(address to, string memory url) public onlyOwner{
         uint256 tokenId = _nextTokenId++;
         _safeMint(to,tokenId);
         _setTokenURI(tokenId,url);
     }

     
     function _update(address to,uint256 tokenId,address auth) internal override (ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);// 更新nft的所有者
     }

     function _increaseBalance(address account,uint128 value) internal override (ERC721, ERC721Enumerable) {
        return _increaseBalance(account, value);
     }
      
     function tokenURI(uint256 tokenId) public view override (ERC721,ERC721URIStorage) returns (string memory) {
       return super.tokenURI(tokenId);
     }

     function supportsInterface(bytes4 interfaceId) public view override (ERC721,ERC721Enumerable,ERC721URIStorage) returns (bool) {
       return super.supportsInterface(interfaceId);
     }
}