[draft] Quickly build dai apps w/ `dapple` and `MakerUser`
---

#### Prerequisites

The only mandatory requirement is `npm`. In order to deploy contracts,
you'll need an Ethereum client like `geth`. If you have a local installation
of `solc`, compiling your contracts will be 5-10x faster.

    $ npm -v
    3.5.3

    $ geth version
    Geth
    Version: 1.3.3

    $ solc --version
    solc, the solidity compiler commandline interface
    Version: 0.2.0-d21c4276/RelWithDebInfo-Linux/g++/int linked to libethereum-1.1.1-eece77c8/RelWithDebInfo-Linux/g++/int


#### Install Dapple

First, get `dapple` via `npm`:

    npm install -g dapple

#### Create a dapple package

    mkdir mydapp && cd mydapp
    dapple init

#### Install `makeruser` package

    dapple install makeruser 0.1.0

Now you have access to the `MakerUser` mixin contract.

A mixin is a contract with only internal functions - it is not an abstract contract (an interface),
but the compiler will only emit anything if you use one of the internal functions in a derived contract.

For now, the best documentation is these example dapps:

[FeedBase](https://github.com/nexusdev/feedbase)

[Maker OTC](https://github.com/makerdao/maker-otc)
