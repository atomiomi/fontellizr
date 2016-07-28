{ parse } = require('path')
{ readFileSync } = require('fs')

getUnicode = require('./get_unicode')
formatSvg = require('./format_svg')


generateHash = ->
  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'.replace /[x]/g, ->
    ((Math.random() * 16) | 0).toString(16)

module.exports = (svgPaths) ->
  for svgPath in svgPaths
    content = readFileSync(svgPath)
    name = parse(svgPath).name

    uid: generateHash()
    code: getUnicode()
    css: name
    src: 'custom_icons'
    selected: true
    svg: formatSvg(content)
    search: [name]
