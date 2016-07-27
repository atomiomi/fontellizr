# fontellizr
Module to generate fontello webfont from svg set

## Install

```
$ npm i fontellizr
```

## Usage

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

## License

MIT © Ablay Keldibek
