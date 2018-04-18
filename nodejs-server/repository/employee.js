const pool = require('./connection');
module.exports.getEmployees = function (callback, valuesData) {
  const query = {
    text: 'SELECT * from employees ORDER BY id limit ($1) offset ($2)',
    values: valuesData
  }
  pool.query(query, callback);
}

module.exports.setEmployee = function (callback, valuesData) {
  console.log(valuesData);
  const query = {
    text: 'INSERT INTO employees(name, title, department, location) VALUES($1, $2, $3, $4)',
    values: valuesData
  }
  // callback
  pool.query(query, callback);
}

module.exports.updateEmployee = function (callback, valuesData) {
  console.log(valuesData);
  const query = {
    text: 'update employees SET name=($1), title=($2), department=($3), location=($4) WHERE id=($5)',
    values: valuesData
  }
  // callback
  pool.query(query, callback);
}

module.exports.deleteEmployee = function (callback, valuesData) {
  console.log(valuesData);
  const query = {
    text: 'DELETE FROM employees WHERE id=($1)',
    values: valuesData
  }
  // callback
  pool.query(query, callback);
}

module.exports.searchEmployee = function (callback, valuesData) {
  const query = {
    text: 'SELECT * from employees WHERE LOWER(name) LIKE LOWER($1) OR LOWER(title) LIKE LOWER($2) OR LOWER(department) LIKE LOWER($3) OR LOWER(location) LIKE LOWER($4)',
    values: valuesData
  }
  // callback
  pool.query(query, callback);
}