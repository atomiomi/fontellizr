{ createReadStream } = require('fs')
{ parse } = require('path')
{ Extract } = require('unzip')


module.exports = (zipPath) ->
  { dir, name } = parse(zipPath)

  new Promise (resolve, reject) ->
    createReadStream(zipPath)
      .pipe(Extract(path: dir))
      .on('error', reject)
      .on('close', -> resolve("#{dir}/#{name}"))
