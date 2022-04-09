var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var quizQuestion = function (req, rep, id) {
  var connection = mysql.createConnection(connectionParams);

  var getQuestionModule =
    "select * from questionModule where module_id = ? order by Rand() limit 1 ;";

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getQuestionModule, id, function (err, result) {
        if (err) console.log("error select quetion module query");
        else {
          var context = {
            questionsModule: result,
            message: req.flash("message"),
            errors: req.flash().error,
            id_user: req.params.id_user,
          };

          rep.render("quize-test", context);
        }
      });
    }
  });
};
module.exports = quizQuestion;
