$ = require("jquery")

module.exports = ->
  image = width: 1440, height: 911
  target = x: 390, y: 490

  windowWidth = $(window).width()
  windowHeight = $(window).height()

  xScale = windowWidth / image.width
  yScale = windowHeight / image.height
  scale = null
  yOffset = 0
  xOffset = 0

  if xScale > yScale
    scale = xScale
    yOffset = (windowHeight - (image.height * scale)) / 2
  else
    scale = yScale
    xOffset = (windowWidth - (image.width * scale)) / 2

  {
    top: ((target.y) * scale + yOffset) - 20
    left: ((target.x) * scale + xOffset) - 20
  }
