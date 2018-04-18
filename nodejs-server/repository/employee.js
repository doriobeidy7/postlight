const pool = require('./connection');
module.exports.getEmployees = function(callback) {
  pool.query("SELECT * from employees ORDER BY id ASC", callback);
}

module.exports.setEmployee = function(callback, valuesData) {
console.log(valuesData);
  const query = {
    text: 'INSERT INTO employees(name, title, department, location) VALUES($1, $2, $3, $4)',
    values: valuesData
  }
  // callback
  pool.query(query, callback);
}

module.exports.updateEmployee = function(callback, valuesData) {
  console.log(valuesData);
    const query = {
      text: 'UPDATE employees SET name=($1), title=($2), deparment=($3), location=($4)',
      values: valuesData
    }
    // callback
    pool.query(query, callback);
  }