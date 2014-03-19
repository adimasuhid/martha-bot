# Description:
#   Odesk Notifier script from a custom odesk api platform
#
# Configuration:
#   None
#
#
# URLS:
#   POST /hubot/odesk?room=<room>[&type=<type]
#
# Author:
#   adimasuhid

url = require('url')
querystring = require('querystring')

module.exports = (robot) ->

  robot.router.post "/hubot/odesk", (req, res) ->
    query = querystring.parse url.parse(req.url).query
    res.end JSON.stringify {
       received: true #some client have problems with and empty response
    }

    user = {}
    user.room = query.room if query.room
    user.type = query.type if query.type
    console.log user.room

    try
      payload = req.body.payload
      robot.send user, "Odesk #{payload.job_type} Job from a #{payload.client.payment_verification_status} client: #{payload.title}. Initial details are: #{payload.snippet.substring(0,20)}... Check more at #{payload.url}"
    catch error
      console.log "odesk hook error: #{error}. Payload: #{req.body.payload}"

