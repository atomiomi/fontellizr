const { readdirSync, statSync } = require('fs');
const { join } = require('path');


module.exports = (dir, regExp) => {
  const files = readdirSync(dir, 'utf8');

  const collect = (acc, file) => {
    const filePath = join(dir, file);
    const isDir = statSync(filePath).isDirectory();
    const isMatched = regExp.test(file);

    if (isDir || !isMatched) return acc;
    return acc.concat([filePath]);
  };

  return files.reduce(collect, []);
};
