#initial setup
express 	= require "express"
io 			= require "socket.io"
app 		= express()
port 		= 3700

#configuration for our express app
app.set 'views', __dirname + '/tpl'
app.set 'view engine', "jade"
app.engine 'jade', require('jade').__express
app.use express.static(__dirname + '/client/public')

#render the page template by default
app.get '/', (req,res)->
	res.render 'page'

#wrap in socket.io to allow the use of sockets in the frontend
io = io.listen(app.listen port)

#connection event handler
io.sockets.on 'connection', (socket)->
	console.log 'a socket connected'
	socket.emit 'message', message: 'welcome to the chat'
	socket.on 'send', (data)->
		io.sockets.emit 'message', data

console.log "listing on port #{port}"
