//export path
const path = __dirname;
module.exports = path;

//import classes
var Training = require(__dirname + "/classes/training-class.js");

var Modules = require(__dirname + "/classes/module-class.js");

var Capsule = require(__dirname + "/classes/capsule-class.js");

//import services
var express = require("express");

var mysql = require("mysql2");

var bodyParser = require("body-parser");

var elearningApp = express();

var server = require("http").createServer(elearningApp);

//test layoute
var session = require("express-session");

var flush = require("connect-flash"); // to show alert message

var io = require("socket.io")(server);

//socket config
io.on("connection", function (socket) {
  //console.log('a user connected');
  socket.on("chat message", function (msg) {
    // console.log('message: ' + msg);
    io.emit("chat message", msg);
  });
});

//import connection parameters to db
var connectionParams = require("./connectionDB.js");

//import functions from folder importations to the server
var testLogin = require(__dirname + "/importations/test-log.js");

var enterDashboard = require(__dirname + "/importations/enter-dashboard.js");

var profileInfos = require(__dirname + "/importations/profile-infos.js");

var catalogueTraining = require(__dirname +
  "/importations/catalogue-training.js");

var detailsTrainingModule = require(__dirname +
  "/importations/training-details.js");

var updateUser = require(__dirname + "/importations/update-user.js");

var capsuleModule = require(__dirname + "/importations/capsule-module.js");

var addQuetion = require(__dirname + "/importations/add-question.js");

var quizQuestionsList = require(__dirname +
  "/importations/quiz-list-question.js");

var manageQuestionAnswer = require(__dirname +
  "/importations/manage-question-answer.js");

var addUser = require(__dirname + "/importations/add-user.js");

var myTrainings = require(__dirname + "/importations/myTrainings.js");

var getFinalExam = require(__dirname + "/importations/getFinalExam.js");

var resultExam = require(__dirname + "/importations/result-exam.js");

var insertAnswers = require(__dirname + "/importations/insert-answers.js");

var addSubscription = require(__dirname + "/importations/add-subscription.js");

//use public pour les images
elearningApp.use(express.static("public"));

//declare engine view
elearningApp.set("view engine", "ejs");

//serevr express
server.listen(80, "0.0.0.0", function () {
  console.log(server.address().address);
  console.log(server.address().port);
});

//body parser configurations
elearningApp.use(bodyParser.urlencoded({ extended: false }));
elearningApp.use(bodyParser.json());

//show flash message
elearningApp.use(
  session({
    secret: "secret",
    cookie: { maxAge: 60000 },
    resave: false,
    saveUninitialized: false,
  })
);

elearningApp.use(flush());

//routes
//page LOGIN
elearningApp.get("/", function (req, rep) {
  rep.render("login", {
    errors: req.flash().error,
    error2: req.flash().error2,
  });
});

// TESTE LOOGIN
elearningApp.post("/test-login", function (req, rep) {
  testLogin(req, rep);
});

//REGISTER PAGE
elearningApp.get("/register", function (req, rep) {
  rep.render("register", { message: null, errors: null, error2: null });
});

//ADD NEW USER
elearningApp.post("/add-user", function (req, rep) {
  addUser(req, rep);
});

//page training
elearningApp.get("/training", function (req, rep) {
  rep.render("training");
});

//add training
elearningApp.post("/add-training", function (req, rep) {
  training1 = new Training(
    null,
    req.body.trainingTitle,
    req.body.trainingDescription
  );
  training1.addNewTraining();
  rep.redirect("/training");
});

//page module
elearningApp.get("/module", function (req, rep) {
  rep.render("module");
});

//add-module
elearningApp.post("/add-module", function (req, rep) {
  var module1 = new Modules(
    null,
    req.body.moduleTraining,
    req.body.moduleTiltle,
    req.body.moduleDescription,
    req.body.modulePrice
  );
  module1.addNewModule();
  rep.render("module");
});

//add subscription
elearningApp.post("/add-sub/:id/:tra_id", function (req, rep) {
  addSubscription(req, rep);
});

//remove training
elearningApp.post("/remove-training", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);
  var deleteTraining = "delete from training where training_id = ?";

  var queryParams = [req.body.trainingId];
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(deleteTraining, queryParams, function (err, result) {
        if (err) console.log("error delete training query");
        else {
          // console.log(result);
          rep.render("page-admin");
        }
      });
    }
  });
});

