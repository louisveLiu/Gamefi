这个智能合约是一个基于 ERC721 标准的游戏 NFT 合约。

合约中定义了一个名为 GameEntity 的结构体，包含实体类型、名称、描述和能力值等属性，并通过映射将其与相应的 tokenId 建立联系。

合约中还定义了创建实体、获取实体和转移 NFT 等函数。

# 函数介绍

## 1.构造函数

```
constructor() ERC721("GameNFT", "GNFT") {}
```

构造函数中初始化了 ERC721 的名称和简称。

## 2.createEntity 函数

```
function createEntity(address owner, string memory entityType, string memory name, string memory description, uint256 power) public returns (uint256) 
```

创建实体的函数，接收以下参数：

owner：拥有者地址

entityType：实体类型

name：名称

description：描述

power：能力值

函数会创建一个新的 tokenId，并将其与相应的 GameEntity 结构体建立映射关系，最后返回新创建的 tokenId。

## 3.getEntity 函数

```
function getEntity(uint256 tokenId) public view returns (GameEntity memory) 
```

获取实体的函数，接收一个 tokenId 参数，并返回与之对应的 GameEntity 结构体。

# 结构体介绍

## GameEntity 结构体

```
struct GameEntity {
    string entityType;
    string name;
    string description;
    uint256 power;
}
```

GameEntity 结构体包含以下属性：

entityType：实体类型

name：名称

description：描述

power：能力值

# 其他说明

本智能合约还包含了一些基础 ERC721 函数的实现，例如 safeTransferFrom、approve 等。

请在 OpenZeppelin 库中查看相应的源代码实现。
