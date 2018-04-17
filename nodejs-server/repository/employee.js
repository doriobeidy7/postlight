const pool = require('./connection');
module.exports.getEmployees = function(callback) {
  pool.query("Select * from employees", callback);
}

