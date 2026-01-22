const output = ({ full_text, color = '#333333' }) => {
  console.log(JSON.stringify({ full_text, color }))
}

fetch('http://websockets.pickrelated.com/history?id=ietatarin@gmail.com').then(
  (response) => {
    response.json().then((json) => {
      const songs = json.filter(({ event }) => event === 'song') || []
      const song = songs.pop()?.payload || {}
      if (!song.playbackStatus) {
        output({ full_text: '  ', color: '#0a0a0a' })
        return
      }
      const likeIcon = song.isLiked === 'true' ? ' ' : ''
      const songText = `󰝚 ${song.artist} - ${song.track}${likeIcon}`
      output({ full_text: songText })
    })
  },
)
