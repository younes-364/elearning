var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var myTrainings = function (req, rep, id) {
  var connection = mysql.createConnection(connectionParams);

  var selectTrainingSpecific =
    "select * from userSubscriptionTraining where user_id = ?;";

  connection.connect(function (err) {
    if (err) console.log("error connection to database ");
    else {
      connection.query(selectTrainingSpecific, id, function (err, result) {
        if (err) console.log("error selection query");
        else {
          var context = {
            subscription: result,
            id_user: id,
          };

          rep.render("my-trainings", context);
        }
      });
    }
  });
};

module.exports = myTrainings;
