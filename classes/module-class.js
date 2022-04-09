
var mysql = require('mysql');
const path = require('../server');

var connectionParams = require(path +  '/connectionDB.js');

class Modules{
    
    constructor(moduleId,modulTraining,moduleTiltle,moduleDescription,modulePrice){
        
        this.moduleId = moduleId;
        this.moduleTraining = modulTraining;
        this.moduleTiltle = moduleTiltle;
        this.moduleDescription = moduleDescription;
        this.modulePrice = modulePrice;

    }

    printModuleInfos(){

        console.log(this.moduleId);
        console.log(this.moduleTraining);
        console.log(this.moduleTiltle);
        console.log(this.moduleDescription);
        console.log(thiq.modulePrice);

    }

    addNewModule(){

        var connection = mysql.createConnection(connectionParams);

        var insertModuleQuery = "INSERT INTO MODULE(MODULE_TRAINING,MODULE_TITLE,MODULE_DESCRIPTION,MODULE_PRICE) VALUES ('" + this.moduleTraining + "','" + this.moduleTiltle + "','" + this.moduleDescription + "'," + this.modulePrice + ")";

        connection.connect(function(err){
            if(err) console.log('error connection to db');
            else{
                connection.query(insertModuleQuery,function(err,result){
                    if(err) console.log('error insertion module query');
                    else{
                        //console.log(result);
                    }
                });
            }
        });

    }

}

module.exports = Modules;