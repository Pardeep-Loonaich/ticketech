//USEUNIT DBUtility
//USEUNIT Utility
//USEUNIT XMLReader

function userLoginDetails(sUserType){

/*------------------------------------------------------------------------------
  Function    : userLoginDetails
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
                    +" WHERE FeatureDescription IN ('CreateEmployee','Employee Enrollment'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
        break;
                    
      case "TimekeeperWithoutEnrollMenu":
        //Query to get the username and password of Timekeeper User without EnrolMenu Access
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND RU.RoleGUID IN ( Select RF1.RoleGUID FROM RolesFeatures  RF1"
		                +" LEFT JOIN RolesFeatures RF2 ON RF1.RoleGUID = RF2.RoleGUID" 
		                +" AND RF2.FeatureGUID IN (Select Distinct FeatureGUID from Features where FeatureDescription IN ('CreateEmployee','Employee Enrollment'))"
		                +" WHERE RF1.FeatureGUID = (Select Distinct FeatureGUID from Features where FeatureDescription IN ('Timekeeper Menu'))"
		                +" AND RF2.RoleGUID IS NULL) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
        break;
      
      case "ExpensesUser":
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('Expenses'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
        break;
      
        
      case "BankDropUser":
        //Query to get the username and password of BankDrop User 
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('BankDrops'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
         break;           
      
      case "TechnicianMenuUser":
        //Query to get the username and password of Technician User 
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('TechnicianMenu'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
         break;  
	
	  case "LostClaimUser":
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('LostClaim'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
        break;
        
    case "CheckInReplacement":
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('CheckInReplacement'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
        break; 
        
    case "ReservationUser":
        sQuery = "SELECT TOP 1 U.UserName, U.UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                    +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		                +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +" WHERE FeatureDescription IN ('Reservations Menu', 'ReservationsReports',"
                    +" 'Parking Services - Search Parking Reservations'))) AND U.UserName <> U.UserPassword ORDER BY NEWID()";
        break;                  
 
      default:
        //Query to get the username and password
        sQuery = "SELECT TOP 1 UserName, UserPassword FROM Users WHERE U.UserName <> U.UserPassword ORDER BY NEWID()";
        break;
    } 
    
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
    TestLog.Message("Error in function userLoginDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//userLoginDetails

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
  Input       : sEnrollmentType - Password or Fingerprint
------------------------------------------------------------------*/
  
  var sEmployeeId = null;
  var sQuery = null;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
  
    //Query to get the EmployeeID of an Employee who is not softDeleted
    if (sEnrollmentType == null || sEnrollmentType == undefined)
      sQuery = "SELECT TOP 1 EmployeeID FROM Employees WHERE EmployeeDeleted = 0 ORDER BY NEWID()";
               
    else
      sQuery = "SELECT TOP 1 EmployeeID FROM Employees WHERE EmployeeDeleted = 0"
                  +" AND EmployeesTemplateImage LIKE '%<TemplateType>"+sEnrollmentType+"</TemplateType>%'"
                  +" ORDER BY NEWID()";
  
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
  var ePunchInOutEmpDetails = {sEmployeeGUID : null , sEmployeeID : null, bPunchInOutStatus : false, sLastPunchDateTime : null, bResult: false};
  
  var sQuery = null;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
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
      ePunchInOutEmpDetails.bResult             = true;
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
    
    Delay(1000);
    
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
    
    Delay(1000);
    
    //Query to get the details of recently added/modified Employee
    sQuery = "SELECT TOP 1 EmployeeGUID, EmployeeID, EmployeeFirstName, EmployeeLastName, EmployeeSSN, EmployeeBirthDay"
              +" FROM Employees WHERE EmployeeDeleted = 0 ORDER BY EmployeesTimeStamp DESC";
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF )
    {
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
    
    if(iChangePunchDateTime === 0) {
    
      //Query to set the Employee Code, punchdatetime to current time for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+", PunchDateTime = GETDATE()"
                +" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = '"+sPunchDateTime+"'";
    }
    else if (iChangePunchDateTime === 1) {
    
      preUpdateQuery =  "UPDATE Punches SET PunchDateTime = DATEADD(HOUR,-4,PunchDateTime)"
                            +" where PunchDateTime > DATEADD(HOUR,-6,GETDATE())"
                            +" AND EmployeeGUID ='"+sEmpGUID+"'";
                        
      DBConnection.ExecuteNonQuery(preUpdateQuery);
      
      //Query to set the Employee Code, punchdatetime to 1 hour back for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+", PunchDateTime = DATEADD(HOUR,-1,GETDATE())"
                +" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = (Select MAX(PunchDateTime) FROM " 
                +" Punches where EmployeeGUID = '"+sEmpGUID+"')";
    }           
    else if (iChangePunchDateTime === 24) {
    
      preUpdateQuery =  "UPDATE Punches SET PunchDateTime = DATEADD(HOUR,-28,PunchDateTime)"
                            +" where PunchDateTime > DATEADD(HOUR,-30,GETDATE())"
                            +" AND EmployeeGUID ='"+sEmpGUID+"'";
                            
      DBConnection.ExecuteNonQuery(preUpdateQuery);
                        
      //Query to set the Employee Code, punchdatetime to 24 hour back for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+", PunchDateTime = DATEADD(HOUR,-24,GETDATE())"
                +" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = (Select MAX(PunchDateTime) FROM " 
                +" Punches where EmployeeGUID = '"+sEmpGUID+"')";
    }            
    else { 
      //Query to set the Employee Code for the given user
      query = "UPDATE Punches SET PunchInOut = "+bPunchStatus+" WHERE EmployeeGUID = '"+sEmpGUID+"'AND PunchDateTime = '"+sPunchDateTime+"'";
    }
    
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
    
    Delay(1000);
    
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

function getMonthlyCustomerAccountDetails(sAccountNumber){

/*----------------------------------------------------------------------------------------------
  Function    : getMonthlyCustomerAccountDetails
  Description : This function can be used to get the details of the given MonthlyCustomerAccount
----------------------------------------------------------------------------------------------*/

  //stores the details of the Customer AccountNumber
  var eCustomerAccountDetails = {
                                  sCustomerGUID : null, sAccountNo      : null, sCustomerName : null,  
                                  fBalanceDue   : 0.00, bCutomerDeleted : false, bResult       : false
                                };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    if (sAccountNumber == null || sAccountNumber == undefined)    
      //Query to get the random account details
      sQuery =   "SELECT TOP 1 MC.CustomerGUID, MC.CustomerAccountNumber, C.CustomerName, MC.CustomerAccountStatus,"
		              +" MC.CustomerPaymentStatus, MC.CustomerBalanceDue, C.CustomerDeleted" 
                  +" FROM MonthlyCustomers MC, Customers C"
                  +" WHERE C.CustomerGUID = MC.CustomerGUID AND C.CustomerDeleted = 0 ORDER BY NEWID()";
    else
      //Query to get the given account details
      sQuery =   "SELECT MC.CustomerGUID, MC.CustomerAccountNumber, C.CustomerName, MC.CustomerAccountStatus,"
		              +" MC.CustomerPaymentStatus, MC.CustomerBalanceDue, C.CustomerDeleted" 
                  +" FROM MonthlyCustomers MC, Customers C"
                  +" WHERE C.CustomerGUID = MC.CustomerGUID AND MC.CustomerAccountNumber = '"+sAccountNumber+"'";
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eCustomerAccountDetails.sCustomerGUID    = objADODriver.FieldByName("CustomerGUID").Value; 
      eCustomerAccountDetails.sAccountNo       = objADODriver.FieldByName("CustomerAccountNumber").Value;
      eCustomerAccountDetails.sCustomerName    = objADODriver.FieldByName("CustomerName").Value;
      eCustomerAccountDetails.fBalanceDue      = objADODriver.FieldByName("CustomerBalanceDue").Value;
      eCustomerAccountDetails.bCutomerDeleted  = objADODriver.FieldByName("CustomerDeleted").Value;
      eCustomerAccountDetails.bResult          = true; 
    }                                             
    
    return eCustomerAccountDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getMonthlyCustomerAccountDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getMonthlyCustomerAccountDetails

function getIncomeDetails(sAccountNumber){

/*----------------------------------------------------------------------------------------------
  Function    : getIncomeDetails
  Description : This function can be used to get the income details of the given CustomerAccount
----------------------------------------------------------------------------------------------*/

  //stores the IncomeDetails
  var eIncomeDetails =   {
                           sAccountNo  : null, sIncomeTimeStamp : null, sIncomeAmount   : null,  
                           sIncomeType : null, sIncomeTaxRate   : null, sIncomeCodeName : null, 
                           sIncomeCode : null, sIncomeGUID      : null, bResult         : false
                         };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if (sAccountNumber == null || sAccountNumber == undefined )    
      //Query to get the Last added Income details
      sQuery =   "SELECT TOP 1 I.CustomerAccountNumber, I.IncomeTimeStamp, I.IncomeAmount, I.IncomeType,"
		              +" ID.IncomeDetailTaxRate, IC.IncomeCodeGUID, IC.IncomeCodeDescription, I.IncomeGUID" 
                  +" FROM Income I, IncomeDetails ID, IncomeCodes IC"
                  +" WHERE I.IncomeGUID = ID.IncomeGUID AND ID.IncomeCodeGUID = IC.IncomeCodeGUID"
                  +" ORDER BY I.IncomeTimeStamp DESC";
    else
      //Query to get the given accountNumber's Payment details as Income
      sQuery =   "SELECT TOP 1 I.CustomerAccountNumber, I.IncomeTimeStamp, I.IncomeAmount, I.IncomeType,"
		              +" ID.IncomeDetailTaxRate, IC.IncomeCodeGUID, IC.IncomeCodeDescription, I.IncomeGUID" 
                  +" FROM Income I, IncomeDetails ID, IncomeCodes IC"
                  +" WHERE I.IncomeGUID = ID.IncomeGUID AND ID.IncomeCodeGUID = IC.IncomeCodeGUID"
                  +" AND I.CustomerAccountNumber = '" +sAccountNumber+ "'"
                  +" ORDER BY I.IncomeTimeStamp DESC";
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eIncomeDetails.sAccountNo        = objADODriver.FieldByName("CustomerAccountNumber").Value; 
      eIncomeDetails.sIncomeTimeStamp  = objADODriver.FieldByName("IncomeTimeStamp").Value;
      eIncomeDetails.sIncomeAmount     = objADODriver.FieldByName("IncomeAmount").Value;
      eIncomeDetails.sIncomeType       = objADODriver.FieldByName("IncomeType").Value;
      eIncomeDetails.sIncomeTaxRate    = objADODriver.FieldByName("IncomeDetailTaxRate").Value;
      eIncomeDetails.sIncomeCode       = objADODriver.FieldByName("IncomeCodeDescription").Value;
      eIncomeDetails.sIncomeGUID       = objADODriver.FieldByName("IncomeGUID").Value;
      eIncomeDetails.bResult           = true; 
    }                                             
    
    return eIncomeDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getIncomeDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getIncomeDetails

function getPaymentDetails(ePayData){

/*----------------------------------------------------------------------------------------------
  Function    : getPaymentDetails
  Description : This function can be used to get the Payment details of the given CustomerAccount
----------------------------------------------------------------------------------------------*/

  //stores the PaymentDetails
  bResult = false;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(ePayData.sPayType === "Check")
      //Query to get the Last added Payment details
      sQuery =  "SELECT PC.PaymentCheckBank, PC.PaymentCheckNumber, PD.PaymentDetailType, PD.PaymentDetailAmount"
                  +" FROM PaymentsCheck PC, PaymentsDetails PD"
                  +" WHERE PC.PaymentDetailGUID = PD.PaymentDetailGUID"
                  +" AND PC.PaymentCheckAccount = '"+ePayData.sAccountNo+"'"
                  +" AND PC.PaymentCheckNumber = '"+ePayData.iCheckNumber+"'"
                  +" AND PC.PaymentCheckBank = '"+ePayData.sBankName+"'" ;
    
    else if(ePayData.sPayType === "Cash")
      //Query to get the Last added Payment details
      sQuery =  "SELECT PD.PaymentDetailType, P.PaymentDate, P.PaymentAmount"
                  +" FROM PaymentsDetails PD, Payments P, PaymentsIncome PIN"
                  +" WHERE P.PaymentGUID = PD.PaymentGUID AND P.PaymentGUID = PIN.PaymentGUID"
                  +" AND PD.PaymentDetailType = 'CSH' AND P.PaymentAmount = "+ePayData.iPayAmount+".00"
                  +" AND PIN.IncomeGUID = (SELECT TOP 1 I.IncomeGUID FROM Income I WHERE I.CustomerAccountNumber = '"+ePayData.sAccountNo+"' ORDER BY I.IncomeTimeStamp DESC)";
    
    else if(ePayData.sPayType === "CreditCard"){
      switch(ePayData.iCardIndex){
        case 1: sCreditCard = "VI"; break;
        case 2: sCreditCard = "MC"; break;
        case 3: sCreditCard = "DV"; break;
        case 4: sCreditCard = "DC"; break;
        case 5: sCreditCard = "AX"; break;
        case 6: sCreditCard = "\?\?"; break;
      }
      //Query to get the Last added Payment details
      sQuery =  "SELECT PD.PaymentDetailType, PC.CreditCardCode"
                  +" FROM PaymentsDetails PD, PaymentsCreditCard PC, PaymentsIncome PIN"
                  +" WHERE PD.PaymentDetailGUID = PC.PaymentDetailGUID AND PD.PaymentGUID = PIN.PaymentGUID"
                  +" AND PD.PaymentDetailType = 'CCD' AND PD.PaymentDetailAmount = "+ePayData.iPayAmount+".00"
                  +" AND PIN.IncomeGUID = (SELECT TOP 1 I.IncomeGUID FROM Income I WHERE I.CustomerAccountNumber = '"+ePayData.sAccountNo+"' ORDER BY I.IncomeTimeStamp DESC)"
                  +" AND PC.CreditCardCode = '"+sCreditCard+"'";
    }
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      bResult = true; 
    }                                             
    
    return bResult;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getPaymentDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getPaymentDetails

function updateCustomerAccountStatus(sAccountNo,bCustomerTagStatus){

/*------------------------------------------------------------------------------------------
  Function    : updateCustomerTagStatus
  Description : This function can be used to Update the Account status of the given Customer
-------------------------------------------------------------------------------------------*/

  var iRowsAffected = 0;
  var bRowsAffected = false;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(bCustomerTagStatus == 0) {
    
      //Query to set the CustomerAccount Status = 0, soft deleted
      query = "UPDATE MonthlyCustomers SET CustomerAccountStatus = 0"
                  +" WHERE CustomerAccountNumber = '"+sAccountNo+"'";
    }           
    else { 
      //Query to set the CustomerAccount Status = 1, active
      query = "UPDATE MonthlyCustomers SET CustomerAccountStatus = 1"
                  +" WHERE CustomerAccountNumber = '"+sAccountNo+"'";
    }  
    iRowsAffected = DBConnection.ExecuteNonQuery(query);
    
    if(iRowsAffected >= 1) 
      bRowsAffected = true;                                           
    
    return bRowsAffected;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function updateCustomerAccountStatus Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//updateCustomerAccountStatus


function getTicketNumber(sStayType){
/*-----------------------------------------------------------------------------------------------
  Function    : getTicketNumberForReceipts
  Description : This function can be used to get the ticket number for Receipts based on StayType
-----------------------------------------------------------------------------------------------*/

  //stores the ticket number
  sTicketNumber = null;
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    switch(aqString.ToUpper(sStayType)) {
      //Query to get a random ticket number of a DAILY customer
      case ("DAILY" || "TRANSIENT"): 
        sQuery = "SELECT TOP 1 StayTicket FROM Stays WHERE StayDateOut IS NOT NULL"
                   +" AND LostClaim = 0 AND StayType = 0 ORDER BY NEWID() DESC";
        break;
      //Query to get a random ticket number of a MONTHLY customer
      case ("MONTHLY"): 
        sQuery = "SELECT TOP 1 StayTicket FROM Stays WHERE StayDateOut IS NOT NULL"
                   +" AND LostClaim = 0 AND StayType = 1 ORDER BY NEWID() DESC";
        break;
      //Query to get a random ticket number of a REPLACE customer
      case ("REPLACE"): 
        sQuery = "SELECT TOP 1 StayTicket FROM Stays WHERE StayDateOut IS NOT NULL"
                   +" AND LostClaim = 0 AND StayType = 2 ORDER BY NEWID() DESC";
        break;
      //Query to get a random ticket number of a customer who has done lostclaim
      case ("LOSTCLAIM"): 
        sQuery = "SELECT TOP 1 StayTicket FROM Stays WHERE StayDateOut IS NOT NULL"
                   +" AND LostClaim = 1 ORDER BY NEWID() DESC";
        break;
      //Query to get a random ticket number of a customer who has done lostclaim
      case ("STAYDATEIN" || "CHECKIN"): 
        sQuery = "SELECT TOP 1 StayTicket FROM Stays WHERE StayDateOut IS NULL"
                   +" ORDER BY NEWID() DESC";
        break;
    }
            
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved value
    if(!objADODriver.EOF ){ 
      sTicketNumber = objADODriver.FieldByName("StayTicket").Value; 
    }                                               
    return sTicketNumber;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getTicketNumber Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getTicketNumber


function validateTicketNumber(sTicketNumber){
/*----------------------------------------------------------------------------------------
  Function    : getTicketNumberForReceipts
  Description : This function can be used to check the ticket number for Receipts is valid
-----------------------------------------------------------------------------------------*/

  //sets invalid ticket number flag 
  bValidReceiptsTicketNumber = true;
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    

    sQuery = "SELECT StayTicket FROM Stays WHERE StayDateOut IS NOT NULL"
                +" AND LostClaim = 1 AND StayTicket = '"+sTicketNumber+"'";
            
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved value
    if(!objADODriver.EOF ){  
        bValidReceiptsTicketNumber = false;
    }                                               
    return bValidReceiptsTicketNumber;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getTicketNumber Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getTicketNumber


function getBagNumberDetails(sBagNumber){
/*---------------------------------------------------------------------
  Function    : getBagNumberDetails
  Description : This function can be used to get the Bag number details
------------------------------------------------------------------------*/

  //stores the BagNumber
  eBagNumberData = {sBagNo : null, sAmount : null, sDateTime : null, bResult : false};
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if (sBagNumber == null || sBagNumber == undefined)
      //Query to get a random BagNumber details
      sQuery = "SELECT TOP 1 BankDropAmount, CONVERT(VARCHAR(24),BankDropTime,121) as BankDropTime, BankDropBagNumber FROM BankDrops ORDER BY NEWID() DESC";
    else
      //Query to get a random BagNumber details
      sQuery = "SELECT TOP 1 BankDropAmount, CONVERT(VARCHAR(24),BankDropTime,121) as BankDropTime, BankDropBagNumber FROM BankDrops WHERE BankDropBagNumber = '"+sBagNumber+"'";          
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved value
    if(!objADODriver.EOF ){ 
      eBagNumberData.sBagNo    = objADODriver.FieldByName("BankDropBagNumber").Value;
      eBagNumberData.sAmount   = objADODriver.FieldByName("BankDropAmount").Value;
      eBagNumberData.sDateTime = objADODriver.FieldByName("BankDropTime").Value;
      eBagNumberData.bResult   = true;
    }                                               
    return eBagNumberData;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getBagNumberDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getBagNumberDetails

function getExpensesDetails(eExDetails){

/*-------------------------------------------------------------------------
  Function    : getExpenseDetails
  Description : This function can be used to get the Latest Expense details
-------------------------------------------------------------------------*/

  //stores the ExpenseDetails
  var eExpenseDetails =   { sDescription : null, sAmount : null, bResult : false };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    //Query to get the Last added Income details
    sQuery =  "SELECT TOP 1 ExpenseAmount, ExpenseDescription FROM Expenses ORDER BY ExpensesTimeStamp DESC";

    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eExpenseDetails.sAmount       = objADODriver.FieldByName("ExpenseAmount").Value; 
      eExpenseDetails.sDescription  = objADODriver.FieldByName("ExpenseDescription").Value;
      eExpenseDetails.bResult       = true; 
    }                                             
    
    return eExpenseDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getExpenseDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getExpenseDetails

function getCheckInTicketDetails(sCustomerType){

/*-------------------------------------------------------------------------------------------------------------
  Function    : getCheckInTicketDetails
  Description : This function can be used to get the Ticket details of a checkIn vehicle based on Customer Type
-------------------------------------------------------------------------------------------------------------*/

  //stores the Check In Vehicle Details
  var eCheckInVehicleDetails =   { 
                                   sStayGUID : null, sTicketNumber : null, sStayDateIn : null, sStayDateOut : null,
                                   sVehicleGUID : null, iDamageIdentifiaction : 0, iStayType : 0, sCustomerGUID: null,
                                   bResult : false
                                 };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sCustomerType === "Daily"){
      //Query to get the Check In Vehicle Details of a Daily Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NULL AND StayType = 0";
    }
    else if(sCustomerType === "Monthly"){
      //Query to get the Check In Vehicle Details of a Monthly Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NULL AND StayType = 1";
    }
    else if(sCustomerType === "Replace"){
      //Query to get the Check In Vehicle Details of a Replace Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NULL AND StayType = 2";
    }
    else {
      //Query to get the Check In Vehicle Details of a Daily Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NULL AND StayType = 0";
    }

    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eCheckInVehicleDetails.sStayGUID     = objADODriver.FieldByName("StayGUID").Value; 
      eCheckInVehicleDetails.sTicketNumber = objADODriver.FieldByName("StayTicket").Value;
      eCheckInVehicleDetails.sStayDateIn   = objADODriver.FieldByName("StayDateIn").Value;
      eCheckInVehicleDetails.sStayDateOut  = objADODriver.FieldByName("StayDateOut").Value;
      eCheckInVehicleDetails.sCustomerGUID = objADODriver.FieldByName("CustomerGUID").Value;
      eCheckInVehicleDetails.iDamageIdentifiaction = objADODriver.FieldByName("DamageIdentification").Value;
      eCheckInVehicleDetails.iStayType     = objADODriver.FieldByName("StayType").Value;
      eCheckInVehicleDetails.bResult       = true; 
    }                                             
    
     return eCheckInVehicleDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function eCheckInVehicleDetails Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//eCheckInVehicleDetails

function updateVehicleTagStatus(sTagNumber,bVehicleTagStatus){

/*-----------------------------------------------------------------------------------------
  Function    : updateVehicleTagStatus
  Description : This function can be used to Update the Tag status of the given Vehicle
-----------------------------------------------------------------------------------------*/

  var iRowsAffected = 0;
  var bRowsAffected = false;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(bVehicleTagStatus == 1) {   
      //Query to set the VehicleTagDeleted = 1, soft deleted
      query = "UPDATE CustomersTags SET VehicleTagDeleted = 1"
                  +" WHERE VehicleTagNumber = '"+sTagNumber+"'";
    }           
    else { 
      //Query to set the VehicleTagDeleted = 0, active
      query = "UPDATE CustomersTags SET VehicleTagDeleted = 0"
                  +" WHERE VehicleTagNumber = '"+sTagNumber+"'";
    }  
    iRowsAffected = DBConnection.ExecuteNonQuery(query);
    
    if(iRowsAffected >= 1) 
      bRowsAffected = true;                                           
    
    return bRowsAffected;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function updateVehicleTagStatus Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//updateVehicleTagStatus

function getVehicleTagToDoMonthly(){

/*------------------------------------------------------------------------------
  Function    : getVehicleTagToDoMonthly
  Description : This function can be used to get the VehicleTag To Do Monthly
------------------------------------------------------------------------------*/

  var eVehicleTagDetails = { sVehicleTag: null, sAccountNo: null, bResult : false };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    //Query to get the Tag number which is not currently in Check in Status
    sQuery =  "SELECT TOP 1 CT.VehicleTagNumber,MC.CustomerAccountNumber FROM CustomersTags CT, MonthlyCustomers MC, Customers C"
	              +" WHERE MC.CustomerGUID = C.CustomerGUID AND C.CustomerGUID = CT.CustomerGUID"  
	              +" AND MC.CustomerAccountStatus = 1 AND C.CustomerDeleted = 0"
	              +" AND CT.VehicleTagDeleted = 0 AND CT.CustomerTagStatus = 1 AND CT.VehicleTagNumber NOT IN ("
			          +" SELECT CT.VehicleTagNumber FROM CustomersTags CT, CustomerVehicles CV"
				        +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID IN ("
					      +" SELECT S.VehicleGUID FROM Stays S WHERE S.StayType IN (1,2) AND S.StayDateOut IS NULL))"
	              +" ORDER BY NEWID()";
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleTagDetails.sVehicleTag = objADODriver.FieldByName("VehicleTagNumber").Value;
      eVehicleTagDetails.sAccountNo  = objADODriver.FieldByName("CustomerAccountNumber").Value;
      eVehicleTagDetails.bResult     = true; 
    }                                             
    
    return eVehicleTagDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getVehicleTagToDoMonthly Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getVehicleTagToDoMonthly


function getVehicleTagToDoLostClaim(){

/*------------------------------------------------------------------------------
  Function    : getVehicleTagToDoLostClaim
  Description : This function can be used to get the VehicleTag To Do LostClaim
------------------------------------------------------------------------------*/

  var eVehicleTagDetails = { sVehicleTag: null, bResult : false };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    //Query to get the Tag number which is not currently in Check in Status
    sQuery =  "SELECT CT.VehicleTagNumber FROM CustomersTags CT, CustomerVehicles CV"
				        +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID IN ("
					      +" SELECT S.VehicleGUID FROM Stays S WHERE S.StayType IN (1) AND S.StayDateOut IS NULL)"
	              +" ORDER BY NEWID()";
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleTagDetails.sVehicleTag = objADODriver.FieldByName("VehicleTagNumber").Value;
      eVehicleTagDetails.bResult     = true; 
    }                                             
    
    return eVehicleTagDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getVehicleTagToDoLostClaim Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getVehicleTagToDoLostClaim

function getLastAddedVehicleStayDetails(sPlateNumber){

/*-----------------------------------------------------------------------
  Function    : getLastAddedVehicleStayDetails
  Description : This function can be used to get the Vehicle Stay details
-----------------------------------------------------------------------*/

  var eVehicleDetails = { 
                          sStayGUID : null, sStayTicket : null, sStayDateIn: null, sStayDateOut: null,
                          sVehicleGUID : null, iDamageIdentification : 0, iStayType : 0, bResult : false 
                        };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sPlateNumber !== null && sPlateNumber !== undefined){
      //Query to get the Last added Vehicle's Stay details
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket, StayDateIn, StayDateOut, VehicleGUID, DamageIdentification, StayType"
                  +" FROM Stays WHERE VehicleGUID IN ("
                  +" SELECT VehicleGUID FROM Vehicles WHERE VehiclePlate = '"+sPlateNumber+"') ORDER BY StayDateIn DESC";
    }
    else {
      //Query to get the Last added Vehicle's Stay details
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket, StayDateIn, StayDateOut, VehicleGUID, DamageIdentification, StayType"
                  +" FROM Stays WHERE VehicleGUID IN ("
                  +" SELECT TOP 1 VehicleGUID FROM Vehicles WHERE VehiclesTimeStamp"
                  +" BETWEEN DATEADD(mi,-3,GETDATE()) AND DATEADD(mi,+1,GETDATE()) ORDER BY VehiclesTimeStamp DESC) ORDER BY StayDateIn DESC";
    }              
    
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleDetails.sStayGUID    = objADODriver.FieldByName("StayGUID").Value; 
      eVehicleDetails.sStayTicket  = objADODriver.FieldByName("StayTicket").Value;
      eVehicleDetails.sStayDateIn  = objADODriver.FieldByName("StayDateIn").Value;
      eVehicleDetails.sStayDateOut = objADODriver.FieldByName("StayDateOut").Value;
      eVehicleDetails.sVehicleGUID = objADODriver.FieldByName("VehicleGUID").Value;
      eVehicleDetails.iDamageIdentification = objADODriver.FieldByName("DamageIdentification").Value;
      eVehicleDetails.iStayType    = objADODriver.FieldByName("StayType").Value;
      eVehicleDetails.bResult      = true; 
    }                                             
    
    return eVehicleDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getLastAddedVehicleStayDetails Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getLastAddedVehicleStayDetails


function getLastAddedMonthlyDetails(sTagNumber){

/*------------------------------------------------------------------------------
  Function    : getLastAddedMonthlyDetails
  Description : This function can be used to get Last Added Monthly Details
------------------------------------------------------------------------------*/

  var eVehicleTagDetails = { sVehicleTag: sTagNumber, sTicketNumber: null, bResult : false };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sTagNumber !==null && sTagNumber !== undefined) {
      //Query to get the given Tag number which is  currently in Check in Status
      sQuery =  "SELECT CT.VehicleTagNumber, S.StayTicket FROM CustomersTags CT, CustomerVehicles CV, Stays S"
				          +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID = "
					        +" S.VehicleGUID AND S.StayType = 1 AND S.StayDateOut IS NULL"
                  +" AND S.StayDateIn BETWEEN DATEADD(mi,-3,GETDATE()) AND DATEADD(mi,+1,GETDATE())"
	                +" AND CT.VehicleTagNumber = '"+sTagNumber+"'";
    }
    else {
      //Query to get the given Tag number which is  currently in Check in Status
      sQuery =  "SELECT CT.VehicleTagNumber, S.StayTicket FROM CustomersTags CT, CustomerVehicles CV, Stays S"
				          +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID = "
					        +" S.VehicleGUID AND S.StayType IN (1,2) AND S.StayDateOut IS NULL"
                  +" ORDER BY S.StayDateIn DESC";
    } 
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleTagDetails.sVehicleTag   = objADODriver.FieldByName("VehicleTagNumber").Value;
      eVehicleTagDetails.sTicketNumber = objADODriver.FieldByName("StayTicket").Value
      eVehicleTagDetails.bResult       = true; 
    }                                             
    return eVehicleTagDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getLastAddedMonthlyDetails Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getLastAddedMonthlyDetails

function getLastAddedReplaceDetails(sTagNumber){

/*------------------------------------------------------------------------------
  Function    : getLastAddedReplaceDetails
  Description : This function can be used to get Last Added Replace Details
------------------------------------------------------------------------------*/

  var eVehicleTagDetails = { sVehicleTag: sTagNumber, sTicketNumber: null, bResult : false };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sTagNumber !==null && sTagNumber !== undefined) {
      //Query to get the given Tag number which is  currently in Check in Status
      sQuery =  "SELECT CT.VehicleTagNumber, S.StayTicket FROM CustomersTags CT, CustomerVehicles CV, Stays S"
				          +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID = "
					        +" S.VehicleGUID AND S.StayType = 2 AND S.StayDateOut IS NULL"
                  +" AND S.StayDateIn BETWEEN DATEADD(mi,-3,GETDATE()) AND DATEADD(mi,+1,GETDATE())"
	                +" AND CT.VehicleTagNumber = '"+sTagNumber+"'";
    }
    else {
      //Query to get the given Tag number which is  currently in Check in Status
      sQuery =  "SELECT CT.VehicleTagNumber, S.StayTicket FROM CustomersTags CT, CustomerVehicles CV, Stays S"
				          +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID = "
					        +" S.VehicleGUID AND S.StayType IN (1,2) AND S.StayDateOut IS NULL"
                  +" ORDER BY S.StayDateIn DESC";
    } 
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleTagDetails.sVehicleTag   = objADODriver.FieldByName("VehicleTagNumber").Value;
      eVehicleTagDetails.sTicketNumber = objADODriver.FieldByName("StayTicket").Value
      eVehicleTagDetails.bResult       = true; 
    }                                             
    return eVehicleTagDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getLastAddedReplaceDetails Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getLastAddedReplaceDetails


function getVehicleDetails(sVehicleGUID){

/*------------------------------------------------------------------
  Function    : getVehicleDetails
  Description : This function can be used to get the Vehicle details
------------------------------------------------------------------*/

  var eVehicleDetails = { 
                          sVehicleGUID : null, sMake : null, sColor : null, sVehiclePlate : null,
                          bVehicleOversized : false, iVehicleSize: 0, bResult : false 
                        };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sVehicleGUID !== null && sVehicleGUID !== undefined)
      //Query to get the given Vehicle's details
      sQuery =  "SELECT V.VehicleGUID, (SELECT M.MakeName FROM Makes M WHERE M.MakeGUID = V.MakeGUID) MakeName,"
                  +" (SELECT C.ColorName FROM Colors C WHERE C.ColorGUID = V.ColorGUID) ColorName,"
                  +" V.VehiclePlate, V.VehicleOversized, V.VehicleSize"
                  +" FROM Vehicles V WHERE V.VehicleGUID = '"+sVehicleGUID+"'";
    else
      //Query to get the Last added Vehicle's details
      sQuery =  "SELECT TOP 1 V.VehicleGUID, (SELECT M.MakeName FROM Makes M WHERE M.MakeGUID = V.MakeGUID) MakeName,"
                  +" (SELECT C.ColorName FROM Colors C WHERE C.ColorGUID = V.ColorGUID) ColorName,"
                  +" V.VehiclePlate, V.VehicleOversized, V.VehicleSize"
                  +" FROM Vehicles V WHERE V.VehiclesTimeStamp"
                  +" BETWEEN DATEADD(mi,-1,GETDATE()) AND DATEADD(mi,+1,GETDATE())) ORDER BY V.VehiclesTimeStamp DESC";
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleDetails.sVehicleGUID      = objADODriver.FieldByName("VehicleGUID").Value; 
      eVehicleDetails.sMake             = aqString.ToUpper(objADODriver.FieldByName("MakeName").Value);
      eVehicleDetails.sColor            = aqString.ToUpper(objADODriver.FieldByName("ColorName").Value);
      eVehicleDetails.sVehiclePlate     = objADODriver.FieldByName("VehiclePlate").Value;
      eVehicleDetails.bVehicleOversized = objADODriver.FieldByName("VehicleOversized").Value;
      eVehicleDetails.iVehicleSize      = objADODriver.FieldByName("VehicleSize").Value;
      eVehicleDetails.bResult           = true; 

    }                                             
    
    return eVehicleDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getVehicleDetails Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getVehicleDetails

function verifyLostClaimDetailsByTicketNumber(sCustType,sTicketNumber){

/*------------------------------------------------------------------------------
  Function    : verifyLostClaimDetailsByTicketNumber
  Description : This function can be used to verify that the LostClaim is done 
                and values updated in required tables based on the given details
------------------------------------------------------------------------------*/

  bResult = false ;
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sCustType == "Daily") {
      //Query to verify the calim details of a Daily Customer
      sQuery =  "SELECT S.StayTicket, I.IncomeGUID, PIN.PaymentGUID, I.IncomeType"
                  +" FROM  Stays S, Income I, PaymentsIncome PIN, IncomeDetails ID"
                  +" WHERE S.IncomeGUID = I.IncomeGUID AND I.IncomeGUID = PIN.IncomeGUID"
                  +" AND   I.IncomeGUID = ID.IncomeGUID"
                  +" AND   S.StayTicket = '"+sTicketNumber +"' AND S.LostClaim = 1 AND S.StayType = 0"
                  +" AND   CONVERT(VARCHAR(10),S.StayDateOut,110) = CONVERT(VARCHAR(10),GETDATE(),110)"
                  +" AND   I.IncomeType = 'T'"
                  +" AND   ID.NonPaymentReasonGUID IS NULL";
    }
    else if(sCustType == "Monthly") {
      //Query to verify the calim details of a Monthly Customer
      sQuery =  "SELECT S.StayTicket, I.IncomeGUID, I.IncomeType"
                  +" FROM  Stays S, Income I, IncomeDetails ID"
                  +" WHERE S.IncomeGUID = I.IncomeGUID"
                  +" AND   I.IncomeGUID = ID.IncomeGUID"
                  +" AND   S.StayTicket = '"+sTicketNumber+"' AND S.StayType = 1"
                  +" AND   CONVERT(VARCHAR(10),S.StayDateOut,110) = CONVERT(VARCHAR(10),GETDATE(),110)"
                  +" AND   ID.IncomeDetailAmount = '0.00'"
                  +" AND   I.IncomeType = 'M'"
                  +" AND   ID.NonPaymentReasonGUID = (SELECT NonPaymentReasonGUID "
                           +" FROM NonPaymentReasonsCodes WHERE NonPaymentReasonDescription = 'Monthly')";
    } 
    else if(sCustType == "Replace") {
      //Query to verify the calim details of a Monthly Customer
      sQuery =  "SELECT S.StayTicket, I.IncomeGUID, I.IncomeType"
                  +" FROM  Stays S, Income I, IncomeDetails ID"
                  +" WHERE S.IncomeGUID = I.IncomeGUID"
                  +" AND   I.IncomeGUID = ID.IncomeGUID"
                  +" AND   S.StayTicket = '"+sTicketNumber+"'  AND S.StayType = 2"
                  +" AND   CONVERT(VARCHAR(10),S.StayDateOut,110) = CONVERT(VARCHAR(10),GETDATE(),110)"
                  +" AND   ID.IncomeDetailAmount = '0.00'"
                  +" AND   I.IncomeType = 'R'"
                  +" AND   ID.NonPaymentReasonGUID = (SELECT NonPaymentReasonGUID "
                           +" FROM NonPaymentReasonsCodes WHERE NonPaymentReasonDescription = 'Replacement')";
    }
    else if(sCustType == "NoCharge") {
      //Query to verify the calim details of a Daily Customer
      sQuery =  "SELECT S.StayTicket, I.IncomeGUID, I.IncomeType"
                  +" FROM  Stays S, Income I, IncomeDetails ID"
                  +" WHERE S.IncomeGUID = I.IncomeGUID "
                  +" AND   I.IncomeGUID = ID.IncomeGUID"
                  +" AND   S.StayTicket = '"+sTicketNumber +"' AND S.LostClaim = 1 AND S.StayType = 0"
                  +" AND   CONVERT(VARCHAR(10),S.StayDateOut,110) = CONVERT(VARCHAR(10),GETDATE(),110)"
                  +" AND   I.IncomeType = 'T'"
                  +" AND   ID.NonPaymentReasonGUID = (SELECT NonPaymentReasonGUID "
                            +" FROM NonPaymentReasonsCodes WHERE NonPaymentReasonDescription = 'No Charge')";
    }
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      bResult = true; 
    }                                             
    return bResult;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function verifyLostClaimDetailsByTicketNumber Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//verifyLostClaimDetailsByTicketNumber


function verifyLostClaimResultByTagNumber(objTestData){

/*------------------------------------------------------------------------------
  Function    : verifyLostClaimResultByTagNumber
  Description : This function can be used to get the VehicleTag Result after LostClaim
------------------------------------------------------------------------------*/

  bResult = true;
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    //Query to get the Tag number which is not currently in Check in Status
    sQuery =  "SELECT StayTicket FROM Stays S WHERE S.VehicleGUID  IN(" 
	              +" SELECT CV.VehicleGUID FROM MonthlyCustomers MC,CustomersTags CT, CustomerVehicles CV"
		            +" WHERE MC.CustomerGUID = CT.CustomerGUID"
		            +" AND CT.VehicleTagGUID = CV.VehicleTagGUID"
		            +" AND CustomerAccountNumber = '"+objTestData.sAccountNo+"' AND VehicleTagNumber = '"+objTestData.sVehicleTag+"')"
                +" AND StayDateOut IS NULL";
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF )
      bResult = true; 
                                               
    return bResult;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function verifyLostClaimResultByTagNumber Query")
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//verifyLostClaimResultByTagNumber

function insertAndReturnNewReservationBarcode(sReservation){

/*-----------------------------------------------------------------------------------------
  Function    : insertAndReturnNewReservationBarcode
  Description : This function can be used to Insert And Return A New Reservation Barcode
  
  Note - Few Values are hardcoded, Like PSProviderGUID
-----------------------------------------------------------------------------------------*/

 
  var iRowsAffected = 0;
  
  var objPRData = {
                    bRowsAffected        : false,
                    sPReservationBarcode : "SH"+Utility.getRandomValue("NUMERIC",7),
                    sFirstName           : "SpotHero",
                    sLastName            : "SpotHero" 
                  };
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    if(sReservation == null || sReservation == undefined){
      //Query to set the CustomerAccount Status = 0, soft deleted
      query = "Insert into ParkingReservations (PReservationGUID,LocationGUID,PReservationBarcode,PReservationEntryDate"
                +",PReservationExitDate,PReservationLastModified,PReservationFirstName,PReservationLastName"
                +",PReservationVehicleMake,PReservationVehicleColor,PReservationVehiclePlate,PReservationVehicleState"
                +",PReservationOtherData,PReservationTimestamp,PReservationStatus,PReservationNumberOfUses"
                +",PReservationEventName,PReservationEventStartDate,PReservationEventEndDate,PReservationPermitValue"
                +",PSProviderGUID,PReservationCalculationMethod,PReservationLotId)"
	              +" Values(NEWID(),'507F1404-F363-431E-83AF-0A95D7D7D81F'"
                +",'"+objPRData.sPReservationBarcode+"',CONVERT(VARCHAR(24),GETDATE(),121)"
                +",DATEADD(hh,6,CONVERT(VARCHAR(24),GETDATE(),121)),CONVERT(VARCHAR(24),GETDATE(),121),'SpotHero','SpotHero','','','',"
                +"null,null,CONVERT(VARCHAR(24),GETDATE(),121),0,null,'SpotHero',null,null,13.00,'66537CFA-5CD3-45FB-A8AB-5F48B3378466',2,'')";
    }
    else{
      //Query to set the CustomerAccount Status = 0, soft deleted
      query = "Insert into ParkingReservations (PReservationGUID,LocationGUID,PReservationBarcode,PReservationEntryDate"
                +",PReservationExitDate,PReservationLastModified,PReservationFirstName,PReservationLastName"
                +",PReservationVehicleMake,PReservationVehicleColor,PReservationVehiclePlate,PReservationVehicleState"
                +",PReservationOtherData,PReservationTimestamp,PReservationStatus,PReservationNumberOfUses"
                +",PReservationEventName,PReservationEventStartDate,PReservationEventEndDate,PReservationPermitValue"
                +",PSProviderGUID,PReservationCalculationMethod,PReservationLotId)"
	              +" Values(NEWID(),'507F1404-F363-431E-83AF-0A95D7D7D81F'"
                +",'"+objPRData.sPReservationBarcode+"',DATEADD(dd,-2,CONVERT(VARCHAR(24),GETDATE(),121))"
                +",DATEADD(hh,-42,CONVERT(VARCHAR(24),GETDATE(),121)),DATEADD(dd,-2,CONVERT(VARCHAR(24),GETDATE(),121)),'SpotHero','SpotHero','','','',"
                +"null,null,DATEADD(dd,-2,CONVERT(VARCHAR(24),GETDATE(),121)),0,null,'SpotHero',null,null,13.00,'66537CFA-5CD3-45FB-A8AB-5F48B3378466',2,'')";
    }
    iRowsAffected = DBConnection.ExecuteNonQuery(query);
    
    if(iRowsAffected >= 1) 
      objPRData.bRowsAffected = true;                                           
    
    return objPRData;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function insertAndReturnNewReservationBarcode Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//insertAndReturnNewReservationBarcode


function verifyDailyWithReservation(sBarcode){

/*-----------------------------------------------------------------------------------------------
  Function    : verifyDailyWithReservation
  Description : This function can be used to verify that the Daily CheckIn is done 
                with Reservation and values updated in required tables based on the given details
-----------------------------------------------------------------------------------------------*/

  sStayTicket = null;
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    //Query to verify the calim details of a Daily Customer
    sQuery =  "SELECT S.StayTicket, S.StayDateIn, PRS.PReservationGUID"
                +" FROM  Stays S, ParkingReservationsStays PRS"
                +" WHERE S.StayGUID = PRS.StayGUID AND PRS.PReservationGUID = ("
                +" SELECT PReservationGUID FROM ParkingReservations WHERE PReservationBarcode = '"+sBarcode+"')";   
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF )
      sStayTicket   = objADODriver.FieldByName("StayTicket").Value;
                                               
    return sStayTicket;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function verifyDailyWithReservation Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//verifyDailyWithReservation

function verifyDailyWithPrepayment(objTestData){

/*-----------------------------------------------------------------------------------------------
  Function    : verifyDailyWithPrepayment
  Description : This function can be used to verify that the Daily CheckIn is done 
                with Prepayment and values updated in required tables based on the given details
-----------------------------------------------------------------------------------------------*/

  sStayTicket = null;
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    //Query to verify the calim details of a Daily Customer
    sQuery =  "SELECT TOP 1 S.StayTicket, S.StayDateIn, S.IncomeGUID FROM  Stays S, Income I"
                +" WHERE S.StayDateOut IS NULL AND S.IncomeGUID = I.IncomeGUID"
                +" AND I.IncomeAmount = CAST("+objTestData.sPrepayAmount+" AS MONEY) AND S.IncomeGUID IS NOT NULL ORDER BY S.StayDateIn DESC";   
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF )
      sStayTicket   = objADODriver.FieldByName("StayTicket").Value;
                                               
    return sStayTicket;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function verifyDailyWithPrepayment Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//verifyDailyWithPrepayment


function getReservationBarcode(sBarcodeStatus){

/*---------------------------------------------------------------------------------------------------
  Function    : getReservationBarcode
  Description : This function can be used to get reservation barcode based on requierd barcode status
---------------------------------------------------------------------------------------------------*/

  sPReservationBarcode = null;
  
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
 
    if(sBarcodeStatus == "Used")   
      //Query to verify the barcode status of a Daily Customer
      sQuery =  "SELECT PReservationBarcode FROM ParkingReservations WHERE PReservationGUID IN("
                  +" SELECT PReservationGUID FROM ParkingReservationsStays)" 
                  +" AND PReservationStatus = 0"; 
    else if(sBarcodeStatus == "Cancelled")   
      //Query to verify the barcode status of a Daily Customer
      sQuery =  "SELECT PReservationBarcode FROM ParkingReservations WHERE PReservationStatus = 1";
    else 
      //Query to verify the barcode status of a Daily Customer
      sQuery =  "SELECT PReservationBarcode FROM ParkingReservations WHERE PReservationGUID NOT IN("
                  +" SELECT PReservationGUID FROM ParkingReservationsStays)" 
                  +" AND PReservationStatus = 0 AND PReservationExitDate > GETDATE()"; 
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF )
      sPReservationBarcode   = objADODriver.FieldByName("PReservationBarcode").Value;
                                               
    return sPReservationBarcode;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function verifyDailyWithReservation Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//verifyDailyWithReservationfunction 


function updateReservationBarcodeStatus(bBarcodeStatus,sBarcode){

/*-----------------------------------------------------------------------------------------
  Function    : updateReservationBarcodeStatus
  Description : This function can be used to Update the Resrvation status of the given Barcode
-----------------------------------------------------------------------------------------*/

  var iRowsAffected = 0;
  var bRowsAffected = false;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(sBarcode == null) {
    
      //Query to set the Reservation Status = 0, Active
      query = "UPDATE ParkingReservations SET "
                  +" PReservationStatus = "+bBarcodeStatus+" WHERE PReservationBarcode IN ("
                  +" SELECT TOP 1 PReservationBarcode FROM ParkingReservations ORDER BY NEWID())";
    }           
    else { 
      //Query to set the Reservation Status = 1, Cancelled
      query = "UPDATE ParkingReservations SET "
                  +" PReservationStatus = "+bBarcodeStatus+" WHERE PReservationBarcode = '"+sBarcode+"'";
    }  
    iRowsAffected = DBConnection.ExecuteNonQuery(query);
    
    if(iRowsAffected >= 1) 
      bRowsAffected = true;                                           
    
    return bRowsAffected;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function updateReservationBarcodeStatus Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//updateReservationBarcodeStatus

function getCheckOutTicketDetails(sCustomerType){

/*-------------------------------------------------------------------------------------------------------------
  Function    : getCheckOutTicketDetails
  Description : This function can be used to get the Ticket details of a checkOut vehicle based on Customer Type
-------------------------------------------------------------------------------------------------------------*/

  //stores the Check Out Vehicle Details
  var eCheckOutVehicleDetails =   { 
                                   sStayGUID : null, sTicketNumber : null, sStayDateIn : null, sStayDateOut : null,
                                   sVehicleGUID : null, iDamageIdentifiaction : 0, iStayType : 0, sCustomerGUID: null,
                                   bResult : false
                                 };
  var objADODriver;
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    Delay(1000);
    
    if(sCustomerType === "Daily"){
      //Query to get the Check out Vehicle Details of a Daily Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NOT NULL AND StayType = 0";
    }
    else if(sCustomerType === "Monthly"){
      //Query to get the Check out Vehicle Details of a Monthly Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NOT NULL AND StayType = 1";
    }
    else if(sCustomerType === "Replace"){
      //Query to get the Check out Vehicle Details of a Replace Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NOT NULL AND StayType = 2";
    }
    else {
      //Query to get the Check out Vehicle Details of a Daily Cutomer
      sQuery =  "SELECT TOP 1 StayGUID, StayTicket ,StayDateIn, StayDateOut, VehicleGUID,"
                   +" DamageIdentification, CustomerGUID, StayType  FROM Stays"
                   +" WHERE StayDateOut IS NOT NULL AND StayType = 0";
    }

    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning retrieved values to enum
    if(!objADODriver.EOF ){
      eCheckOutVehicleDetails.sStayGUID     = objADODriver.FieldByName("StayGUID").Value; 
      eCheckOutVehicleDetails.sTicketNumber = objADODriver.FieldByName("StayTicket").Value;
      eCheckOutVehicleDetails.sStayDateIn   = objADODriver.FieldByName("StayDateIn").Value;
      eCheckOutVehicleDetails.sStayDateOut  = objADODriver.FieldByName("StayDateOut").Value;
      eCheckOutVehicleDetails.sCustomerGUID = objADODriver.FieldByName("CustomerGUID").Value;
      eCheckOutVehicleDetails.iDamageIdentifiaction = objADODriver.FieldByName("DamageIdentification").Value;
      eCheckOutVehicleDetails.iStayType     = objADODriver.FieldByName("StayType").Value;
      eCheckOutVehicleDetails.bResult       = true; 
    }                                             
    
     return eCheckOutVehicleDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function eCheckOutVehicleDetails Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//eCheckOutVehicleDetails

//function getLastAddedReplaceDetails(sTagNumber){
//
///*------------------------------------------------------------------------------
//  Function    : getLastAddedReplaceDetails
//  Description : This function can be used to get Last Added Replace Details
//------------------------------------------------------------------------------*/
//
//  var eVehicleTagDetails = { sVehicleTag: sTagNumber, bResult : false };
//  var objADODriver;
//  
//  try {
//    //Creating new DB Connection
//    var DBConnection = DBUtility.New();
//    
//    Delay(1000);
//    
//    if(sTagNumber !==null && sTagNumber !== undefined) {
//      //Query to get the given Tag number which is  currently in Check in Status
//      sQuery =  "SELECT CT.VehicleTagNumber FROM CustomersTags CT, CustomerVehicles CV"
//				          +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID IN ("
//					        +" SELECT S.VehicleGUID FROM Stays S WHERE S.StayType = 2 AND S.StayDateOut IS NULL"
//                  +" AND S.StayDateIn BETWEEN DATEADD(mi,-3,GETDATE()) AND DATEADD(mi,+1,GETDATE()))"
//	                +" AND CT.VehicleTagNumber = '"+sTagNumber+"'";
//    }
//    else {
//      //Query to get the given Tag number which is  currently in Check in Status
//      sQuery =  "SELECT CT.VehicleTagNumber FROM CustomersTags CT, CustomerVehicles CV"
//				          +" WHERE CT.VehicleTagGUID = CV.VehicleTagGUID AND CV.VehicleGUID IN ("
//					        +" SELECT TOP 1 S.VehicleGUID FROM Stays S WHERE S.StayType IN (1,2) AND S.StayDateOut IS NULL"
//                  +" ORDER BY S.StayDateIn DESC)";
//    } 
//                  
//    objADODriver = DBConnection.ExecuteQuery(sQuery);
//    
//    objADODriver.First();
//    
//    //Verifying the no of rows retrieved > 0, Assigning true
//    if(!objADODriver.EOF ){
//      eVehicleTagDetails.sVehicleTag = objADODriver.FieldByName("VehicleTagNumber").Value;
//      eVehicleTagDetails.bResult     = true; 
//    }                                             
//    return eVehicleTagDetails;
//  }//End try
//  
//  catch (exception){
//    TestLog.Message("Error in function getLastAddedReplaceDetails Query");
//  }//End catch
//  
//  finally {
//    //Closing DB Connection  
//    DBConnection.close();
//  }//End finally
//   
//}//getLastAddedReplaceDetails
      
function getRandomVehicleColor(){

/*------------------------------------------------------------------------------
  Function    : getRandomVehicleColor
  Description : This function can be used to get Random Vehicle Color
------------------------------------------------------------------------------*/

  var eVehicleColorDetails = { sColor: null, sVehicleColorGUID: null, bResult : false };
  var objADODriver;
  
  getColors = XMLReader.getXMLDataAttribute("//Colors/Relations","Id");
  
  eVehicleColorDetails.sVehicleColorGUID = aqString.ToUpper(Utility.getRandomString(getColors));
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(eVehicleColorDetails.sVehicleColorGUID !==null && eVehicleColorDetails.sVehicleColorGUID !== undefined) {
      //Query to get VehicleColor
      sQuery =  "SELECT ColorName FROM Colors WHERE ColorGUID = '"+eVehicleColorDetails.sVehicleColorGUID+"'";
    }
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleColorDetails.sColor      = aqString.ToUpper(objADODriver.FieldByName("ColorName").Value);
      eVehicleColorDetails.bResult     = true; 
    }                                             
    return eVehicleColorDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getRandomVehicleColor Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getRandomVehicleColor

function getRandomVehicleMake(){

/*------------------------------------------------------------------------------
  Function    : getRandomVehicleColor
  Description : This function can be used to get Random Vehicle Color
------------------------------------------------------------------------------*/

  var eVehicleMakeDetails = { sVehicleMake: null, sVehicleMakeGUID: null, bResult : false };
  var objADODriver;
  
  getMakes = XMLReader.getXMLDataAttribute("//Makes/Relations","Id");
  
  eVehicleMakeDetails.sVehicleMakeGUID = aqString.ToUpper(Utility.getRandomString(getMakes));
  
  try {
    //Creating new DB Connection
    var DBConnection = DBUtility.New();
    
    if(eVehicleMakeDetails.sVehicleMakeGUID !==null && eVehicleMakeDetails.sVehicleMakeGUID !== undefined) {
      //Query to get VehicleColor
      sQuery =  "SELECT MakeName FROM Makes WHERE MakeGUID = '"+eVehicleMakeDetails.sVehicleMakeGUID+"'";
    }
                  
    objADODriver = DBConnection.ExecuteQuery(sQuery);
    
    objADODriver.First();
    
    //Verifying the no of rows retrieved > 0, Assigning true
    if(!objADODriver.EOF ){
      eVehicleMakeDetails.sVehicleMake = objADODriver.FieldByName("MakeName").Value;
      eVehicleMakeDetails.bResult      = true; 
    }                                             
    return eVehicleMakeDetails;
  }//End try
  
  catch (exception){
    TestLog.Message("Error in function getRandomVehicleMake Query");
  }//End catch
  
  finally {
    //Closing DB Connection  
    DBConnection.close();
  }//End finally
   
}//getRandomVehicleMake












