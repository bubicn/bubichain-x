English | [中文](README_CN.md) 

# WEB

## Introduction

It provides basic web page access capabilities, and the currently available feature is a smart contract syntax detection tool.

## Module Structure

Name | Directory | Function
|:--- | --- | ---
| `jslint` | [jslint](./jslint) | Smart contract detection tool. Refer to [Syntax in Smart Contract](./jslint/ContractRules_CN.md).

## Configuration
- Open [config.json](../../build/win32/config/config.json) and the configuration is shown below:
    ```
    "webserver": {
        "listen_addresses": "0.0.0.0:36002",
        "index_name": "",           # Homepage directory
        "directory": "web/"        # Web directory
    }
    ```
- Copy the folders and files under the directory (web) to the deployment directory `./chain/web/`
- Restart `chain` program
- Visit `http://ip:36002/jslint/index.html`
