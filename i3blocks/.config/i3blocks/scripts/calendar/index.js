const path = require('path')
const fs = require('fs')
const Calendaddy = require('calendaddy')
const moment = require('moment')

const output = (full_text, color = '#333333') =>
  console.log(JSON.stringify({ full_text, color }))

const time = (time) => moment(time).format('HH:mm')

// Redefined by args
const config = {
  // Get credentials here: https://console.cloud.google.com/apis/credentials?project=calendar-access-485211
  // If you lost the json file - create a new secret and download JSON
  credentialsFile: path.resolve(
    __dirname,
    'client_secret_103062495224-lchderfunqefj4l3gmdj0nbml48cjecd.apps.googleusercontent.com.json',
  ),
  dataFolder: path.resolve(`${process.env.HOME}/.config/calendaddy/profiles`),
  email: null,
}

const args = process.argv.slice(2)

args.forEach((arg) => {
  const [key, value] = arg.split('=')
  const camelCaseKey = key
    .replace(/^--/, '')
    .replace(/-([a-zA-Z])/, (val) => val.toUpperCase())
    .replace(/-/, '')
  config[camelCaseKey] = value
})

const calendaddy = new Calendaddy({
  dataFolder: config.dataFolder,
  credentialsFile: config.credentialsFile,
})

const main = async () => {
  await calendaddy.auth({ email: config.email })
  const calendars = await calendaddy.getAllCalendars()
  const primaryCalendar = calendars.find(({ primary }) => primary)

  const events = await calendaddy.getEvents()

  if (events.length) {
    output(
      events
        .map(
          (event) =>
            `${event.summary.replace('Barkivists', '').substring(0, 20).trim()} (${time(event.start)}-${time(event.end)})`,
        )
        .join(' | '),
      primaryCalendar.backgroundColor,
    )
  } else {
    output(`${primaryCalendar.summary} - no events`, '#0a0a0a')
  }
}

main()
