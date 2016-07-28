{ createWriteStream } = require('fs')
{ parse } = require('path')
{ post, get } = require('needle')
{ Parse } = require('unzip')

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
  handleEntry = (entry) ->
    return if entry.type isnt 'File'

    { base, dir } = parse(entry.path)
    dir = dir.match(/([^\/]*)\/*$/)[1]

    switch dir
      when 'css'
        entry.pipe(createWriteStream("#{stylesDestDir}/#{base}"))
      when 'font'
        entry.pipe(createWriteStream("#{fontsDestDir}/#{base}"))
      else
        entry.autodrain()

  new Promise (resolve, reject) ->
    get("#{FONTELLO_HOST}/#{sessionId}/get")
      .pipe(Parse())
      .on('entry', handleEntry)
      .on('finish', resolve)
      .on('error', reject)

module.exports = (config, { stylesDestDir, fontsDestDir }) ->
  getSessionId(config).then((sessionId) ->
    downloadFont(sessionId, { stylesDestDir, fontsDestDir })
  )
