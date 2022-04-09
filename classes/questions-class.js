
var mysql = require('mysql');
const path = require('../server');

var connectionParams = require(path +  '/connectionDB.js');

class Question{

    constructor(questionId,questionModule,questionText,questionFirstChoice,questionSecondChoice,questionThirdChoice,correctChoice,hardnessLevel){

        this.questionId = questionId;
        this.questionModule = questionModule;
        this.questionText = questionText;
        this.questionFirstChoice = questionFirstChoice;
        this.questionSecondChoice =questionSecondChoice ;
        this.questionThirdChoice = questionThirdChoice;
        this.correctChoice = correctChoice;
        this.hardnessLevel = hardnessLevel;

    }

    printQuestionInfos(){

        console.log(this.questionId);
        console.log(this.questionModule);
        console.log(this.questionText);
        console.log(this.questionFirstChoice);
        console.log(this.questionSecondChoice);
        console.log(this.questionThirdChoice);
        console.log(this.correctChoice);
        console.log(this.hardnessLevel);

    }

    addNewQuestion(){
        
        var connection = mysql.createConnection(connectionParams);

        var insertQueryQuestion = "INSERT INTO QUESTION (QUESTION_MODULE,QUESTION_TEXT,QUESTION_FIRST_CHOICE,QUESTION_SECOND_CHOICE,QUESTION_THIRD_CHOICE,QUESTION_CORRECT_CHOICE,QUESTION_HARDNESS_LEVEL) VALUES (" + this.questionModule + ",'" + this.questionText + "','" + this.questionFirstChoice + "','" + this.questionSecondChoice + "','" + this.questionThirdChoice + "','" + this.correctChoice +  "'," + this.hardnessLevel + ");";
        connection.connect(function(err){
            if(err) console.log('error connection to db');
            else{
                connection.query(insertQueryQuestion,function(err,result){
                    if(err) console.log('error insert query question');
                    else{

                        //console.log(result);

                    }
                });
            }
        });

    }

}

module.exports = Question;