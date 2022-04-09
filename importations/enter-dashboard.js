var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var dashboard = function (req, rep, id) {
  var context = {
    statisticsItems: null,
    usersChart: null,
    id_user: id,
  };

  var connection = mysql.createConnection(connectionParams);

  var getModuleTrainingPlotly = "select * from moduleTraining;";
  var getUsers = "select * from USERS";

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getModuleTrainingPlotly, function (err, result) {
        if (err) console.log("error get module training query");
        else {
          //console.log(result);
          context.statisticsItems = result;
          //console.log(context.statisticsItems);
        }
      });
      connection.query(getUsers, function (err, result2) {
        if (err) console.log("error getting users");
        else {
          //console.log(result);
          context.usersChart = result2;
          //console.log(context.usersChart.length);
          rep.render("dashboard", context);
        }
      });
    }
  });
};

module.exports = dashboard;
