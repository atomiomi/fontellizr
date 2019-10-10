const {
  UNICODE_CODES_MIN,
  UNICODE_CODES_MAX,

  UNICODE_PRIVATE_USE_AREA_MIN,
  UNICODE_PRIVATE_USE_AREA_MAX,

  RESTRICTED_BLOCK_MIN,
  RESTRICTED_BLOCK_MAX,
  RESTRICTED_SINGLE_CODES,
} = require('./constants');


const usedCodes = {};

const isCodeValid = (code) => (
  code >= UNICODE_CODES_MIN
  && code <= UNICODE_CODES_MAX
  && (code < RESTRICTED_BLOCK_MIN || code > RESTRICTED_BLOCK_MAX)
  && !RESTRICTED_SINGLE_CODES[code]
);

module.exports = () => {
  let code = UNICODE_PRIVATE_USE_AREA_MIN;
  while ((!isCodeValid(code) || usedCodes[code]) && code <= UNICODE_PRIVATE_USE_AREA_MAX) {
    code += 1;
  }

  usedCodes[code] = true;
  return code;
};
