var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var getFinalExam = function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var queryGetTenQuastionPerLevel =
    "(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'LOW' AND MODULE_TRAINING = ? order by RAND()  LIMIT 10)UNION(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'MEDIUM' AND MODULE_TRAINING = ? order by RAND()  LIMIT 10)UNION(SELECT * FROM QUESTION INNER JOIN MODULE ON MODULE_ID = QUESTION_MODULE WHERE QUESTION_HARDNESS_LEVEL = 'HEIGH' AND MODULE_TRAINING = ? order by RAND()  LIMIT 10);";

  queryParams = [req.params.id, req.params.id, req.params.id];

  connection.connect(function (err) {
    if (err) console.log("connection error to database");
    else {
      connection.query(
        queryGetTenQuastionPerLevel,
        queryParams,
        function (err, result) {
          if (err) console.log("error query get questions exam final ");
          else {
            //console.log(result);
            //make an horloge
            var context = {
              dataExam: result,
              id_user: req.params.user_id,
              tra_id: req.params.id,
            };
            rep.render("finalExam", context);
          }
        }
      );
    }
  });
};

module.exports = getFinalExam;
