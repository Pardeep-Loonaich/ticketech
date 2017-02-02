﻿/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: OpenSQLConnection
  Description: To create driver instance for the DB DataBase
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
function OpenSQLConnection (strHostName, strDBDataBase) {
  if (strDBDataBase == undefined) {
    strDataBase = Project.Variables.DataBase;
  }
  if (strHostName == undefined) {
    strHostName = Sys.HostName;
  }
  
  // private variables  
  var adoDriver, strConnectionString;
  adoDriver = ADO.CreateADOQuery();
  strConnectionString = "Provider=SQLOLEDB.1;Database=" + strDataBase + ";Hostname=" + strHostName + ";Protocol=TCPIP;Port=" + Project.Variables.DBPort + ";Uid=" + Project.Variables.DBUserID + ";Pwd=" + Project.Variables.DBPassword;
  adoDriver.ConnectionString = strConnectionString;
  
  Logger.Info("Created DB Driver instance");
  
  this.getDriver = function() {    // returns driver object
    return adoDriver;
  }
  
  this.getConnectionString = function() {
    return strConnectionString;   // returns connection string
  }  
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: select
  Description: To post a SQL query to the DataBase
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
OpenSQLConnection.prototype.select = function(strQuery) {
  try {
    var currentDriver = this.getDriver();
    currentDriver.SQL = strQuery;
    currentDriver.Open();    
    return currentDriver;
  }
  catch (ex) {
    // throw Logger.Error("Error while peforming select command ('" + strQuery + "') : ", ex);
    Log.Error("Error while peforming select command ('" + strQuery + "') : " + ex.description);
  }
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: close
  Description: To close a DataBase driver instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
OpenSQLConnection.prototype.close = function() {
  this.getDriver().Close();
}

function hostName(){
conString = OpenSQLConnection().getConnectionString();
Log.Message(conSting);

}