document.addEventListener("DOMContentLoaded", redraw)

function redraw() {
  ReactDOM.render(
    renderFeeds(),
    document.getElementById("feeds")
  )
}

// Indentation is easier if children is an array.
var tag = function(type, props, children) {
  return React.createElement.apply(
    null, [type, props].concat(children || [])
  )
}

var state = Immutable.fromJS({
  feeds: [{
    id: 421,
    value: "lorem ipsum dolor sit amet",
    updated: "2016-03-07 13:38:40",
    expires: "2016-03-08 13:38:40",
    price: 100,
    paid: false,
  }, {
    id: 319,
    value: "consectetur adipiscing elit",
    updated: "2016-02-03 15:43:01",
    expires: "2016-05-08 04:34:20",
    price: 50,
    paid: true,
  }],
})

function renderFeeds() {
  return tag("div", {}, [
    state.get("feeds").map(function(feed) {
      return tag("table", {
	className: "f", key: feed.get("id"),
      }, [
	tag("tbody", {}, [
	  tag("tr", {}, [
	    tag("th", {}, "ID"),
	    tag("td", {}, "#" + feed.get("id")),
	  ]),
	  tag("tr", {}, [
	    tag("th", {}, "Value"),
	    tag("td", { className: "value" }, feed.get("value")),
	  ]),
	  tag("tr", {}, [
	    tag("th", {}, "Updated"),
	    tag("td", {}, feed.get("updated")),
	  ]),
	  tag("tr", {}, [
	    tag("th", {}, "Expires"),
	    tag("td", {}, feed.get("expires")),
	  ]),
	  tag("tr", {}, [
	    tag("th", {}, "Price"),
	    tag("td", {}, "⬙" + feed.get("price")),
	  ]),
	  tag("tr", {}, [
	    tag("th", {}, "Paid"),
	    tag("td", {}, feed.get("paid") ? "yes" : "no"),
	  ]),
	])
      ])
    })
  ])
}
