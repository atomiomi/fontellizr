{ createWriteStream } = require('fs')
{ parse } = require('path')
mkdirp = require('mkdirp')
needle = require('needle')
{ Parse } = require('unzip')

FONTELLO_HOST = 'http://fontello.com'
ZIP_NAME = 'fontellizr_archive.zip'


getSessionId = (config) ->
  data =
    config:
      buffer: new Buffer(JSON.stringify(config))
      content_type: 'application/octet-stream'

  new Promise (resolve, reject) ->
    needle.post(FONTELLO_HOST, data, { multipart: true }, (err, resp, body) ->
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
    needle
      .get("#{FONTELLO_HOST}/#{sessionId}/get")
      .pipe(Parse())
      .on('entry', handleEntry)
      .on('finish', resolve)
      .on('error', reject)

module.exports = (config, { stylesDestDir, fontsDestDir }) ->
  mkdirp.sync(stylesDestDir)
  mkdirp.sync(fontsDestDir)

  getSessionId(config).then((sessionId) ->
    downloadFont(sessionId, { stylesDestDir, fontsDestDir })
  )
