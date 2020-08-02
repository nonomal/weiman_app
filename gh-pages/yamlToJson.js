const YAML = require('yaml')
const fs = require('fs')

const yaml = YAML.parse(fs.readFileSync('../pubspec.yaml', 'utf8'))

const version = yaml.version.split('+')[0]

const template = fs.readFileSync('./pages/index.vue', 'utf8')
fs.writeFileSync('./pages/index.vue', template.replace('[version]', version))
