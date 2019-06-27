#! /usr/bin/env node
const { resolve } = require('path');
const { readFileSync, existsSync } = require('fs');
const fontellizr = require('../lib/index');


const configFilePath = resolve(process.cwd(), '.fontellizrrc');

if (!existsSync(configFilePath)) {
  throw new Error('.fontellizrrc file is not found');
}

const configString = readFileSync(configFilePath, 'utf8');
const config = JSON.parse(configString);

fontellizr(config);
