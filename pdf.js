url = phantom.args[0];
filename = url.replace('html', 'pdf');

var page = require('webpage').create();
page.viewportSize = { width: 1800, height: 1000 };

page.open(url, function (status) {
  window.setTimeout(function () {
      page.render(filename);
      phantom.exit();
  }, 200);
});