//remove module
elearningApp.post("/remove-module", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);
  var deleteModule = "delete from module where module_id = ?";

  var queryParams = [req.body.moduleId];

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(deleteModule, queryParams, function (err, result) {
        if (err) console.log("error delete module query");
        else {
          //console.log(result);

          rep.render("page-admin");
        }
      });
    }
  });
});

//remove capsule
elearningApp.post("/remove-capsule", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);
  var deleteModule = "delete from capsule where capsule_id = ?";

  var queryParams = [req.body.capsuleId];
  console.log(queryParams);
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(deleteModule, queryParams, function (err, result) {
        if (err) console.log("error delete capsule query");
        else {
          //console.log(result);
          rep.render("page-admin");
        }
      });
    }
  });
});

//remove capsule
elearningApp.post("/remove-question", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);
  var deleteModule = "delete from question where question_id = ?";

  var queryParams = [req.body.questionId];
  console.log(queryParams);
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(deleteModule, queryParams, function (err, result) {
        if (err) console.log("error delete question query");
        else {
          //console.log(result);
          rep.render("page-admin");
        }
      });
    }
  });
});

// get update training
elearningApp.post("/get-update-training", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var getTraining = "select * from training where training_id = ?";

  queryParams = [req.body.trainingId];

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getTraining, queryParams, function (err, result) {
        if (err) console.log("error get training query");
        else {
          // console.log(result);
          var context = {
            dataTraining: result,
          };
          rep.render("update-training", context);
        }
      });
    }
  });
});

//update training
elearningApp.post("/update-training", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var updateTraining =
    "update TRAINING set TRAINING_TITLE = ? , TRAINING_DESCRIPTION = ? where TRAINING_ID = ?";

  queryParams = [
    req.body.trainingTitle,
    req.body.trainingDescription,
    req.body.trainingId,
  ];
  //console.log(queryParams);
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(updateTraining, queryParams, function (err, result) {
        if (err) console.log("error update training query");
        else {
          //console.log(result);
        }
      });
    }
  });
});

// get update module
elearningApp.post("/get-update-module", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var getModule = "select * from module where module_id = ?";

  queryParams = [req.body.moduleId];

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getModule, queryParams, function (err, result) {
        if (err) console.log("error get module query");
        else {
          // console.log(result);
          var context = {
            dataModule: result,
          };
          rep.render("update-module", context);
        }
      });
    }
  });
});

//update module
elearningApp.post("/update-module", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var updateModule =
    "update module set MODULE_TITLE = ? ,MODULE_DESCRIPTION = ? , MODULE_PRICE = ? where MODULE_ID = ?";

  queryParams = [
    req.body.moduleTitle,
    req.body.moduleDescription,
    req.body.modulePrice,
    req.body.moduleId,
  ];
  //console.log(queryParams);
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(updateModule, queryParams, function (err, result) {
        if (err) console.log("error update module query");
        else {
          //console.log(result);
        }
      });
    }
  });
});

// get update Capsule
elearningApp.post("/get-update-capsule", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var getCapsule = "select * from capsule where capsule_id = ?";

  queryParams = [req.body.capsuleId];

  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getCapsule, queryParams, function (err, result) {
        if (err) console.log("error get capsule query");
        else {
          //console.log(result);
          var context = {
            dataCapsule: result,
          };
          rep.render("update-capsule", context);
        }
      });
    }
  });
});

//update module
elearningApp.post("/update-capsule", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var updateCapsule = "update CAPSULE set CAPSULE_URL = ? where CAPSULE_ID = ?";

  queryParams = [req.body.capsuleUrl, req.body.capsuleId];
  //console.log(queryParams);
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(updateCapsule, queryParams, function (err, result) {
        if (err) console.log("error update capsule query");
        else {
          //console.log(result);
        }
      });
    }
  });
});

// get update question
elearningApp.post("/get-update-question", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var getQuestion = "select * from question where question_id = ?";

  queryParams = [req.body.quastionId];
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(getQuestion, queryParams, function (err, result) {
        if (err) console.log("error get question query");
        else {
          //console.log(result);
          var context = {
            dataQuestion: result,
          };
          rep.render("update-question", context);
        }
      });
    }
  });
});

