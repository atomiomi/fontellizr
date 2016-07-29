findInDir = require('./utils/find_in_dir')
generateGlyphs = require('./utils/generate_glyphs')
donwloadFontello = require('./utils/download_fontello')

{ DEFAULT_CONFIG, REGEXP_SVG_FILE } = require('./utils/constants')


module.exports = (options) ->
  { svgsSourceDir, fontsDestDir, stylesDestDir } = options
  fontelloConfig = Object.assign({}, DEFAULT_CONFIG, options.fontelloConfig)

  findInDir(svgsSourceDir, REGEXP_SVG_FILE).then (svgFiles) ->
    fontelloConfig.glyphs = generateGlyphs(svgFiles.sort())
    donwloadFontello(fontelloConfig, { fontsDestDir, stylesDestDir })

  .then ->
    console.info('Webfont was successfully generated 😎')

  .catch (err) ->
    console.error(err.stack or err)
