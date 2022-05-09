var mysql = require("mysql2");
//connection to database mysql

var connectionParams = {
  host: "k8s-master01.cgiprod.ma",
  port: 31898,
  user: "root",
  password: "rootroot",
  database: "test_from_scratch",
};

//var connection = mysql.createConnection(connectionParams);

module.exports = connectionParams;
