var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var testLog = function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var selectAllUsers =
    "SELECT * FROM USERS where user_email REGEXP ? and user_password = ?";
  var userAdmin = "select * from adminUser where user_id = ?";

  //verify user_id from undefined
  queryParams = [req.body.email, req.body.password];
  //console.log(queryParams);
  if (req.body.email.length == 0 || req.body.password.length == 0) {
    req.flash("error2", "Check enter Informations and try again");
    rep.render("login", { error2: req.flash().error2, errors: null });
  } else {
    connection.connect(function (err) {
      if (err) console.log(err);
      else {
        connection.query(selectAllUsers, queryParams, function (err, result) {
          //console.log(selectAllUsers);
          if (err) console.log("eror query select users");
          else {
            //console.log(result);
            if (result.length == 0) {
              req.flash("error", "User Not Found");
              rep.render("login", { errors: req.flash().error, error2: null });
            } else {
              queryParams2 = [result[0].USER_ID];

              connection.query(userAdmin,queryParams2,function (err, result2) {
                  //console.log(result2);
                  if (err) console.log("error user admin query");
                  else {
                    if (result2.length == 0) {
                      if (
                        result[0].USER_EMAIL == req.body.email &&
                        result[0].USER_PASSWORD == req.body.password
                      ) {
                        rep.redirect("/dashboard/" + result[0].USER_ID);
                      } else {
                        req.flash("error", "Wrong Email Or Password");
                        rep.render("login", {
                          errors: req.flash().error,
                          error2: null,
                        });
                      }
                    } else {
                      rep.redirect("/page-admin");
                    }
                  }
                }
              );
            }
          }
        });
      }
    });
  }
};

module.exports = testLog;
