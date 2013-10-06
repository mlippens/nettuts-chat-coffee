jQuery ->
  #dom elements & vars
  messages = []
  socket = io.connect '127.0.0.1:3700'
  field = $ '#field'
  sendButton = $ '#send'
  content = $ '#content'
  name = $ '#name'

  #receives message from the server
  socket.on 'message', (data)->
    if data.message
      messages.push data
      html = ''
      for i in [0..messages.length - 1]
        html += '<b>'+ (if messages[i].username then messages[i].username else 'Server') + ': </b>'
        html += messages[i].message + '<br />'
      content.html(html)
    else
      console.log 'There is a problem', data

  #onclick listener for the send button
  sendButton.on 'click', () -> 
    if name.val() && name.val() == ""
      alert "Please type your name"
    else
      text = field.val()
      #emits message to the server
      socket.emit 'send', message: text, username: name.val()


