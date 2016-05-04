/*import 'dapple/debug.sol'; */
import 'maker-user/user.sol';

contract FeedBase is MakerUser 
//, Debug
{
    function FeedBase( MakerUserLinkType M )
             MakerUser( M )
    {}

    struct FeedEntry {
        bytes32 value;
        address owner;
        uint timestamp;
        uint expiration;
        uint cost;
        bool paid;
    }

    event FeedUpdate( uint64 indexed id );

    uint32 last_id;
    mapping( uint64 => FeedEntry ) _feeds;

    modifier feed_owner( uint64 id ) {
        if( msg.sender != _feeds[id].owner ) {
            throw;
        }
        _
    }
    function setFeed(uint64 id, bytes32 value, uint expiration)
             feed_owner( id )
    {
        var entry = _feeds[id];
        entry.value = value;
        entry.timestamp = block.timestamp;
        entry.expiration = expiration;
        entry.paid = false;
        FeedUpdate( id );
    }
    function setFeedCost(uint64 id, uint cost)
             feed_owner( id )
    {
        _feeds[id].cost = cost;
        FeedUpdate( id );
    }
    function claim() returns (uint64 id) {
        last_id++;
        if( last_id == 0 ) { // ran out of IDs
            throw;
        }
        _feeds[last_id].owner = msg.sender;
        FeedUpdate(last_id);
        return last_id;
    }
    function transfer(uint64 id, address to)
             feed_owner( id )
    {
        _feeds[id].owner = to;
        FeedUpdate( id );
    }

    function get( uint64 id ) returns (bytes32 value) {
        var entry = _feeds[id];
        if( block.timestamp > entry.expiration ) {
            throw;
        }
        if( !entry.paid ) {
            transferFrom(msg.sender, entry.owner, entry.cost, "DAI");
            entry.paid = true;
        }
        return entry.value;
    }
}



contract FeedBaseMainnet is FeedBase(MakerUserLinkType(0x0)) {}
contract FeedBaseMorden is FeedBase(MakerUserLinkType(0x1)) {}





