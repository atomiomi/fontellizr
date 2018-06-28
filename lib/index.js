const findInDir = require('./utils/find_in_dir');
const generateGlyphs = require('./utils/generate_glyphs');
const donwloadFontello = require('./promises/download_fontello');
const { DEFAULT_CONFIG, REGEXP_SVG_FILE } = require('./utils/constants');


const handleSuccess = () => console.info('Webfont was successfully generated 😎');
const handleError = (err) => console.error(err.stack || err);

module.exports = (options) => {
  const { svgsSourceDir, fontsDestDir, stylesDestDir } = options;
  const svgFiles = findInDir(svgsSourceDir, REGEXP_SVG_FILE);

  const config = {
    ...DEFAULT_CONFIG,
    ...options.fontelloConfig,
    glyphs: generateGlyphs(svgFiles.sort()),
  };

  donwloadFontello(config, { fontsDestDir, stylesDestDir })
    .then(handleSuccess)
    .catch(handleError);
};
