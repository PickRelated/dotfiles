#!/usr/bin/env node

[
  { start: 0xe0a0, end: 0xe0b3 },
  { start: 0xf005, end: 0xf2c6 },
  { start: 0xf442, end: 0xf4af },
].forEach(({ start, end }) => {
  console.log()
  process.stdout.write(' ')
  for (let code = start; code <= end; code++) {
    const char = String.fromCharCode(code);
    process.stdout.write(`${char}  `)
    if (!(code % 10)) {
      process.stdout.write("\n ")
    }
  }
  console.log()
  console.log('='.repeat(30))
})
