# fontellizr
Module to generate fontello webfont from svg set

## Install

```
$ npm i fontellizr
```
This module targets Node.js 8 or later. If you want support for older browsers use [Babel compiler](https://babeljs.io/).

## Usage

**JavaScript API**

```js
var fontellizr = require('fontellizr');

fontellizr({
  svgsSourceDir: './source/svgs',
  fontsDestDir: './assets/fonts/fontello',
  stylesDestDir: './assets/styles/vendor',
  fontelloConfig: {
    ascent: 850,
    units_per_em: 1000,
    hinting: true,
    css_use_suffix: false,
    css_prefix_text: 'icon-',
    name: 'fontello'
  }
});
```

**Cli tool**

Create .fontellizrrc file in project directory

```json
{
  "svgsSourceDir": "./svgs",
  "fontsDestDir": "./fonts",
  "stylesDestDir": "./styles",
  "fontelloConfig": {
    "ascent": 850,
    "units_per_em": 1000,
    "hinting": true,
    "css_use_suffix": false,
    "css_prefix_text": "icon-",
    "name": "test"
  }
}
```

Run fontellizr

```
$ npx fontellizr
```

## License

MIT © Ablay Keldibek
