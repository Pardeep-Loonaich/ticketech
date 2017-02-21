//USEUNIT DBUtility

function userLoginDetails(sUserType){

/*------------------------------------------------------------------------------
  Function    : timekeeperUserLoginDetails
  Description : This function can be used to get a Timekeeper user login details
------------------------------------------------------------------------------*/

  var objUserDetails = {username : null, password : null};//Stores User's Username and password 
  var sQuery = null;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
  
    switch (sUserType){
      
      case "TimekeeperWithEnrollMenu":
        //Query to get the username and password of Timekeeper User with EnrollMenu Access
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('CreateEmployee','Employee Enrollment')))";
        break;
                    
      case "TimekeeperWithoutEnrollMenu":
        //Query to get the username and password of Timekeeper User without EnrolMenu Access
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND RU.RoleGUID IN ( Select RF1.RoleGUID FROM RolesFeatures  RF1"
		                +" LEFT JOIN RolesFeatures RF2 ON RF1.RoleGUID = RF2.RoleGUID" 
		                +" AND RF2.FeatureGUID IN (Select Distinct FeatureGUID from Features where FeatureDescription IN ('CreateEmployee','Employee Enrollment'))"
		                +" WHERE RF1.FeatureGUID = (Select Distinct FeatureGUID from Features where FeatureDescription IN ('Timekeeper Menu'))"
		                +" AND RF2.RoleGUID IS NULL)";
        break;
      
      default:
        //Query to get the username and password
        sQuery = "SELECT TOP 1 UserName, UserPassword FROM Users";
    } 
    Log.Message(sQuery);
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    objADODriver.First();
      
    //Storing Username, password Data from DB into Test data Object
    if(!objADODriver.EOF) { 
      objUserDetails.username = objADODriver.FieldByName("UserName").Value.toString();
      objUserDetails.password = objADODriver.FieldByName("UserPassword").Value.toString();                                           
    }
    return objUserDetails;  
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function timekeeperUserLoginDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//timekeeperUserLoginDetails

