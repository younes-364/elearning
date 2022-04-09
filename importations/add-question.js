const path = require("../server");

const Enum = require('enum');

const myEnum = new Enum(['LOW', 'MEDIUM', 'HEIGH']);

var Question = require(path + "/classes/questions-class.js");

var addQuestion = function(req,rep){

    var question1 = new Question();

    if(req.body.hardnessLevel == 'LOW'){

        question1 = new Question(null,req.body.questionModule,req.body.questionTexte,req.body.firstChoice,req.body.secondChoice,req.body.thirdChoice,req.body.correctChoice,myEnum.LOW.value);
        question1.addNewQuestion();

    }else if(req.body.hardnessLevel == 'MEDIUM'){
        
        question1 = new Question(null,req.body.questionModule,req.body.questionTexte,req.body.firstChoice,req.body.secondChoice,req.body.thirdChoice,req.body.correctChoice,myEnum.MEDIUM.value);
        question1.addNewQuestion();

    }else if(req.body.hardnessLevel == 'HEIGH'){

        question1 = new Question(null,req.body.questionModule,req.body.questionTexte,req.body.firstChoice,req.body.secondChoice,req.body.thirdChoice,req.body.correctChoice,myEnum.HEIGH.value);
        question1.addNewQuestion();
    }


}

module.exports = addQuestion;