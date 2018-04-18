'use strict';
const morgan = require('morgan');
const bodyParser = require('body-parser');
var fs = require('fs'),
  path = require('path'),
  http = require('http');

var notifier = require('node-notifier')
var errorhandler = require('errorhandler')
var app = require('express')();
var swaggerTools = require('swagger-tools');
var jsyaml = require('js-yaml');
var serverPort = 3001;

app.use(morgan('dev'));


// swaggerRouter configuration
var options = {
  swaggerUi: path.join(__dirname, '/swagger.json'),
  controllers: path.join(__dirname, './controllers'),
  useStubs: process.env.NODE_ENV === 'development' // Conditionally turn on stubs (mock mode)
};
if (process.env.NODE_ENV === 'development') {
  // only use in development 
  app.use(errorhandler({ log: errorNotification }))
}




// The Swagger document (require it, build it programmatically, fetch it from a URL, ...)
var spec = fs.readFileSync(path.join(__dirname, 'api/swagger.yaml'), 'utf8');
var swaggerDoc = jsyaml.safeLoad(spec);

// Initialize the Swagger middleware
swaggerTools.initializeMiddleware(swaggerDoc, function (middleware) {


  // Interpret Swagger resources and attach metadata to request - must be first in swagger-tools middleware chain
  app.use(middleware.swaggerMetadata());

  // Validate Swagger requests
  app.use(middleware.swaggerValidator());

  // Route validated requests to appropriate controller
  app.use(middleware.swaggerRouter(options));

  // Serve the Swagger documents and Swagger UI
  app.use(middleware.swaggerUi());

  // Error handler
  // error middleware for errors that occurred in middleware
  app.use(function onerror(err, req, res, next) {
    
    // console.log(res.statusCode);
    // an error occurred!
    if (res.statusCode === 400) {
      next(new Error("please make sure all data are valid!"));
    }
  });

  //Handling all errors
  app.use((error, req, res, next) => {
    res.json({
      error: {
        message: error.message
      }
    });
  });

  // Start the server
  http.createServer(app).listen(serverPort, function () {
    console.log('Your server is listening on port %d (http://localhost:%d)', serverPort, serverPort);
    console.log('Swagger-ui is available on http://localhost:%d/docs', serverPort);
  });

});
