English | [中文](manual_CN.md) 

# __CHAIN Blockchain Manual Doc__

<!-- TOC -->
- [__Compile__](#compile)
    - [Linux](#linux)
    - [MAC](#mac)
    - [Windows](#windows)
- [__Deployment__](#deployment)
    - [__Requirement__](#requirement)
    - [__Installation on Linux__](#installation-on-linux)
        - [__Use compile mode deploy__](#use-compile-mode-deploy)
        - [__Use archive packet deploy__](#use-archive-packet-deploy)
    - [__Catalog Structure__](#catalog-structure)
    - [__Switch to Target Network__](#switch-to-target-network)
    - [__Operation__](#operation)
    - [__Operating Status__](#operating-status)
    - [__Configuration__](#configuration)
	    - [Data Storage](#data-storage)
	    - [Network Communication between Nodes](#network-communication-between-nodes)
	    - [WEB API Configuration](#web-api-configuration)
	    - [WebSocket API Configuration](#websocket-api-configuration)
	    - [Block Configuration](#block-configuration)
	    - [Initial Block](#initial-block)
	    - [Log Configuration](#log-configuration)
	    - [Multi-nodes Cluster Configuration](#multi-nodes-cluster-configuration)
	    - [Network Communication between Nodes](#network-communication-between-nodes)
	    - [Consensus Parameter](#consensus-parameter)
	    - [Block Parameter](#block-parameter)
	    - [Synchronizing Nodes](#synchronizing-nodes)
	    - [Encrypting Data](#encripting-nodes)
- [__Operation and Maintenance__](#operation-and-maintenance)
    - [Service Start and Stop](#service-start-and-stop)
    - [Get Modules Status](#get-modules-status)
    - [Get Account Information](#get-account-information)
    - [Drop Database](#drop-database)   
    - [Create Hard Fork](#create-hard-fork)   
    - [Data Storage Dir](#data-storage-dir)   


<!-- /TOC -->

## __Compile__ 

If you don't want to compile the source code, you can use the archive package directly, [archive package download](https://github.com/bumoproject/bumo/releases/ "download")，[use archive packet deploy](#use-archive-packet-deploy)

### Linux
CHAIN is currently available for Ubuntu, Centos and most of the operating systems, it is recommended that you have Ubuntu 14.04 or Centos 7. The following demo is based on Ubuntu 14.04 .

- Dependencies

```bash
sudo apt-get install automake
sudo apt-get install autoconf
sudo apt-get install libtool
sudo apt-get install g++
sudo apt-get install libssl-dev
sudo apt-get install cmake
sudo apt-get install libbz2-dev
sudo apt-get install python
sudo apt-get install unzip
```
- Compilation
```bash
##After the first download of the code, you have to install related dependencies from the server for initializing the development environment.
cd chain/build/
./install-build-deps-linux.sh
cd ../
make
```

Executable program dir:chain/bin

### MAC
- Depending on MAC OS X 10.11.4 or later
- Install the latest version of Xcode and Command Tools(8.0 version or later). You can get it from [Apple's website](https://developer.apple.com/download/more/) or [Apple's app store](https://itunes.apple.com/us/app/xcode/id497799835).
- Install **brew**: Get more information [here](https://brew.sh/index.html)
- Install dependencies with **brew**

 ```
bash
export HOMEBREW_NO_AUTO_UPDATE=true
brew install automake
brew install autoconf
brew install libtool
brew install cmake
brew install python
brew install m4
brew install wget
 ```

- Compilation


 ```
bash
#Downloading the code at the first time, you have to install related dependencies from the server for initializing the development environment.
cd chain/build/
./install-build-deps-mac.sh
cd ../
make
 ```

Temporary executable program dir:chain/bulid/mac/

Executable program dir:chain/bin/

### Windows
- Supports WinXP/2003/Vista/7/8/10 to building，Recommended Win10
- Install Visual Studio Ultimate 2013
- Compile `buchain\build\win32\Chain.vs12.sln` with VS, then get the executable program in the dir `chain\build\win32\dbin`
- After the first download of the code, you have to install related dependencies from the server to initialize the development environment. Enter the dir `build`, and double click the following:`install-build-deps-win32.bat`.

## Deployment
The deployment on Windows is almost identical to Linux. (Subject to Linux)

### __Requirement__
- Recommended configuration: CPU 8 core, memory 32 G, bandwidth 20 M, SSD disk 500 G. Or higher.
- Minimum configuration: CPU 4 core, memory 16 G, bandwidth 10 M, SSD disk 500 G.

### __Installation on Linux__
#### __Use compile mode deploy__
```bash
cd chain
make install
```

Install under `/usr/local/buchain/`

Deploy ok!

#### __Use archive packet deploy__

This is another deployment, using the archive packet.

Extract files

Copy buchain-`1.0.0.x`-linux-x64.tar.gz to /usr/local/

    cd /usr/local/
    //Note the name of the actual version of the package 1.0.0.x.
    tar xzvf buchain-1.0.0.x-linux-x64.tar.gz

Registration service

    ln -s /usr/local/buchain/scripts/chain /etc/init.d/chain 
    ln -s /usr/local/buchain/scripts/chaind /etc/init.d/chaind 

Modify startup path

Open ./buchain/scripts/chain 和 ./buchain/scripts/chaind 

Modify `install_dir` to Buchain's deployment path

    install_dir=/usr/local/buchain 

Setup startup

    #Execute the following commands separately.（level: 1~5）
    ln -s -f /etc/init.d/chaind /etc/rc1.d/S99chaind 
    ln -s -f /etc/init.d/chaind /etc/rc2.d/S99chaind
    ln -s -f /etc/init.d/chaind /etc/rc3.d/S99chaind 
    ln -s -f /etc/init.d/chaind /etc/rc4.d/S99chaind 
    ln -s -f /etc/init.d/chaind /etc/rc5.d/S99chaind 

Add the following command at the end of the `/etc/rc.local` file.

    /etc/init.d/chaind start

Save and add executable permissions.： 

    chmod +x /etc/rc.local

Deploy ok!

### __Catalog Structure__

Catalog | Description 
|:--- | --- 
| bin | Executable program（Compiled chain exe）
|jslib| Third-party js libraries
| config | Configuration profile, including `config.json`
| data | Warehouse of ledger data
| script | Activate script
| log | Running log


### __Switch to Target Network__

Switch runtime environment of CHAIN manually:

1. Stop chain program

```bash
    service chain stop
```
2. Replace configuration profile

```bash
    cd /usr/local/buchain/config/
    #Copy the target configuration profile
    cp config-testnet.json config.json  

    #About configuration profile
    config.json           ##debugging environment is default
    config-mainnet.json   ##configuration profile of main network
    config-testnet.json   ##configuration profile of test network
    config-single.json    ##configuration profile of single network for debug
```
3. Drop database and restart service

```bash
    cd ../
    ./bin/chain --dropdb
    service chain start
```
### __Operation__

```bash
    service chain start
```

### __Operating Status__ 

```bash
    service chain status
```

### __Configuration__

config.json 

#### Data Storage

```json
    "db":{
		"account_path": "data/account.db", //store account data
		"ledger_path": "data/ledger.db", //store block data
		"keyvalue_path": "data/keyvalue.db" //store consensus data
    }
```
#### Network Communication between Nodes
```json
    "p2p":{
        "network_id":10000,//Network ID, to distinguish test network from main network
        //consensu network
        "consensus_network":{
            "heartbeat_interval":60,
            "listen_port":16001,//listened port
            "target_peer_connection":50,
            "known_peers":[
                "127.0.0.1:16001"//link known nodes
            ]
        }
    }
```

#### WEB API Configuration

```json
    "webserver":{
        "listen_addresses":"0.0.0.0:16002"
    }
```

#### WebSocket API Configuration 

```json
    "wsserver":{
        "listen_address":"0.0.0.0:16003"
    }
```

#### Block Configuration

```json
    "ledger":{
        "validation_address":"buQBwe7LZYCYHfxiEGb1RE9XC9kN2qrGXWCY",//validation node's address( NO NEED to configurate for synchronized nodes or wallets)
        "validation_private_key": "66932f19d5be465ea9e7cfcb3ea7326d81953b9f99bc39ddb437b5367937f234b866695e1aae9be4bae27317c9987f80be882ae3d2535d4586deb3645ecd7e54", //validation node's private key( NO NEED to configurate for synchronized nodes or wallets)
        "max_trans_per_ledger":1000,  //the maximum number of transactions per block.
        "tx_pool":{
            "queue_limit":10240,
            "queue_per_account_txs_limit":64
        }
    }
```
#### Initial Block
```json
   "genesis": {
        "account": "buQs9npaCq9mNFZG18qu88ZcmXYqd6bqpTU3", //account of initial block
        "slogan" : "a new era of value",
        "fees": {
            "base_reserve": 10000000,  // based reserve of the account
            "byte_fee": 1000           //byte fee
        },
        "validators": ["buQBwe7LZYCYHfxiEGb1RE9XC9kN2qrGXWCY"] //validated nodes list
    }
```
    In the same blockchain, the configuration of `genesis` should keep consistent.

#### Log Configuration

```json
    "logger":{
        "path":"log/chain.log", // log catalog
        "dest":"FILE|STDOUT|STDERR", //classification of output files
        "level":"TRACE|INFO|WARNING|ERROR|FATAL",//log level
        "time_capacity":1,
        "size_capacity":10,
        "expire_days":10
    }
```

#### Multi-nodes Cluster Configuration

- Example for running multi-nodes on a single blockchain (mostly alter `p2p`,`validation`,`ledger`sections ):

#### Network Communication between Nodes

- config.p2p.consensus_network.known_peers  // add the IP and address of other nodes

#### Consensus Parameter

- validators //add the validated address of other nodes
- address and node_private_key should be in pairs

#### Block Parameter
- `config.ledger.genesis_account` is the initial account. In the same blockchain, the configuration of ` genesis_account` should be kept consistent.

Note: Ensure the initial data of every node is consistent before running. Or else the consensus for creating blocks would fail.

#### Synchronizing Nodes
 - The difference on configuration between synchronized node and validation node is that **you do not need to add `validation address` in consensus configuration of synchronized node.** 

##### Encrypting Data
All the private information of configuration profile is encrypted, and the decryption key is hard-coded in the program. To decrypt the information, you have to get the key in clear format, then transform the key as following:

- command `./bin/chain --aes-crypto [key]`

```bash
[root@localhost buchain]# ./bin/chain --aes-crypto root 
e2ba44bf0b27f0acbe7b5857e3bc6348
```
- The information of configuration needs to be encrypted

name | description 
|:--- | --- 
| config.validation.node_private_key | private key of validation node

## __Operation and Maintenance__
### Service Start and Stop
```
Start    :service chain start
Stop    :service chain stop
Running status:service chain status
```
### Get Modules Status

```bash
[root@centos7x64-201 ~]# curl 127.0.0.1:19333/getModulesStatus
{
    "glue_manager":{
        "cache_topic_size":0,
        "ledger_upgrade":{
            "current_states":null,
            "local_state":null
        },
        "system":{
            "current_time":"2017-07-20 10:32:22", //current time
            "process_uptime":"2017-07-20 09:35:06", //starting time of chain 
            "uptime":"2017-05-14 23:51:04"
        },
        "time":"0 ms",
        "transaction_size":0
    },
    "keyvalue_db":Object{...},
    "ledger_db":Object{...},
    "ledger_manager":{
        "account_count":2316,  //count of accounts
        "hash_type":"sha256",
        "ledger_sequence":12187,
        "time":"0 ms",
        "tx_count":1185   //count of transactions
    },
    "peer_manager":Object{...},
    "web server":Object{...},

```
### Get Account Information

```bash
[root@centos7x64-201~]#curl 127.0.0.1:19333/getAccount?address=a0024111d1cc90ac8ee0abd5f957e08e3e1b442b581e88
{
  "error_code": 0,
  "result": {
    "address": "a0024111d1cc90ac8ee0abd5f957e08e3e1b442b581e88",
    "assets": null,
    "assets_hash": "ad67d57ae19de8068dbcd47282146bd553fe9f684c57c8c114453863ee41abc3",
    "contract": null,
    "metadatas": null,
    "priv": {
      "master_weight": 1,
      "thresholds": {
        "tx_threshold": 1
      }
    },
    "storage_hash": "ad67d57ae19de8068dbcd47282146bd553fe9f684c57c8c114453863ee41abc3"
  }
} 
[root@centos7x64-201 ~]#

```
### Drop Database
```bash
buchain/bin/chain --dropdb
```
### Create Hard Fork
```bash
buchain/bin/chain --create-hardfork
buchain/bin/chain --clear-consensus-status
```
- As the node has joined an existing blockchain that would like to run a standalone blockchain, a hard fork can be created with the commands above.  After hard fork, there is only one validation node(local node)on the new blockchain.

- After executing the hard fork command, you will get a hash as following:
```bash
Create hard fork ledger successful, seq(20), consensus value hash(**7aa332f05748e6ce9ad3d059c959a50675109bcaf0a4ba2c5c6adc6418960197**)
```
- In the local node or synchronized node, add the hash with parameter `hardfork_points` into `config.json`.

```json
    "ledger": {
       	"genesis_account": "buQs9npaCq9mNFZG18qu88ZcmXYqd6bqpTU3",
        "max_trans_per_ledger": 1000,
        "hardfork_points" : 
        [
        	"7aa332f05748e6ce9ad3d059c959a50675109bcaf0a4ba2c5c6adc6418960197"
        ]
    },
```

- Start service

### Data Storage Dir
`buchain/data` is the default dir to store CHAIN blockchain data. You can change the dir as you need in the configuration profile.
