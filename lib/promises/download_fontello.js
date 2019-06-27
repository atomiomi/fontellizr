const { writeFileSync } = require('fs');
const { parse, basename } = require('path');
const { post, get } = require('needle');
const decompress = require('decompress');

const { FONTELLO_HOST } = require('../utils/constants');


const errorHandler = (err) => { if (err) throw err; };

const getSessionId = (config) => {
  const data = {
    config: {
      buffer: Buffer.from(JSON.stringify(config)),
      content_type: 'application/octet-stream',
    },
  };

  return new Promise((resolve, reject) => {
    post(FONTELLO_HOST, data, { multipart: true }, (err, resp, body) => {
      if (err || resp.statusCode !== 200) return reject(err || resp);
      resolve(body);
    });
  });
};

const downloadFont = (sessionId, options) => {
  const { stylesDestDir, fontsDestDir } = options;

  const map = (file) => {
    if (file.type !== 'file') return;

    const { base, dir } = parse(file.path);
    const folder = basename(dir);

    if (folder === 'css') {
      writeFileSync(`${stylesDestDir}/${base}`, file.data, errorHandler);
    }

    if (folder === 'font') {
      writeFileSync(`${fontsDestDir}/${base}`, file.data, errorHandler);
    }
  };

  return new Promise((resolve, reject) => {
    get(`${FONTELLO_HOST}/${sessionId}/get`, (err, resp) => {
      if (err) return reject(err);
      decompress(resp.body, ({ map })).then(resolve).catch(reject);
    });
  });
};

module.exports = (config, options) => {
  const download = sessionId => downloadFont(sessionId, options);
  return getSessionId(config).then(download);
};
