// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

//导入 OpenZeppelin 库中的 ERC721 合约和 Counters 工具
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

//定义了一个名为 GameNFT 的智能合约，采用 ERC721 合约
contract GameNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct GameEntity {
        string entityType;
        string name;
        string description;
        uint256 power;
        //这几行定义了一个名为 GameEntity 的结构，
        //包含 entityType（实如角色、道具等）、name（名称）、
        //description（描述）和 power（能力值）等属性。
    }

    mapping(uint256 => GameEntity) private _entities;
    //这行定义了一个私有映射 _entities，将 tokenId（uint256 类型）映射到相应的 GameEntity 结构体。
    constructor() ERC721("GameNFT", "GNFT") {}

function createEntity(
    address owner, 
    string memory entityType, 
    string memory name, 
    string memory description, 
    uint256 power
    //定义了一个名为 createEntity 的公共函数，用于创建新的游戏实体。函数接收以下参数：
    //powner（拥有者地址）、entityType（实体类型）、name（名称）、description（描述）和 power（能力值）
) 
    public 
    returns (uint256) 
{
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _mint(owner, newItemId);
    
     _entities[newItemId] = GameEntity(entityType, name, description, power);
     return newItemId;
     }

    function getEntity(uint256 tokenId) public view returns (GameEntity memory) {
        return _entities[tokenId];
    }
}
