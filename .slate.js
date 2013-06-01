var isAppLaunched = function(name) {
  return (function(){
    try {
      S.eachApp(function(app){ if(app.name() === name){throw {};}});
    } catch(e) {
      return true;
    }
    return false;
  })();
};

var launchApp = function(win, name) {
  return win.doOperation(
    S.operation('shell', {
      "command": "/usr/bin/open -a " + name,
      "wait": "waitForExit"
    })
  );
};

var _to = function(name) {
  return function (win) {
    if (!win) { win = S.windowUnderPoint({'x':100,'y':100}); }
    if (!isAppLaunched(name)) {
      launchApp(win, name)
    }
    win.doOperation(S.operation('focus', { "app": name }));
  };
};

S.bind('1:cmd', _to('Safari'));
S.bind('2:cmd', _to('Emacs'));
S.bind('3:cmd', _to('Dash'));
S.bind('4:cmd', _to('Chromium'));
