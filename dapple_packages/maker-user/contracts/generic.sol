import './interfaces.sol';

contract MakerUserGeneric {
    MakerTokenRegistry _M;

    // `registry` MUST throw for invalid `getToken` calls (unset tokens).
    // Use a registry derived from `DSNullMap`, for example.
    // Tokens contracts must not return true on failure!
    function MakerUserGeneric( MakerTokenRegistry registry ) {
        _M = registry;
    }

    function getToken(bytes32 symbol) internal constant returns (DSToken t) {
        return _M.getToken(symbol);
    }
    function totalSupply(bytes32 symbol) internal constant returns (uint supply) {
        return getToken(symbol).totalSupply();
    }
    function balanceOf( address who, bytes32 symbol ) internal constant returns (uint value) {
        return getToken(symbol).balanceOf(who);
    }
    function allowance( address owner
                      , address spender
                      , bytes32 symbol)
        internal
        constant
        returns (uint _allowance)
    {
        return getToken(symbol).allowance(owner, spender);
    }
    function transfer( address to, uint value, bytes32 symbol) internal returns (bool ok)
    {
        var success = getToken(symbol).transfer(to, value);
        if( !success ) throw;
        return success;
    }
    function transferFrom( address from, address to, uint value, bytes32 symbol)
        internal 
        returns (bool ok)
    {
        var success = getToken(symbol).transferFrom(from, to, value);
        if( !success ) throw;
        return success;
    }
    function approve(address spender, uint value, bytes32 symbol) internal returns (bool ok)
    {
        var success = getToken(symbol).approve(spender, value);
        if( !success ) throw;
        return success;
    }

    modifier costs( uint amount, bytes32 symbol )
    {
        if( transferFrom(msg.sender, this, amount, symbol) ) {
            _
        } else {
            throw;
        }
    }
    function toWei(uint quantity) internal returns (uint wei_quantity) {
        wei_quantity = quantity * (10**18);
        // check overflow
        if( wei_quantity / 10**18 != quantity ) {
            throw;
        }
        return wei_quantity;
    }
}


