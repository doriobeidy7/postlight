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
 
    const values = [employee.name, employee.title, employee.department, employee.location];
    db.setEmployee(function(err, data) {
      var dataEmp = {};
      if ( err ) (
        dataEmp['error'] = err
      );
      else{
        dataEmp['message'] = "Employee created.";
      }
      if (Object.keys(dataEmp).length > 0) {
        // console.log(Object.keys(data)[0]);
        resolve(dataEmp);
      } else {
        resolve();
      }
    }, values);
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
    const values = [id];
    db.deleteEmployee(function(err, data) {
      var dataEmp = {};
      if ( err ) (
        dataEmp['error'] = err
      );
      else{
        dataEmp['message'] = "Employee deleted."
      }

      if (Object.keys(dataEmp).length > 0) {
        
        // console.log(Object.keys(data)[0]);
        resolve(dataEmp);
      } else {
        resolve();
      }
    }, values);
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

    dataEmp['employee'] = data.rows;

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
    const values = [name];

    db.searchEmployee(function(err, data) {
      var dataEmp = {};
      if ( err ) (
        dataEmp['error'] = err
      );
      else{
        dataEmp['employee'] = data.rows;
      }
      if (Object.keys(dataEmp).length > 0) {
        // console.log(Object.keys(data)[0]);
        resolve(dataEmp);
      } else {
        resolve();
      }
    }, values);
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
    const values = [employee.name, employee.title, employee.department, employee.location, id];
    db.updateEmployee(function(err, data) {
      var dataEmp = {};
      if ( err ) (
        dataEmp['error'] = err
      );
      else{
        dataEmp['message'] = "Employee updated.";
      }
      if (Object.keys(dataEmp).length > 0) {
        // console.log(Object.keys(data)[0]);
        resolve(dataEmp);
      } else {
        resolve();
      }
    }, values);
  });
}

