var mysql = require('mysql');
const path = require('../server');

var connectionParams = require(path +  '/connectionDB.js');

class User{

    constructor(userId,firstName,lastName,email,password,country,baseLevel,mediumLevel,expertLevl){
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.country = country;
        this.baseLevel = baseLevel;
        this.mediumLevel = mediumLevel;
        this.expertLevel  = expertLevl ;
    }

    printUserInfos(){
        console.log(this.userId);
        console.log(this.firstName);
        console.log(this.lastName);
        console.log(this.email);
        console.log(this.password);
        console.log(this.country);
        console.log(this.baseLevel);
        console.log(this.mediumLevel);
        console.log(this.expertLevel);

    }

    addNewUser(){

        var connextion = mysql.createConnection(connectionParams);
        var insertQueryIntoUsers = "INSERT INTO USERS (USER_FIRST_NAME,USER_LAST_NAME,USER_EMAIL,USER_PASSWORD,USER_COUNTRY,USER_BASE_LEVEL,USER_MEDIUM_LEVEL,USER_EXPERT_LEVEL) VALUES ('" + this.firstName + "','" + this.lastName + "','" + this.email + "','" + this.password + "','" + this.country + "'," + this.baseLevel + "," + this.mediumLevel + "," + this.expertLevel +")";
        
        connextion.connect(function(err){

            if(err) console.log('error connection to database...');
            else{
                connextion.query(insertQueryIntoUsers,function(err,result){

                    if(err) console.log('error insertion query into users');
                    else{
                       // console.log(result);
                    }

                });
                
            }

        });

    }




}

module.exports = User;