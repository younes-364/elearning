var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var insertAnswers = function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var stringify = JSON.stringify(req.body);
  var parsed = JSON.parse(stringify);
  var keys = Object.keys(parsed);
  var tab = [];

  connection.connect(function (err) {
    if (err) console.log("err connection to db");
    else {
      for (let i = 1; i <= keys.length - 1; i++) {
        var tab = keys[i].split("_");
        //verify if tab[1] ! equal a number
        if (isNaN(tab[1])) {
          continue;
        } else {
          var getCorrectChoice = "select * from question where question_id = ?";
          queryParams[i] = [tab[1]];
          //console.log(queryParams[i]);
          connection.query(
            getCorrectChoice,
            queryParams[i],
            function (err, result2) {
              //console.log(queryParams[i]);
              if (err) console.log("error get query");
              else {
                //console.log(result2);
                //console.log(queryParams[i]);
                if (result2[0].QUESTION_CORRECT_CHOICE == parsed[keys[i]]) {
                  var insertIntoAnswer =
                    "insert into ANSWER (ANSWER_QUESTION,QUESTION_TEXT,CANDIDAT_CHOICE,CHAMP_USER,CHAMP_TRAINING,CHOICE_FILTER) values (" +
                    result2[0].QUESTION_ID +
                    ",'" +
                    result2[0].QUESTION_TEXT +
                    "','" +
                    parsed[keys[i]] +
                    "'," +
                    req.body.user_id +
                    "," +
                    req.body.tra_id +
                    "," +
                    1 +
                    ") ;";
                  connection.query(insertIntoAnswer, function (err, result) {
                    if (err) console.log("error insertion query");
                    else {
                      //console.log(result);
                    }
                  });
                } else {
                  var insertIntoAnswer =
                    "insert into ANSWER (ANSWER_QUESTION,QUESTION_TEXT,CANDIDAT_CHOICE,CHAMP_USER,CHAMP_TRAINING,CHOICE_FILTER) values (" +
                    result2[0].QUESTION_ID +
                    ",'" +
                    result2[0].QUESTION_TEXT +
                    "','" +
                    parsed[keys[i]] +
                    "'," +
                    req.body.user_id +
                    "," +
                    req.body.tra_id +
                    "," +
                    0 +
                    ") ;";
                  connection.query(insertIntoAnswer, function (err, result) {
                    if (err) console.log("error insertion query");
                    else {
                      //console.log(result);
                    }
                  });
                }
              }
            }
          );
        }
      }
      rep.redirect("back");
    }
  });
};

module.exports = insertAnswers;
