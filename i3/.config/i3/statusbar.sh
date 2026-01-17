#!/usr/bin/env node
// vim: filetype=javascript

// i3bar JSON header
console.log(JSON.stringify({ version: 1 }));
console.log("[");
console.log(JSON.stringify({ full_text: "Hey Man!", color: "#00FF00" }));
console.log(",");

setInterval(() => {
  fetch("http://websockets.pickrelated.com/history?id=ietatarin@gmail.com").then((response) => {
    response.json().then((json) => {
      const songs = json.filter(({ event }) => event === 'song') || []
      const song = songs.pop()?.payload || {}
      const statusIcon = song.playbackStatus === 'playing' ? '' : ''
      const likeIcon = song.isLiked === 'true' ? '' : '♥'
      const songText = `${likeIcon} ${song.track} by ${song.artist} ${statusIcon}`
      console.log(JSON.stringify([{ full_text: songText, color: "#00FF00" }]))
      console.log(",");
    })
  })
}, 1000);

