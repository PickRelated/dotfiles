const path = require('path')
const fs = require('fs')
const Calendaddy = require('calendaddy')
const moment = require('moment')

const output = (full_text, color = '#333333') =>
  console.log(JSON.stringify({ full_text, color }))

const time = (time) => moment(time).format('HH:mm')

// Redefined by args
const config = {
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

// Load credentials
let credentials

try {
  const credentialsData = fs.readFileSync(config.credentialsFile, 'utf8')
  credentials = JSON.parse(credentialsData)
} catch (error) {
  console.error(`Error reading credentials file: ${error.message}`)
  process.exit(1)
}

const calendaddy = new Calendaddy({
  dataFolder: config.dataFolder,
  credentials: credentials.web,
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
            `${event.summary.substring(0, 20).trim()} (${time(event.start)}-${time(event.end)})`,
        )
        .join(' | '),
      primaryCalendar.backgroundColor,
    )
  } else {
    output(`${primaryCalendar.summary} - no events`, '#0a0a0a')
  }
}

main()
