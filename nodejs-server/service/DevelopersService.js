'use strict';
var db = require('../repository/employee');

/**
 * adds an employee
 * Adds an employee to the system
 *
 * employee Employee employee info to add (optional)
 * no response value expected for this operation
 **/
exports.addEmployee = function(employee) {
  return new Promise(function(resolve, reject) {
    resolve();
  });
}


/**
 * delete an employee
 * Delete an employee in the system
 *
 * id String pass employee id to delete a record
 * no response value expected for this operation
 **/
exports.deleteEmployee = function(id) {
  return new Promise(function(resolve, reject) {
    resolve();
  });
}

/**
 * listing employees
 * By passing in the appropriate options, you can get a list of available employee in the system
 *
 * page_id String pass an optional page id for looking up records (optional)
 * limit Integer maximum number of records to return (optional)
 * returns List
 **/


exports.listingEmployees = function(page_id,limit) {
  return new Promise(function(resolve, reject) {
  
  
  db.getEmployees(function( err, data ) {
    var dataEmp = {};
    if ( err ) return console.error( err );

    dataEmp['employee'] = JSON.parse(JSON.stringify(data.rows));

    if (Object.keys(dataEmp).length > 0) {
      // console.log(Object.keys(data)[0]);
      resolve(dataEmp);
    } else {
      resolve();
    }
  });
});
}


/**
 * search employees
 * By passing in the appropriate options, you can search for available employee in the system
 *
 * name String pass a name for looking up in records (optional)
 * title String pass a title for looking up in records (optional)
 * department String pass a department for looking up in records (optional)
 * location String pass a location for looking up in records (optional)
 * returns List
 **/
exports.searchEmployees = function(name,title,department,location) {
  return new Promise(function(resolve, reject) {
   
    var examples = {};
    examples['application/json'] = [ {
  "emp_image" : "https://wd.imagelocation.com",
  "name" : "Joe",
  "location" : "beirut",
  "id" : "d290f1ee-6c54-4b01-90e6-d701748f0851",
  "title" : "Senior developer",
  "department" : "Mobiles"
}, {
  "emp_image" : "https://wd.imagelocation.com",
  "name" : "Joe",
  "location" : "beirut",
  "id" : "d290f1ee-6c54-4b01-90e6-d701748f0851",
  "title" : "Senior developer",
  "department" : "Mobiles"
} ];
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}


/**
 * update an employee
 * Update an employee in the system
 *
 * id String pass employee id to update a record
 * employee Employee employee info to udpate (optional)
 * no response value expected for this operation
 **/
exports.updateEmployee = function(id,employee) {
  return new Promise(function(resolve, reject) {
    resolve();
  });
}