//update question
elearningApp.post("/update-question", function (req, rep) {
  var connection = mysql.createConnection(connectionParams);

  var updateQuestion =
    "update question set QUESTION_TEXT = ? ,QUESTION_FIRST_CHOICE = ? ,QUESTION_SECOND_CHOICE = ? ,QUESTION_THIRD_CHOICE = ? , QUESTION_CORRECT_CHOICE = ? , QUESTION_HARDNESS_LEVEL = ?  where CAPSULE_ID = ?;";

  if (req.body.hardnessLevel == "BASIC") {
    queryParams = [
      req.body.questionText,
      req.body.firstChoice,
      req.body.secondChoice,
      req.body.thirdChoice,
      req.body.correctChoice,
      "BASIC",
      req.body.capsuleId,
    ];
  } else if (req.body.hardnessLevel == "MEDIUM") {
    queryParams = [
      req.body.questionText,
      req.body.firstChoice,
      req.body.secondChoice,
      req.body.thirdChoice,
      req.body.correctChoice,
      "MEDIUM",
      req.body.capsuleId,
    ];
  } else if (req.body.hardnessLevel == "HEIGH") {
    queryParams = [
      req.body.questionText,
      req.body.firstChoice,
      req.body.secondChoice,
      req.body.thirdChoice,
      req.body.correctChoice,
      "HEIGH",
      req.body.capsuleId,
    ];
  }

  //console.log(queryParams);
  connection.connect(function (err) {
    if (err) console.log("error connection to db");
    else {
      connection.query(updateQuestion, queryParams, function (err, result) {
        if (err) console.log("error update question query");
        else {
          console.log(result);
        }
      });
    }
  });
});

//page admin
elearningApp.get("/page-admin", function (req, rep) {
  rep.render("page-admin");
});

////////////////////////////////////////2eme part////////////////////////////////////////////////////////

//dashboard
elearningApp.get("/dashboard/:id", function (req, rep) {
  queryParams = [req.params.id];
  enterDashboard(req, rep, queryParams);
});

//myTrainings
elearningApp.get("/myTrainings/:id", function (req, rep) {
  queryParams = [req.params.id];
  myTrainings(req, rep, queryParams);
});

//PROFILE PAGE
elearningApp.get("/profile/:id", function (req, rep) {
  queryParams = [req.params.id];
  profileInfos(req, rep, queryParams);
});

//CATALOGUE TRAINING
elearningApp.get("/catalogue-training/:id", function (req, rep) {
  queryParams = [req.params.id];
  catalogueTraining(req, rep, queryParams);
});

//TRAINING DETAILS AND MODULES
elearningApp.get("/training-details/:id/:user_id", function (req, rep) {
  queryParams = [req.params.id];
  queryParams2 = [req.params.user_id];
  detailsTrainingModule(req, rep, queryParams, queryParams2);
});

//UPDATE INFORMATIONS USER AND SHOW INFORMATIONS
elearningApp.post("/update-profile/:id", function (req, rep) {
  queryParams = [req.params.id];
  technical = [req.body.technicalLevel];
  updateUser(req, rep, queryParams, technical);
});

//add capsule
elearningApp.get("/capsule", function (req, rep) {
  rep.render("capsule");
});

elearningApp.post("/add-capsule", function (req, rep) {
  var capsule = new Capsule();
  capsule = new Capsule(
    null,
    req.body.capsuleModule,
    req.body.capsuleUrl,
    false
  );
  capsule.addNewCapsule();
});

//Capsule Module
elearningApp.get("/capsuleModule/:id/:id_user", function (req, rep) {
  queryParams = [req.params.id];
  queryParams2 = [req.params.id_user];
  capsuleModule(req, rep, queryParams, queryParams2);
});

//QUESTION PAGE
elearningApp.get("/questions", function (req, rep) {
  rep.render("questions");
});

//ADD QUESTION
elearningApp.post("/add-questions", function (req, rep) {
  addQuetion(req, rep);
  rep.redirect("back");
});

//QUIZ TEST
elearningApp.get("/quize-list/:id/:id_user", function (req, rep) {
  queryParams = [req.params.id];
  quizQuestionsList(req, rep, queryParams);
});

//question answer
elearningApp.post("/question-answer/:id", function (req, rep) {
  queryParams = [req.params.id];
  manageQuestionAnswer(req, rep, queryParams);
});

//final EXAM
elearningApp.get("/getExamFinal/:id/:user_id", function (req, rep) {
  getFinalExam(req, rep);
});

//manage answers
elearningApp.post("/manageAnswer", function (req, rep) {
  insertAnswers(req, rep);
});

//show Result Exam
elearningApp.get("/showResultExam/:id/:id_tra", function (req, rep) {
  resultExam(req, rep);
});

//contact page
elearningApp.get("/contact/:id", function (req, rep) {
  queryParams = [req.params.id];
  rep.render("contact-page", { id_user: queryParams });
});
