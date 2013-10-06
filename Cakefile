fs				= require 'fs'
path			= require 'path'
{spawn, exec} 	= require 'child_process'
{print} 		= require 'sys'

tasks 			= {}
options			= {}
contracts_flag 	= true
index			= 'index.js'
src				= server: 'client/assets/coffee'
dst				= server: 'client/public/js'

startNode = ()->
	fs.exists "./#{index}", (exists)->
		if exists
			child = spawn "node",["--harmony_proxies","--harmony-collections",index]
			child.stdout.on 'data',(data)-> 
				print data.toString()
			child.stderr.on 'data',(data)-> 
				process.stderr.write data.toString()
			child.on 'exit', -> console.log 'exit'
			print "node server started"
		else
			print "No index.js found!"

compileCoffee = (file) ->
	exec "coffee -c #{'--contracts' if contracts_flag?} #{file}", (err)->
		throw err if err

compileCoffeeFolders = (src,dst)->
	args = ['-c']
	args.push '--contracts' if contracts_flag?
	args = args.concat(['-o',src,dst])
	coffee = spawn 'coffee', ['-c','--contracts','-o',dst,src]
	coffee.stderr.on 'data', (data)-> 
		process.stderr.write data.toString()
	coffee.stdout.on 'data', (data)->
		print data.toString()


task 'run','Start the node server',()->
	startNode()

task 'build:index', 'build index.coffee',()->
	#Build the index file of this roject
	compileCoffee './index.coffee'

task 'build:assets', 'build all assets',()->
	#build different assets of this project one by one
	compileCoffeeFolders src.server, dst.server

task 'build', 'build all coffee files',()->
	invoke 'build:index'
	invoke 'build:assets'

task 'run:build', 'build and run',()->
	invoke 'build'
	invoke 'run'



