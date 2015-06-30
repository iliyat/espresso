config =
  server:
    host: 'example.dev'
    ip: '127.0.0.1'
    port: process.env.PORT or 5000
  client:
    facebookAppId: 'XXXXXXXXXXXXXX'
    gaId: 'XXXXXXXXXXXXXX'

module.exports = config