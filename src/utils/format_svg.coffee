SvgPath = require('svgpath')
svgFlatten = require('../../vendor/_svg_image_flatten')


module.exports = (content) ->
  { d, width, height, x, y } = svgFlatten(content)
  scale  = 1000 / height

  width = Math.round(width * scale)
  path = new SvgPath(d)
    .translate(-x, -y)
    .scale(scale)
    .abs()
    .round(1)
    .toString()

  { path, width }
