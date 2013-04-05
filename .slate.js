var launch_and_focus = function (target) {
  return function (win) {
    if (!win) { return; }
    if (!(function(){
      try {
        S.eachApp(function(app){ if(app.name() === target){throw {};}});
      } catch(e) {
        return true;
      }
      return false;
    })()) {
      win.doOperation(
        S.operation('shell', {
          "command": "/usr/bin/open -a " + target,
          "wait": "waitForExit"
        })
      );
    }
    win.doOperation(S.operation('focus', { "app": target }));
  };
};

S.bind('0:ctrl;cmd', launch_and_focus('Emacs'));
S.bind('9:ctrl;cmd', launch_and_focus('FirefoxNightly'));
S.bind('8:ctrl;cmd', launch_and_focus('Chromium'));
