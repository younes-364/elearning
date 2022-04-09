var mysql = require("mysql2");

const path = require("../server");

var Subscription = require(path + "/classes/subscription-class.js");

var connectionParams = require(path + "/connectionDB.js");

addSubscription = function (req, rep) {
  var connection = mysql.createConnection(connectionParams);
  var getSubcriptions =
    "select * from SUBSCRIPTION where SUBSCRIPTION_USER = ?";
  queryParams = [req.params.id];
  connection.connect(function (err) {
    if (err) console.log("error connecion to db");
    else {
      connection.query(getSubcriptions, queryParams, function (err, result) {
        if (err) console.log("error get subscriptions query");
        else {
          var i = 0;
          //console.log(result);

          if (result.length == 0) {
            i = 3;
          }

          for (let j = 0; j < result.length; j++) {
            if (req.body.subTraining == result[j].SUBSCRIPTION_TRAINING) {
              i = 1;
              break;
            } else {
              i = 2;
            }
          }

          if (i == 1) {
            req.flash("warning", "you lready has this training");
            return rep.redirect("back");
          } else if (i == 2 || i == 3) {
            var date = new Date();
            var dateTime =
              date.getFullYear() +
              "-" +
              date.getMonth() +
              "-" +
              date.getDate() +
              " " +
              date.getHours() +
              ":" +
              date.getMinutes() +
              ":" +
              date.getSeconds();
            var subscription1 = new Subscription(
              null,
              req.params.id,
              req.params.tra_id,
              dateTime.toString()
            );
            subscription1.addNewSubscription();
            rep.redirect("/myTrainings/" + req.params.id);
          }
        }
      });
    }
  });
};

module.exports = addSubscription;
