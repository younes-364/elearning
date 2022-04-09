var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var plotlyModuleParTraingin = function (req, rep, id) {
  var connection = mysql.createConnection(connectionParams);

  var getModuleTrainingPlotly = "select * from moduleTraining;";

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getModuleTrainingPlotly, function (err, result) {
        if (err) console.log("error get module training query");
        else {
          //console.log(result);
          var context = {
            trainingPlotly: result,
            id_user: id,
          };

          rep.render("plotlyModuleParTraining", context);
        }
      });
    }
  });
};

module.exports = plotlyModuleParTraingin;
