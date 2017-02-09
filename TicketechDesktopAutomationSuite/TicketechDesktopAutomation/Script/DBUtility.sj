/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: OpenSQLConnection
  Description: To create driver instance for the DB DataBase
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
function OpenSQLConnection () {
  
  // private variables  
  var adoDriver, strConnectionString;
  //strConnectionString = "Provider=SQLOLEDB;Database=GarageABC026;Hostname=ASPIRE809\SQLEXPRESS;Protocol=TCPIP;Port=2411;Uid=sa;Pwd=projectuy";
  strConnectionString = "Provider=SQLOLEDB;Server=ASPIRE809\\SQLEXPRESS" + ";Database=GarageABC026;Uid=sa; Pwd=projectuy;";
  //strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=GarageABC026.mdb;Username=sa;Password=projectuy";
  adoDriver = Sys.OleObject("ADODB.Connection");
  adoDriver.ConnectionString = strConnectionString;
  adoDriver.Open();  
  adoDriver.SQL = "SELECT EmployeeID FROM [GarageABC026].[dbo].[Employees] where EmployeeDeleted = 0";
  
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

function OpenSQLConnection1 () {
   // private variables  
  var adoDriver, strConnectionString;
  adoDriver = ADO.CreateADOQuery();
  strConnectionString = "Provider=sqloledb;Server=ASPIRE809\\SQLEXPRESS" + ";Database=GarageABC026;Uid=sa; Pwd=projectuy";
  adoDriver.ConnectionString = strConnectionString;
  empID = "80580";
  
  Log.Message("Created DB Driver instance");
  
  adoDriver.SQL =  "SELECT EmployeeID,EmployeeLastName,EmployeeFirstName FROM [GarageABC026].[dbo].[Employees] where EmployeeDeleted = 0";
  
  adoDriver.Open();
  adoDriver.First();
  while (! adoDriver.EOF)
  { 
    if(adoDriver.FieldByName("EmployeeID").Value == empID){
      Log.Message(adoDriver.FieldByName("EmployeeLastName").Value);
      break;
    } 
    else{
      Log.Message(adoDriver.FieldByName("EmployeeID").Value);
      adoDriver.Next();
    }
  }
  // Closes the query
  adoDriver.Close();

}