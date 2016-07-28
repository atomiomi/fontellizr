# Wrapper for vendor module which is taken from fontello repo
svgImageFlatten = require('../../vendor/_svg_image_flatten')


module.exports = (content) ->
  { d, width } = svgImageFlatten(content)
  { path: d, width }
