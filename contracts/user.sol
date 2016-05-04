import './feedbase.sol';

contract FeedBaseUser is MakerUser
{
    FeedBase _feedbase;
    function FeedBaseUser( FeedBase feedbase, MakerUserLinkType makerlink )
             MakerUser( makerlink )
    {
        // static link trick
        if( feedbase == address(0x0) ) {
            // mainnet
            //_feedbase = FeedBase(0x0);
            throw;
        } else if (feedbase == address(0x1) ) {
            // morden
            //_feedbase = FeedBase(0x1);
            throw;
        } else {
            _feedbase = feedbase;
        }
    }
}
