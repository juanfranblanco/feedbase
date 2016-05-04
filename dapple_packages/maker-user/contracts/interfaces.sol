import 'dappsys/token/erc20.sol';
import 'dappsys/token/registry.sol';

// A magic type which is either a MakerTokenRegistry or a flag indicating
// the network whose singleton to use (0 for mainnet, 1 for morden).
contract MakerUserLinkType {}

// Maker's curated DSTokenRegistry
// live:   0x0 -> 0xc6882fbffd309dc976dd6e4c79cc91e4c1482140
// morden: 0x1 -> 0x877c5369c747d24d9023c88c1aed1724f1993efe
contract MakerTokenRegistry is DSTokenRegistry, MakerUserLinkType {}
contract MakerAssetRegistry is DSTokenRegistry, MakerUserLinkType {}