function updateEmployeeCode(empId){

/*--------------------------------------------------------------------------------
  Function    : UpdateEmployeeCode
  Description : This function can be used to Update the code of the given Employee
--------------------------------------------------------------------------------*/

  //The Template to store user code in EmployeesTemplateImage column of Employees table
  var objEmployeeTemplate = "<\?xml version=\"1.0\" encoding\=\"utf-16\"\?><TemplateData xmlns:xsd\=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi\=\"http://www.w3.org/2001/XMLSchema-instance\">"
                              +  "<TemplateImageData><Size>0</Size><ClassVersion /></TemplateImageData>"
                              +  "<TemplatePassword><Password>"+empId+"</Password>" //EmployeeID will be set as EmployeeCode
                              +  "<ClassVersion /></TemplatePassword><TemplateType>Password</TemplateType>" 
                              +  "<ClassVersion><CurrentVersion>1.1.1.1</CurrentVersion></ClassVersion></TemplateData>";
  var iRowsAffected = 0; 
  var bRowsAffected = false;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
  
    //Query to set the Employee Code for the given user
    query = "UPDATE Employees SET EmployeesTemplateImage = '" +objEmployeeTemplate+ "' WHERE EmployeeID = '"+empId+"'";
  
    iRowsAffected = DBConnection.ExecuteNonQuery(query);
    
    if(iRowsAffected >= 1) 
      bRowsAffected = true;                                           
    
    return bRowsAffected;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function updateEmployeeCode Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//updateEmployeeCode

function getValidEmployeeID(sEnrollmentType){

/*-----------------------------------------------------------------
  Function    : getValidEmployeeID
  Description : This function can be used to get a valid EmployeeID
------------------------------------------------------------------*/
  
  var sEmployeeId = null;
  var sQuery = null;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
  
    //Query to get the EmployeeID of an Employee who is not softDeleted
    if (sEnrollmentType !== null || sEnrollmentType != undefined)   
      sQuery = "SELECT TOP 1 EmployeeID FROM Employees WHERE EmployeeDeleted = 0"
               +" AND EmployeesTemplateImage LIKE '%<TemplateType>"+sEnrollmentType+"</TemplateType>%'";
               
    else
      sQuery = "SELECT TOP 1 EmployeeID FROM Employees WHERE EmployeeDeleted = 0";
  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    objADODriver.First();
    
    //Verifying the no of rows affected by update query, if >= 1 , query passed
    if(!objADODriver.EOF )
      sEmployeeId = objADODriver.FieldByName("EmployeeID").Value;                                           
    
    return sEmployeeId;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getValidEmployeeID Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getValidEmployeeID

function getPunchInOutEmployee(sEmpID){

/*--------------------------------------------------------------------------------------------------------
  Function    : getPunchInOutStatus
  Description : This function can be used to get any/given Employee punch details who has Punched recently
--------------------------------------------------------------------------------------------------------*/

  //stores the PunchInOut details of the given employee ID
  var ePunchInOutEmpDetails = {sEmployeeGUID : null , sEmployeeID : null, bPunchInOutStatus : false, sLastPunchDateTime : null};
  
  var sQuery = null;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(sEmpID == null || sEmpID == undefined)
      //Query to get an employee ID, LastPunchStatus, LastPunchDateTime who has punched recently
      sQuery = "SELECT Distinct TOP 1  P.EmployeeGUID, E.EmployeeID, P.PunchInOut, MAX(CONVERT(VARCHAR(24),P.PunchDateTime,121)) AS RecentPunchDate"
                  +" FROM Punches P , Employees E"
                  +" WHERE E.EmployeeGUID = P.EmployeeGUID AND E.EmployeeDeleted = 0"
                  +" Group BY P.EmployeeGUID, E.EmployeeID, P.PunchInOut"
                  +" ORDER BY 4 desc";
    else {
      ePunchInOutEmpDetails.sEmployeeID = sEmpID;
      
      //Query to get given employee LastPunchStatus, LastPunchDateTime who has punched recently
      sQuery = "SELECT Distinct TOP 1 P.EmployeeGUID,  E.EmployeeID, P.PunchInOut, MAX(CONVERT(VARCHAR(24),P.PunchDateTime,121)) AS RecentPunchDate"
                  +" FROM Punches P , Employees E"
                  +" WHERE E.EmployeeGUID = P.EmployeeGUID AND E.EmployeeDeleted = 0"
                  +" AND E.EmployeeID = '" +sEmpID+ "'"
                  +" Group BY P.EmployeeGUID, E.EmployeeID, P.PunchInOut"
                  +" ORDER BY 4 desc";
    }
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){ 
      ePunchInOutEmpDetails.sEmployeeGUID       = objADODriver.FieldByName("EmployeeGUID").Value;
      ePunchInOutEmpDetails.sEmployeeID         = objADODriver.FieldByName("EmployeeID").Value;
      ePunchInOutEmpDetails.bPunchInOutStatus   = objADODriver.FieldByName("PunchInOut").Value;
      ePunchInOutEmpDetails.sLastPunchDateTime  = objADODriver.FieldByName("RecentPunchDate").Value;
    }                                             
    
    return ePunchInOutEmpDetails; 
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getPunchInOutEmployee Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getPunchInOutEmployee

function getEmployeeDetails(sEmpID){

/*--------------------------------------------------------------------------------
  Function    : getEmployeeDetails
  Description : This function can be used to get the details of the given Employee
---------------------------------------------------------------------------------*/

  //stores the details of the given employee ID
  var eEmployeeDetails = {
                           sEmployeeGUID : null, sEmployeeID : null, sLastName : null, sFirstName : null
                         , sSSN : null, sBirthDate : null, sTemplateImage: null, bEmployeeDeleted : false 
                         , bResult : false
                         };
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    //Query to get the given employee details
    sQuery = "SELECT EmployeeGUID, EmployeeID, EmployeeFirstName, EmployeeLastName, EmployeeSSN, EmployeeBirthDay,"
              +" EmployeesTemplateImage, EmployeeDeleted FROM Employees WHERE EmployeeID = '" +sEmpID+ "'";
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eEmployeeDetails.sEmployeeGUID    = objADODriver.FieldByName("EmployeeGUID").Value; 
      eEmployeeDetails.sEmployeeID      = objADODriver.FieldByName("EmployeeID").Value;
      eEmployeeDetails.sFirstName       = objADODriver.FieldByName("EmployeeFirstName").Value;
      eEmployeeDetails.sLastName        = objADODriver.FieldByName("EmployeeLastName").Value;
      eEmployeeDetails.sSSN             = objADODriver.FieldByName("EmployeeSSN").Value;
      eEmployeeDetails.sBirthDate       = objADODriver.FieldByName("EmployeeBirthDay").Value;
      eEmployeeDetails.sTemplateImage   = objADODriver.FieldByName("EmployeesTemplateImage").Value;
      eEmployeeDetails.bEmployeeDeleted = objADODriver.FieldByName("EmployeeDeleted").Value;
      eEmployeeDetails.bResult          = true; 
    }                                             
    
    return eEmployeeDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getEmployeeDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getEmployeeDetails

function getLastAddedEmployeeDetails(){

/*-----------------------------------------------------------------------------------------
  Function    : getLastAddedEmployeeDetails
  Description : This function can be used to get the details of the recently added Employee
-----------------------------------------------------------------------------------------*/

  //stores the details of the employee
  var eEmployeeDetails = {
                           sEmployeeGUID : null, sEmployeeID : null, sLastName : null, sFirstName : null
                         , sSSN : null, sBirthDate : null
                         };
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    //Query to get the details of recently added/modified Employee
    sQuery = "SELECT TOP 1 EmployeeGUID, EmployeeID, EmployeeFirstName, EmployeeLastName, EmployeeSSN, EmployeeBirthDay"
              +" FROM Employees WHERE EmployeeDeleted = 0 ORDER BY EmployeesTimeStamp DESC";
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eEmployeeDetails.sEmployeeGUID = objADODriver.FieldByName("EmployeeGUID").Value; 
      eEmployeeDetails.sEmployeeID   = objADODriver.FieldByName("EmployeeID").Value;
      eEmployeeDetails.sFirstName    = objADODriver.FieldByName("EmployeeFirstName").Value;
      eEmployeeDetails.sLastName     = objADODriver.FieldByName("EmployeeLastName").Value;
      eEmployeeDetails.sSSN          = objADODriver.FieldByName("EmployeeSSN").Value;
      eEmployeeDetails.sBirthDate    = objADODriver.FieldByName("EmployeeBirthDay").Value; 
    }                                             
    
    return eEmployeeDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getLastAddedEmployeeDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getLastAddedEmployeeDetails

function updateEmployeePunchDetails(sEmpGUID,bPunchStatus,sPunchDateTime,iChangePunchDateTime){

/*-----------------------------------------------------------------------------------------
  Function    : updateEmployeePunchDetails
  Description : This function can be used to Update the Punch details of the given Employee
-----------------------------------------------------------------------------------------*/

  var iRowsAffected = 0;
  var bRowsAffected = false;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(iChangePunchDateTime === 0)
      //Query to set the Employee Code, punchdatetime to current time for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+", PunchDateTime = GETDATE()"
                +" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = '"+sPunchDateTime+"'";

    else if (iChangePunchDateTime === 1)
      //Query to set the Employee Code, punchdatetime to 1 hour back for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+", PunchDateTime = DATEADD(HOUR,-1,GETDATE())"
                +" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = '"+sPunchDateTime+"'";
                
    else if (iChangePunchDateTime === 24)
      //Query to set the Employee Code, punchdatetime to 24 hour back for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+", PunchDateTime = DATEADD(HOUR,-24,GETDATE())"
                +" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = '"+sPunchDateTime+"'";
                
    else 
      //Query to set the Employee Code for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = '"+sPunchDateTime+"'";
    
    iRowsAffected = DBConnection.ExecuteNonQuery(query);
    
    if(iRowsAffected >= 1) 
      bRowsAffected = true;                                           
    
    return bRowsAffected;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function updateEmployeePunchDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//updateEmployeePunchDetails

function getDeletedEmployee(sEmpId){

/*------------------------------------------------------------------------------------------
  Function    : getDeletedEmployee
  Description : This function can be used to get the details of the recently deleted Employee
                or to verify given employee is deleted
-------------------------------------------------------------------------------------------*/

  //stores the details of the employee
  eResult = { sEmployeeId : null, bEmployeeDeleted : false };
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if (sEmpId == null || sEmpId == undefined)
      //Query to get the details of recently deletedd Employee
      sQuery = "SELECT TOP 1 EmployeeID FROM Employees WHERE EmployeeDeleted = 1"
                  +" ORDER BY EmployeesTimeStamp DESC";
    else
      //Query to get the details of recently deletedd Employee
      sQuery = "SELECT EmployeeID FROM Employees WHERE EmployeeDeleted = 1"
                  +" AND EmployeeID = '"+sEmpId+"'";
              
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved value
    if(!objADODriver.EOF ){ 
      eResult.sEmployeeId      = objADODriver.FieldByName("EmployeeID").Value; 
      eResult.bEmployeeDeleted = true;
    }                                             
    
    return eResult;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getDeletedEmployee Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getDeletedEmployee


