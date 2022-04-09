var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var questionAnswer = function (req, rep, id) {
  var connection = mysql.createConnection(connectionParams);

  var getQuestionModule = "select * from questionModule where QUESTION_ID = ?;";

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getQuestionModule, id, function (err, result) {
        if (err) console.log("error select quetion module query");
        else {
          if (req.body.choice == result[0].QUESTION_CORRECT_CHOICE) {
            req.flash("message", "Good ! your Answer Is Right");
            rep.redirect("back");
          } else {
            req.flash(
              "error",
              "Your Answer Is Wrong Please Check Your Cours And Try Agian"
            );
            rep.redirect("back");
          }
        }
      });
    }
  });
};

module.exports = questionAnswer;
