const pool = require('./connection');
module.exports.getEmployees = function(callback) {
  pool.query("Select * from employees", callback);
}

module.exports.setEmployee = function(callback, valuesData) {
console.log(valuesData);
  const query = {
    text: 'insert INTO employees(name, title, department, location) VALUES($1, $2, $3, $4)',
    values: valuesData
  }
  // callback
  pool.query(query, callback);
}