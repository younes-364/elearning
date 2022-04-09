var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var trainingDetails = function (req, rep, id, user_id) {
  var connection = mysql.createConnection(connectionParams);

  var getModuleTraining = "select * from moduleTraining where TRAINING_ID = ?;";
  var getListModuels = "select * from moduleList where TRAINING_ID = ?;";

  var context = {
    training: null,
    module: null,
    //userID: user_id,
    id_user: user_id,
  };

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getModuleTraining, id, function (err, result) {
        if (err) console.log("error get module training query");
        else {
          context.training = result[0];
          //.render('training-details',context);
        }
      });

      connection.query(getListModuels, id, function (err, result) {
        if (err) console.log("error get module query");
        else {
          //console.log(result);
          context.module = result;
          rep.render("training-details", context);

          //rep.render('training-details',context);
        }
      });
    }
  });
};

module.exports = trainingDetails;
