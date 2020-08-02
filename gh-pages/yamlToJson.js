const YAML = require('yaml')
const fs = require('fs')
const package = require('./package.json')

const yaml = YAML.parse(fs.readFileSync('../pubspec.yaml', 'utf8'))

const version = yaml.version.split('+')[0]
package.scripts['generate:gh-pages'] = `VERSION=${version} DEPLOY_ENV=GH_PAGES nuxt-ts generate`
console.log('package', package.scripts)
fs.writeFileSync('./package.json', JSON.stringify(package, null, 2))
