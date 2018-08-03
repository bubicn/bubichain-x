[English](README.md) | 中文

## 模块简介
`consensus` 模块是区块链的核心模块之一。BUBICHAIN将交易集合打包，创建共识提案，交由 `consensus` 模块进一步处理。区块链内的各个节点通过 `consensus` 模块对提案进行审核和表决投票，各节点对提案达成一致后，再交由其他模块执行提案内的交易，最终生成区块。

## 模块组成
类名称 | 声明文件 | 功能
|:--- | --- | ---
|`ConsensusManager` | [consensus_manager.h](./consensus_manager.h) | 负责共识模块的整体管理和对其他模块的交互工作。
|`Consensus`        | [consensus.h](./consensus.h)                 | 定义了共识的主要功能框架，并实现了部分接口，具体采用何种共识算法以及详细实现交由派生类去处理。
|`Pbft`             | [bft.h](./bft.h)                             | 根据 `pbft` 算法实现得具体地共识处理类，派生自 `Consensus` 类，负责具体的共识流程的处理。
|`PbftInstance`     | [bft_instance.h](./bft_instance.h)           | 提案的共识实例类。每个 `PbftInstance` 对象对应一个提案的共识实例，记录了提案的内容、所处共识流程的阶段、各共识阶段收集的共识消息等数据，以支持 `Pbft` 根据具体实例做具体共识处理。
|`ConsensusMsg`     | [consensus_msg.h](./consensus_msg.h)         | 共识消息的包装类，除了共识消息内容外，还包括消息序号、消息类型、发送消息的节点、消息哈希等，以供消息接收方校验和分类处理。

## 框架流程
- 主节点的 `ConsensusManager` 收到 `glue` 模块提交的共识提案后，通过 `Consensus` 交由 `Pbft` 具体处理。
- `Pbft` 为共识提案生成 `PbftInstance` 实例，并将提案的内容写入 `PbftInstance` 实例，然后将提案广播给其他共识节点共识。
- 共识节点之间使用 `ConsensusMsg` 包装的消息进行通信，并将共识各阶段的通信内容和处理数据写入 `PbftInstance` 实例。
- 最终，达成一致后，将共识提案通过 `glue` 模块交由 `ledger` 模块执行。


