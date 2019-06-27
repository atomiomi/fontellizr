const ora = require('ora');
const findInDir = require('./utils/find_in_dir');
const generateGlyphs = require('./utils/generate_glyphs');
const donwloadFontello = require('./promises/download_fontello');
const { DEFAULT_CONFIG, REGEXP_SVG_FILE } = require('./utils/constants');


const sortAlphabetically = (a, b) => a.localeCompare(b);

module.exports = (options) => {
  const { svgsSourceDir, fontsDestDir, stylesDestDir } = options;

  const svgFiles = findInDir(svgsSourceDir, REGEXP_SVG_FILE);
  svgFiles.sort(sortAlphabetically);

  const config = {
    ...DEFAULT_CONFIG,
    ...options.fontelloConfig,
    glyphs: generateGlyphs(svgFiles),
  };

  const promise = donwloadFontello(config, { fontsDestDir, stylesDestDir });
  ora.promise(promise, { text: 'Downloading fontello font' });
};
