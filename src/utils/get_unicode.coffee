{
  UNICODE_CODES_MIN,
  UNICODE_CODES_MAX,

  UNICODE_PRIVATE_USE_AREA_MIN,
  UNICODE_PRIVATE_USE_AREA_MAX,

  RESTRICTED_BLOCK_MIN,
  RESTRICTED_BLOCK_MAX,
  RESTRICTED_SINGLE_CODES
} = require('./constants')


usedCodes = {}

isCodeValid =  (code) ->
  code >= UNICODE_CODES_MIN and
  code <= UNICODE_CODES_MAX and
  (code < RESTRICTED_BLOCK_MIN or code > RESTRICTED_BLOCK_MAX) and
  !RESTRICTED_SINGLE_CODES[code]

findCode = (min, max) ->
  code = min
  while (not isCodeValid(code) or usedCodes[code]) and code <= max
    code += 1

  usedCodes[code] = true
  code

module.exports = ->
  findCode(UNICODE_PRIVATE_USE_AREA_MIN, UNICODE_PRIVATE_USE_AREA_MAX)
