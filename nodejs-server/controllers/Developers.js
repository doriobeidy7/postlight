'use strict';
var utils = require('../utils/writer.js');
var Developers = require('../service/DevelopersService');


module.exports.addEmployee = function addEmployee (req, res, next) {
  var employee = req.swagger.params['employee'].value;
  Developers.addEmployee(employee)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};

module.exports.deleteEmployee = function deleteEmployee (req, res, next) {
  var id = req.swagger.params['id'].value;
  Developers.deleteEmployee(id)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};

module.exports.listingEmployees = function listingEmployees (req, res, next) {
  var page_id = req.swagger.params['page_id'].value;
  var limit = req.swagger.params['limit'].value;

  Developers.listingEmployees(page_id,limit)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};

module.exports.searchEmployees = function searchEmployees (req, res, next) {
  var name = req.swagger.params['name'].value;
  var title = req.swagger.params['title'].value;
  var department = req.swagger.params['department'].value;
  var location = req.swagger.params['location'].value;
  Developers.searchEmployees(name,title,department,location)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};

module.exports.updateEmployee = function updateEmployee (req, res, next) {
  var id = req.swagger.params['id'].value;
  var employee = req.swagger.params['employee'].value;
  Developers.updateEmployee(id,employee)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
