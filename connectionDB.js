var mysql = require("mysql2");
//connection to database mysql

var connectionParams = {
  host: "192.168.2.249",
  port: 3306,
  user: "root",
  password: "LZNfes1999/",
  database: "test_from_scratch",
};

//var connection = mysql.createConnection(connectionParams);

module.exports = connectionParams;
