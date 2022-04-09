var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var profileInfos = function (req, rep, id) {
  var connection = mysql.createConnection(connectionParams);
  var getUserInfosSpesific = "SELECT * FROM USERS WHERE USER_ID = ?";

  connection.connect(function (err) {
    if (err) console.log("error connetion to database");
    else {
      connection.query(getUserInfosSpesific, id, function (err, result) {
        if (err) console.log("error select from users");
        else {
          var context = {
            userInfos: result[0],
            id_user: id,
          };

          rep.render("profile", context);
        }
      });
    }
  });
};

module.exports = profileInfos;
