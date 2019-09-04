const fs = require('fs');
const BASE = __dirname;
const DEST = require('os').homedir();

const MAPPING = [
  { module: 'ack', sources: ['.ackrc'], },
  { module: 'ag', sources: ['.agignore'], },
  { module: 'ctags', sources: ['.ctags'], },
  { module: 'git', sources: ['.gitconfig'], },
  {
    module: 'vim',
    sources: [
      '.vimrc',
      '.vim/after',
      '.vim/colors',
      '.vim/spell',
    ],
  },
  {
    module: 'nvim',
    sources: [
      '.config/nvim/init.vim',
      '.config/nvim/spell',
    ],
  },
  { module: 'zsh', sources: ['.zsh', '.zshrc'], },
];

const relink = ({ from, to }) => {
  fs.unlink(to, (err) => {
    if (err) return `Failed to unlink ${to}`;

    console.log(`[INFO] Unlinked old ${to}`);
    return symlink({ from, to });
  });
}

const symlink = ({ from, to }) => {
  fs.symlink(from, to, (err) => {
    if (!fs.existsSync(from)) return console.error(`[ERROR] Failed to symlink ${from}. File does not exist.`);

    if (err) {
      return err.code === 'EEXIST' ?
        relink({ from, to }) :
        console.error(`[ERROR] Failed to symlink ${from} to ${to} Reason: ${err}`);
    }

    console.log(`[INFO] Symlinked ${from} to ${to}`)
  });
}

MAPPING.forEach(({ module, sources }) => {
  sources.forEach(source => {
    const from = `${BASE}/${module}/${source}`;
    const to = `${DEST}/${source}`;
    symlink({ from, to });
  });
});
