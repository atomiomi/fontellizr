{ readdir, statSync } = require('fs')


sortFiles = (a, b) ->
  a.mtime - b.mtime

module.exports = (dir, regExp) ->
  new Promise (resolve, reject) ->
    readdir dir, (err, files) ->
      return reject(err) if err

      files = for file in files
        filePath = "#{dir}/#{file}"
        stat = statSync(filePath)

        continue if stat.isDirectory() or not regExp.test(file)
        { path: filePath, mtime: stat.mtime }

      files.sort(sortFiles)
      files = (file.path for file in files)
      resolve(files)
