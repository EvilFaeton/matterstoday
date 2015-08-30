$ = require("jquery")
_ = require("underscore")
Promise = require("bluebird")

module.exports = (rss) ->
  Promise.resolve $.ajax(
    url      : document.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=10&callback=?&q=' + encodeURIComponent(rss)
    dataType : 'json'
  )

