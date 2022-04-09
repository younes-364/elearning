var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var updateInfosUser = function (req, rep, id, technicalLevel) {
  var connection = mysql.createConnection(connectionParams);

  var updateInfosUser =
    "UPDATE USERS SET USER_FIRST_NAME = ?, USER_LAST_NAME = ?,USER_EMAIL = ?,USER_PASSWORD = ? , USER_COUNTRY = ? , USER_BASE_LEVEL = ? , USER_MEDIUM_LEVEL = ? , USER_EXPERT_LEVEL = ? WHERE USER_ID = ?;";

  //teste technical level user

  if (technicalLevel == "basicevel") {
    queryParams = [
      req.body.firstName,
      req.body.lastName,
      req.body.email,
      req.body.password,
      req.body.country,
      true,
      false,
      false,
      id,
    ];
  } else if (technicalLevel == "mediumLevel") {
    queryParams = [
      req.body.firstName,
      req.body.lastName,
      req.body.email,
      req.body.password,
      req.body.country,
      false,
      true,
      false,
      id,
    ];
  } else if (technicalLevel == "expertLevel") {
    queryParams = [
      req.body.firstName,
      req.body.lastName,
      req.body.email,
      req.body.password,
      req.body.country,
      false,
      false,
      true,
      id,
    ];
  }

  connection.connect(function (err) {
    if (err) console.log("error connection to database");
    else {
      connection.query(updateInfosUser, queryParams, function (err, result) {
        if (err) console.log("error update query user");
        else {
          //console.log('tttttttttttttttttt');
          //console.log(result);

          var context = {
            userUpdate: result,
          };
          //console.log('ddddddddddddd');
          //console.log(context.userUpdate);

          rep.redirect("/profile/" + id);
        }
      });
    }
  });
};

module.exports = updateInfosUser;
