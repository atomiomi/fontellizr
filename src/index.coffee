findIndDir = require('./utils/find_in_dir')
generateGlyphs = require('./utils/generate_glyphs')
donwloadFontello = require('./utils/download_fontello')
extractZip = require('./utils/extract_zip')
{ copyDir, removeDir } = require('./utils/fs')

{ DEFAULT_CONFIG, REGEXP_SVG_FILE, TMP_DIR } = require('./utils/constants')


module.exports = (options) ->
  { svgsSourceDir, fontsDestDir, stylesDestDir } = options
  fontelloConfig = Object.assign({}, DEFAULT_CONFIG, options.fontelloConfig)

  # Generate glyphs from svg files
  findIndDir(svgsSourceDir, REGEXP_SVG_FILE).then (svgFiles) ->
    generateGlyphs(svgFiles)

  # Send config to fontello host and download fontello zip to temp folder
  .then (glyphs) ->
    fontelloConfig.glyphs = glyphs
    donwloadFontello(fontelloConfig, tempDir)

  # Extract fontello zip
  .then (fontelloZip) ->
    extractZip(fontelloZip)

  # Copy fonts and styles to destination folders
  .then (fontelloFolder) ->
    Promise.all([
      copyDir("#{fontelloDir}/font", fontsDestDir)
      copyDir("#{fontelloDir}/css", stylesDestDir)
    ])

  .then ->
    console.info('😎 Webfont was successfully generated 😎')
    removeDir(tempDir)

  .catch (err) ->
    console.error(err.message or err)
    removeDir(tempDir)
