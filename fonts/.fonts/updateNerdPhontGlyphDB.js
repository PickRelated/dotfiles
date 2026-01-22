const path = require('path')
const fs = require('fs')

const main = async () => {
  const resp = await fetch("https://nerdfonts.com/cheat-sheet");
  const html = await resp.text();
  const [_, glyphMatch] = html.match(/const glyphs = ({[\n\r\t "a-z0-9,-_:]+})/m);
  const glyphs = JSON.parse(`${glyphMatch.replace(/,\n}/, '}')}`)
  const db = Object.entries(glyphs).map(([ key, value ]) => `${key} ${value} ${String.fromCodePoint('0x' + value)}`).join('\n')
  fs.writeFileSync(path.resolve(__dirname, 'NerdFontGlyphDB.txt'), db)
};

main();
