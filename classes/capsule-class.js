
var mysql = require('mysql');
const path = require('../server');

var connectionParams = require(path +  '/connectionDB.js');

class Capsule{

    constructor(capsuleId,capsuleModule,capsuleUrl,capsuleHasBeenSeen){

        this.capsuleId = capsuleId;
        this.capsuleModule = capsuleModule;
        this.capsuleUrl = capsuleUrl ;
        this.capsuleHasBeenSeen = capsuleHasBeenSeen;
    }

    printInfosCapsule(){
        console.log(this.capsuleId);
        console.log(this.capsuleModule);
        console.log(this.capsuleUrl);
        console.log(this.capsuleHasBeenSeen);

    }

    addNewCapsule(){

        var connection = mysql.createConnection(connectionParams);

        var insertIntoCapsule = "insert into capsule (CAPSULE_MODULE,CAPSULE_URL,CAPSULE_HAS_BEEN_SEEN) values (" + this.capsuleModule + ",'" + this.capsuleUrl + "'," + this.capsuleHasBeenSeen + ");";

        connection.connect(function(err){
            if(err) console.log('error connetion to db');
            else{
                connection.query(insertIntoCapsule,function(err,result){
                    if(err) console.log('error insert capsule query');
                    else{
                        //console.log(result);
                    }
                });
            }
        });

    }



}

module.exports = Capsule;