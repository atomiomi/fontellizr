const SvgPath = require('svgpath');
const svgFlatten = require('../../vendor/_svg_image_flatten');


module.exports = (content) => {
  const {
    d,
    width,
    height,
    x,
    y,
  } = svgFlatten(content);

  const scale = 1000 / height;

  const newWidth = Math.round(width * scale);
  const path = new SvgPath(d)
    .translate(-x, -y)
    .scale(scale)
    .abs()
    .round(1)
    .toString();

  return { path, width: newWidth };
};
