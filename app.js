var express = require('express'),
  http    = require('http'),
  path    = require('path'),
  app     = express();

//app config
app.configure(function() {
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/src/views');
  app.set('view engine', 'jade');
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, '/')));
});

app.configure('development', function() {
  app.use(express.errorHandler());
});

//sitemap
app.get('/sitemap.xml', function(req, res) {
  res.setHeader('Content-Type', 'application/xml');
  res.render('sitemap');
});

app.get('/', function(req, res) {
  res.render('index');
});

http.createServer(app).listen(app.get('port'), function() {
  console.log('Express server listening on port ' + app.get('port'));
});
