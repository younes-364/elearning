var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var User = require(path + "/classes/user-class.js");

var testExistingUser = "select * from USERS";

//in this function we test informations user before adding it to db

var addUser = function (req, rep) {
  var k = 0;
  var connection = mysql.createConnection(connectionParams);

  if (
    req.body.firstName.length == 0 ||
    req.body.lastName.length == 0 ||
    req.body.password.length == 0
  ) {
    req.flash("error2", "Check enter Informations and try again");
    rep.render("register", {
      error2: req.flash().error2,
      message: null,
      errors: null,
    });
  } else {
    connection.connect(function (err) {
      if (err) console.log("error connecting to db");
      else {
        connection.query(testExistingUser, function (err, result) {
          if (err) console.log("error getting users query");
          else {
            //this loop for , to list users and compare test new email exist or (!exist)
            for (var i = 0; i < result.length; i++) {
              if (req.body.email == result[i].USER_EMAIL) {
                k = 1;
                break;
              } else {
                k = 0;
              }
            }
            //so this condition if test if email exist show user a message error if not user add success
            if (k == 1) {
              req.flash("error", "this email is aready exist");
              //when there is an erreo the message info must be null
              rep.render("register", {
                errors: req.flash().error,
                message: null,
                error2: null,
              });
            } else {
              if (req.body.technicalLevel == "basicLevel") {
                user1 = new User(
                  null,
                  req.body.firstName,
                  req.body.lastName,
                  req.body.email,
                  req.body.password,
                  req.body.country,
                  true,
                  false,
                  false
                );
                req.flash("message", "user added successefally !");
                //when there is no error the error must be null
                rep.render("register", {
                  message: req.flash("message"),
                  errors: null,
                  error2: null,
                });
              } else if (req.body.technicalLevel == "mediumLevel") {
                user1 = new User(
                  null,
                  req.body.firstName,
                  req.body.lastName,
                  req.body.email,
                  req.body.password,
                  req.body.country,
                  false,
                  true,
                  false
                );
                req.flash("message", "user added successefally !");
                rep.render("register", {
                  message: req.flash("message"),
                  errors: null,
                  error2: null,
                });
              } else if (req.body.technicalLevel == "expertLevel") {
                user1 = new User(
                  null,
                  req.body.firstName,
                  req.body.lastName,
                  req.body.email,
                  req.body.password,
                  req.body.country,
                  false,
                  false,
                  true
                );
                req.flash("message", "user added successefally !");
                rep.render("register", {
                  message: req.flash("message"),
                  errors: null,
                  error2: null,
                });
              }

              user1.addNewUser();
            }
          }
        });
      }
    });
  }
};

module.exports = addUser;
