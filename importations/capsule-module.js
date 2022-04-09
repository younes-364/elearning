var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var capsuleModule = function (req, rep, id, id_user) {
  var connection = mysql.createConnection(connectionParams);

  var getCapsuleModule = "select * from capsuleModules where MODULE_ID = ?;";

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getCapsuleModule, id, function (err, result) {
        if (err) console.log("error get capsule query");
        else {
          var context = {
            capsuleData: result,
            id_user: id_user,
          };

          rep.render("capsuleModule", context);
        }
      });
    }
  });
};

module.exports = capsuleModule;
