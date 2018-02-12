{ readdir, statSync } = require('fs')


module.exports = (dir, regExp) ->
  new Promise (resolve, reject) ->
    readdir dir, (err, files) ->
      return reject(err) if err

      result = for file in files
        filePath = "#{dir}/#{file}"
        isDir = statSync(filePath).isDirectory()
        isMatched = regExp.test(file)

        continue if isDir or not isMatched
        filePath

      resolve(result)
