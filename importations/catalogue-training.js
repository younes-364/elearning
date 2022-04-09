var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var cataloguaTraining = function (req, rep, id) {
  var connection = mysql.createConnection(connectionParams);

  var getAllTrainings = "SELECT * FROM TRAINING";

  connection.connect(function (err) {
    if (err) console.log("error connection to database");
    else {
      connection.query(getAllTrainings, function (err, result) {
        if (err) console.log("error select all trainings");
        else {
          var context = {
            allTrainings: result,
            id_user: id,
          };

          rep.render("catalogue-training", context);
        }
      });
    }
  });
};

module.exports = cataloguaTraining;
