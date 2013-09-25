(function() {
  jQuery(function() {
    var content, field, messages, name, sendButton, socket;
    messages = [];
    socket = io.connect('127.0.0.1:3700');
    field = $('#field');
    sendButton = $('#send');
    content = $('#content');
    name = $('#name');
    socket.on('message', function(data) {
      var html, i, _i, _ref;
      if (data.message) {
        messages.push(data);
        html = '';
        for (i = _i = 0, _ref = messages.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          html += '<b>' + (messages[i].username ? messages[i].username : 'Server') + ': </b>';
          html += messages[i].message + '<br />';
        }
        return content.html(html);
      } else {
        return console.log('There is a problem', data);
      }
    });
    return sendButton.on('click', function() {
      var text;
      if (name.val() && name.val() === "") {
        return alert("Please type your name");
      } else {
        text = field.val();
        return socket.emit('send', {
          message: text,
          username: name.val()
        });
      }
    });
  });

}).call(this);
