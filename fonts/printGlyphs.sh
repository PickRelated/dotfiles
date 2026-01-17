#!/usr/bin/env node

[
  { start: 0x23fb, end: 0x23fe },
  { start: 0x23fb, end: 0xf1af0 },
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
