import 'dappsys/token/eth_wrapper.sol';
import 'dappsys/token/base.sol';
import './interfaces.sol';

contract MakerUserMockRegistry is MakerTokenRegistry {
    function MakerUserMockRegistry() {
        var million = 10**18 * 10**6;
        var mkr = new DSTokenBase(million);
        mkr.transfer(msg.sender, million);
        var dai = new DSTokenBase(million);
        dai.transfer(msg.sender, million);
        var eth = new DSEthToken();
        set("MKR", bytes32(address(mkr)));
        set("DAI", bytes32(address(dai)));
        set("ETH", bytes32(address(eth)));
    }
}

