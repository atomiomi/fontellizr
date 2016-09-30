{ writeFile } = require('fs')
{ parse } = require('path')
{ post, get } = require('needle')
decompress = require('decompress')

{ FONTELLO_HOST } = require('./constants')


getSessionId = (config) ->
  data =
    config:
      buffer: new Buffer(JSON.stringify(config))
      content_type: 'application/octet-stream'

  new Promise (resolve, reject) ->
    post(FONTELLO_HOST, data, { multipart: true }, (err, resp, body) ->
      return reject(err or resp) if err or resp.statusCode isnt 200
      resolve(body)
    )

downloadFont = (sessionId, { stylesDestDir, fontsDestDir }) ->
  map = (file) ->
    return if file.type isnt 'file'

    { base, dir } = parse(file.path)
    dir = dir.match(/([^\/]*)\/*$/)[1]

    switch dir
      when 'css'
        writeFile("#{stylesDestDir}/#{base}", file.data)
      when 'font'
        writeFile("#{fontsDestDir}/#{base}", file.data)

  new Promise (resolve, reject) ->
    get("#{FONTELLO_HOST}/#{sessionId}/get", (err, resp) ->
      return reject(err) if err
      decompress(resp.body, ({ map })).then(resolve).catch(reject)
    )

module.exports = (config, { stylesDestDir, fontsDestDir }) ->
  getSessionId(config).then((sessionId) ->
    downloadFont(sessionId, { stylesDestDir, fontsDestDir })
  )
