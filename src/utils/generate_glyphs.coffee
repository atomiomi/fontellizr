{ parse } = require('path')
{ readFileSync } = require('fs')

getUnicode = require('./get_unicode')
formatSvg = require('./format_svg')


randomNum = -> ((Math.random() * 16) | 0).toString(16)
generateHash = -> (randomNum() for i in [1..32]).join()

module.exports = (svgPaths) ->
  for svgPath in svgPaths
    content = readFileSync(svgPath, 'utf8')
    name = parse(svgPath).name

    uid: generateHash()
    code: getUnicode()
    css: name
    src: 'custom_icons'
    selected: true
    svg: formatSvg(content)
    search: [name]
