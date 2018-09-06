const ora = require('ora');
const findInDir = require('./utils/find_in_dir');
const generateGlyphs = require('./utils/generate_glyphs');
const donwloadFontello = require('./promises/download_fontello');
const { DEFAULT_CONFIG, REGEXP_SVG_FILE } = require('./utils/constants');


module.exports = (options) => {
  const { svgsSourceDir, fontsDestDir, stylesDestDir } = options;
  const svgFiles = findInDir(svgsSourceDir, REGEXP_SVG_FILE);

  const config = {
    ...DEFAULT_CONFIG,
    ...options.fontelloConfig,
    glyphs: generateGlyphs(svgFiles.sort()),
  };

  const promise = donwloadFontello(config, { fontsDestDir, stylesDestDir });
  ora.promise(promise, { text: 'Downloading fontello font' });
};
