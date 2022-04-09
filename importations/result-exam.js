var mysql = require("mysql2");
const path = require("../server");

var connectionParams = require(path + "/connectionDB.js");

var getResultExam = function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var getAnswers =
    "select * from answer where champ_user = ? and CHAMP_TRAINING = ?";

  queryParams = [req.params.id, req.params.id_tra];

  connection.connect(function (err) {
    if (err) console.log("err connection to db");
    else {
      connection.query(getAnswers, queryParams, function (err, result) {
        if (err) console.log("error get answers query");
        else {
          //console.log(result);
          context = {
            id_user: queryParams,
            answers: result,
            cmp: 0,
            cpt: 0,
          };

          rep.render("answer-page", context);
        }
      });
    }
  });
};

module.exports = getResultExam;

/* var getAnswers = "select * from answer where champ_user = ? and CHAMP_TRAINING = ?";

 queryParams = [req.params.id, req.params.id_tra];

 connection.connect(function (err) {
     if (err) console.log('err connection to db');
     else {

         connection.query(getAnswers, queryParams, function (err, result) {
             if (err) console.log('error get answers query');
             else {
                 for (let i = 0; i < 30; i++) {
                     //console.log(result);
                     var selectQuestions = "select * from question where question_id = ?";
                     queryParams2 = [result[i].ANSWER_QUESTION];
                     connection.query(selectQuestions, queryParams2, function (err, result2) {
                         if (err) console.log('error select question query');
                         else {
                             console.log(result2[0].QUESTION_CORRECT_CHOICE);
                             console.log(result[0].CANDIDAT_CHOICE);
                             if (result2.QUESTION_CORRECT_CHOICE == result.CANDIDAT_CHOICE) {
                                 var updateAnswers = "update answer set CHOICE_FILTER = 1 where ANSWER_QUESTION = ?";
                                 queryParams3 = [result2.QUESTION_ID];
                                 //console.log(queryParams3);
                                 connection.query(updateAnswers, queryParams3, function (err, result3) {
                                     if (err) console.log('error select query');
                                     else {
                                         //console.log(result3);
                                         context = {
                                             id_user: queryParams,
                                             answers: result,
                                         };

                                         rep.render('answer-page', context);
                                     }
                                 });
                             }
                         }
                     });
                 }
             }
         });


     }
 }); */
