express = require "express"
io = require "socket.io"
app = express()
port = 3700

app.set 'views', __dirname + '/tpl'
app.set 'view engine', "jade"
app.engine 'jade', require('jade').__express
app.use express.static(__dirname + '/client/public')
app.use require('connect-coffee-script')
    src    : "#{__dirname}/client/assets/coffee"
    dest   : "#{__dirname}/client/public/js"
    prefix : '/js'
    force	: true
app.get '/', (req,res)->
	res.render 'page'


io = io.listen(app.listen port)

console.log io.sockets

io.sockets.on 'connection', (socket)->
	console.log 'a socket connected'
	socket.emit 'message', message: 'welcome to the chat'
	socket.on 'send', (data)->
		io.sockets.emit 'message', data

console.log "listing on port #{port}"
