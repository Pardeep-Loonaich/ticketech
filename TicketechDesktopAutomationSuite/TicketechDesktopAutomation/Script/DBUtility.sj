
function DBConnection () {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: DBConnection
  Description: To create driver instance for the DB DataBase
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  
  // private variables  
  var ADODriver, sConnectionString;
  
  sConnectionString = "Provider=SQLOLEDB;Server="+Sys.HostName+"\\SQLEXPRESS" + ";Database=GarageABC026;Uid=sa;Pwd=projectuy;";
  
  ADODriver = ADO.CreateADOQuery();
  ADODriver.ConnectionString = sConnectionString;
  
  TestLog.Message("DB Driver instance Created");
    
  this.getDriver = function() {    // returns driver object
    return ADODriver;
  }
  
  this.getConnectionString = function() {
    return sConnectionString;   // returns connection string
  }  
}

DBConnection.prototype.ExecuteQuery = function(strQuery) {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: ExecuteQuery
  Description: To post a SQL query to the DataBase
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  try {
  
    var currentDriver = this.getDriver();
    currentDriver.SQL = strQuery;
    currentDriver.Open();    
    return currentDriver;
    
  }
  catch (ex) {
    TestLog.Error("Error while peforming select command ('" + strQuery + "') : " + ex.description);
  }
}

DBConnection.prototype.close = function() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: close
  Description: To close a DataBase driver instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  var currentDriver = this.getDriver();
  currentDriver.Close();
}

function New(){

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: New
  Description: To create a new DataBase driver instance in TestCases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
return new DBConnection();
}



