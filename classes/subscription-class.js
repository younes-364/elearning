var mysql = require('mysql');
const path = require('../server');

var connectionParams = require(path +  '/connectionDB.js');

class Subscription {

    constructor(subscriptionId, subscriptionUser, subscriptionTraining, subscriptionDate) {
        this.subscriptionId = subscriptionId;
        this.subscriptionUser = subscriptionUser;
        this.subscriptionTraining = subscriptionTraining;
        this.subscriptionDate = subscriptionDate;
    }

    addNewSubscription() {

        var connection = mysql.createConnection(connectionParams);
        var insertSubscription = "insert into SUBSCRIPTION (SUBSCRIPTION_USER,SUBSCRIPTION_TRAINING,SUBSCRIPTION_DATETIME) values (" + this.subscriptionUser + "," + this.subscriptionTraining + ",'" + this.subscriptionDate + "');";

        connection.connect(function (err) {
            if (err) console.log('error connection to datbasase');
            else {
                connection.query(insertSubscription, function (err, result) {
                    if (err) console.log('error insertion query');
                    else {
                        //console.log(result);
                    }
                });
            }
        });


    }

}

module.exports = Subscription;