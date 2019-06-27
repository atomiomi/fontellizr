const { parse } = require('path');
const { readFileSync } = require('fs');

const getUnicode = require('./get_unicode');
const formatSvg = require('./format_svg');


const randomNum = () => ((Math.random() * 16) | 0).toString(16);
const generateHash = () => (new Array(32)).fill(0).map(() => randomNum()).join('');

module.exports = svgPaths => svgPaths.map((svgPath) => {
  const content = readFileSync(svgPath, 'utf8');
  const { name } = parse(svgPath);

  return {
    uid: generateHash(),
    code: getUnicode(),
    css: name,
    src: 'custom_icons',
    selected: true,
    svg: formatSvg(content),
    search: [name],
  };
});
