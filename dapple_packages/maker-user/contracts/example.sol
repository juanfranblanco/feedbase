import './user.sol';
// as subpackage: `dapple install makeruser 0.1.0 --as maker`
// import 'maker/user.sol';

contract Example is MakerUser {
    MakerTokenRegistry reg;
    function Example( MakerUserLinkType maker_link )
             MakerUser( maker_link )
    {
    }
}

contract ExampleMainnet is Example(MakerUserLinkType(0x0)) {}
contract ExampleMorden is Example(MakerUserLinkType(0x1)) {}
contract ExamplePrivate is Example {} // Registry set on contract create
