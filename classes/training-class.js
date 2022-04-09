
var mysql = require('mysql');
const path = require('../server');

var connectionParams = require(path +  '/connectionDB.js');

class Training{


    constructor(trainingId,trainingTitle,trainingDescription){

        this.trainingId = trainingId;
        this.trainingTitle = trainingTitle;
        this.trainingDescription = trainingDescription;

    }

    printTrainingInfos(){

        console.log(this.trainingId);
        console.log(this.trainingTitle);
        console.log(this.trainingDescription);

    }

    addNewTraining(){

       var connection = mysql.createConnection(connectionParams);

       var insertionTrainingQuery = "insert into TRAINING (TRAINING_TITLE,TRAINING_DESCRIPTION) VALUES ('" + this.trainingTitle + "','" + this.trainingDescription + "')";

        connection.connect(function(err){

            if(err) console.log('error connection to database');
            else{
                connection.query(insertionTrainingQuery,function(err,result){
                    if(err) console.log('error insertion training query');
                    else{
                        //console.log(result);
                    }
                });
            }

        });

    }

}

module.exports = Training;