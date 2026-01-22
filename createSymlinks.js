// vim: ft=javascript

const fs = require('node:fs')
const BASE = __dirname
const DEST = require('node:os').homedir()

const MAPPING = [
  { module: 'ack', sources: ['.ackrc'] },
  { module: 'ag', sources: ['.agignore'] },
  { module: 'ctags', sources: ['.ctags.d'] },
  {
    module: 'fonts',
    sources: ['.fonts/Monaco.ttf', '.fonts/MononokiNerdFontPropo-Regular.ttf', '.fonts/updateNerdPhontGlyphDB.js', '.fonts/NerdFontGlyphDB.txt'],
  },
  { module: 'ghostty', sources: ['.config/ghostty/config'] },
  { module: 'git', sources: ['.gitconfig'] },
  { module: 'htop', sources: ['.config/htop/htoprc'] },
  { module: 'i3', sources: ['.config/i3'] },
  { module: 'i3blocks', sources: ['.config/i3blocks'] },
  {
    module: 'vim',
    sources: ['.vimrc', '.vim/after', '.vim/colors', '.vim/spell'],
  },
  {
    module: 'nvim',
    sources: ['.config/nvim/init.vim', '.config/nvim/spell'],
  },
  { module: 'xmodmap', sources: ['.Xmodmap'] },
  { module: 'zsh', sources: ['.zsh', '.zshrc'] },
]

const relink = ({ from, to }) => {
  fs.unlink(to, (err) => {
    if (err) {
      return `Failed to unlink ${to}`
    }

    console.log(`[INFO] Unlinked old ${to}`)
    return symlink({ from, to })
  })
}

const symlink = ({ from, to }) => {
  const toDir = to.replace(/\/[a-zA-Z0-9-_.]+$/, '')
  fs.mkdirSync(toDir, { recursive: true })

  fs.symlink(from, to, (err) => {
    if (!fs.existsSync(from)) {
      return console.error(
        `[ERROR] Failed to symlink ${from}. File does not exist.`,
      )
    }

    if (err) {
      return err.code === 'EEXIST'
        ? relink({ from, to })
        : console.error(
            `[ERROR] Failed to symlink ${from} to ${to} Reason: ${err}`,
          )
    }

    console.log(`[INFO] Symlinked ${from} to ${to}`)
  })
}

MAPPING.forEach(({ module, sources }) => {
  sources.forEach((source) => {
    const from = `${BASE}/${module}/${source}`
    const to = `${DEST}/${source}`
    symlink({ from, to })
  })
})
