import 'dapple/test.sol';
import './feedbase.sol';
import 'maker-user/mock.sol';

contract GetProxy is Tester {
    function doGet(uint64 id) returns (bytes32 value) {
        return FeedBase(_t).get(id);
    }
}
contract FeedBaseTest is Test
                       , MakerUserGeneric(MakerTokenRegistry(0x0))
{
    FeedBase fb;
    GetProxy t1;
    uint64 feed1;
    function setUp() {
        _M = new MakerUserMockRegistry();
        fb = new FeedBase(_M);
        t1 = new GetProxy();
        t1._target(fb);
        feed1 = fb.claim();
    }
    function testSetup() {
        assertEq( uint(1), uint(feed1) );
    }
    function testSetGetFree() {
        fb.setFeed(feed1, 0x42, block.timestamp+1);
        var value = t1.doGet(feed1);
        assertEq32(value, 0x42);
    }
    function testSetGetPaid() {
        fb.setFeed(feed1, 0x42, block.timestamp+1);
        fb.setFeedCost(feed1, 100);
        var DAI = _M.getToken("DAI");
        DAI.transfer(t1, 100);

        t1._target(DAI);
        DSToken(t1).approve(fb, 100);
        t1._target(fb);

        assertEq(DAI.balanceOf(t1), 100);
        var pre = DAI.balanceOf(this);
        var value = t1.doGet(feed1);
        var post = DAI.balanceOf(this);
        assertEq(post - pre, 100);
        assertEq(DAI.balanceOf(t1), 0);
        assertEq32(value, 0x42);
    }
    function testSetGetTwicePaidOnce() {
        fb.setFeed(feed1, 0x42, block.timestamp+1);
        fb.setFeedCost(feed1, 100);
        var DAI = _M.getToken("DAI");
        DAI.transfer(t1, 100);

        t1._target(DAI);
        DSToken(t1).approve(fb, 100);
        t1._target(fb);

        var pre = DAI.balanceOf(this);
        var value1 = t1.doGet(feed1);
        var post1 = DAI.balanceOf(this);
        var value2 = t1.doGet(feed1);
        var post2 = DAI.balanceOf(this);
        assertEq(post1 - pre, 100);
        assertEq(post2 - post1, 0);
        assertEq32(value2, 0x42);
    }
    function testFailSetGetPaid() {
        fb.setFeedCost(feed1, 100);
        var value = t1.doGet(feed1);
    }
    function testFailGetExpiredFeed() {
        fb.setFeed(feed1, 0x42, block.timestamp-1);
        fb.get(feed1);
    }
    function testTransfer() {
        fb.transfer(feed1, t1);
        FeedBase(t1).setFeed(feed1, 0x42, block.timestamp+1);
        assertEq32(fb.get(feed1), 0x42);
    }
    event FeedUpdate( uint64 indexed id );
    function testEvents() {
        expectEventsExact(fb);
        fb.setFeedCost(feed1, 0);
        FeedUpdate(feed1);
        fb.setFeed(feed1, 0x42, block.timestamp+1);
        FeedUpdate(feed1);
        fb.transfer(feed1, t1);
        FeedUpdate(feed1);
        var feed2 = fb.claim();
        FeedUpdate(feed2);
    }
}
