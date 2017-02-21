//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT MainDialog
//USEUNIT EmployeeInfoForm
//USEUNIT EmployeeCodeForm
//USEUNIT ConfirmActionForm
//USEUNIT EmployeePunchForm


function TC_POUT_EMP_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_001 : Verify Employee is able to punch out successfully by giving valid credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  var objEmployeePunchForm; //Stores the instance of Employee Punch Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  if(eEmpLastPunchDetails.bPunchInOutStatus == 0)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,1,eEmpLastPunchDetails.sLastPunchDateTime);
  
  var eEmpCurrentPunchDetails;//stores the latest punch Out Details of the Employee after Test case execution
    
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into EmployeeInfo Form and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();    
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
    //Step-3: Navigate into EmployeeCode Form and submit valid code
    //-------------------------------------------------------------
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid code.");
      
    //Step-4: Navigate into Employee punch screen and click Enter button
    //--------------------------------------------------------------------
    objEmployeePunchForm = EmployeePunchForm.New();
      
    //Click Enter button from Navigation panel
    objEmployeePunchForm.SubmitForm();
    if (objEmployeePunchForm.lastError.name !== undefined) throw objEmployeePunchForm.lastError;
    
    TestLog.Message("Step-4: Navigated to Employee Punch screen and Clicked Enter.");
      
    //TestCase Result : verify the last punch details with the latest punch detail, punch detail change indicates the test case is passed
    eEmpCurrentPunchDetails =  SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
    sLastPunchDate = eEmpLastPunchDetails.sLastPunchDateTime;
    sCurrPunchDate = eEmpCurrentPunchDetails.sLastPunchDateTime;
    
    bTestCaseResult = ((eEmpCurrentPunchDetails.bPunchInOutStatus == 0 )&& (sLastPunchDate != sCurrPunchDate));
    sPassMessage    = "TestCase Passed. The Employee "+objTestData.EmployeeID+" PunchOut Successfully";
    sFailMessage    = "TestCase Failed. The Employee "+objTestData.EmployeeID+" PunchOut Failed";
    
    TestLog.Message("EmployeeID: " +objTestData.EmployeeID+ "'s Current Punch Status " +eEmpCurrentPunchDetails.bPunchInOutStatus+ " and Current Punch DateTime: "+sCurrPunchDate);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                                             
  } //End try
        
  catch(exception) {
    //Sys.Process("PosApplication").FindChild("WinFormsControlName", "Form*", 1).Picture();
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
  objEmployeeCodeForm = null;
  objEmployeePunchForm = null;
//
}


function TC_POUT_EMP_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_002 : Validating PunchOut by providing invalid empID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result  
  var sExpectedErrorMessage = "EMPLOYEE NOT FOUND."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed
  
  var objTestData = {EmployeeID : null};
  
  var sDeletedEmployee = SQLQueries.getDeletedEmployee();//get a deleted employee from DB - Invalid
  
  //if no deleted employee available in DB - generate a random EmployeeID
  if (sDeletedEmployee.sEmployeeId != null) 
    objTestData.EmployeeID = sDeletedEmployee.sEmployeeId;
  else
    objTestData.EmployeeID = Utility.getRandomValue("ALPHANUMERIC",6);  
  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
   //Step-2: Navigate into Employee info screen and submit invalid emp ID
   //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage = objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted invalid emp id");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. The error message is displayed as expected for invalid employee ID";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for the invalid employee ID";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                                             
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;

}


function TC_POUT_EMP_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_003 : Validating PunchOut by providing empty Employee ID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Screen

  var bTestCaseResult;//Boolean variable to store TestCase result  
  var sExpectedErrorMessage = "EMPLOYEE ID CANNOT BE EMPTY."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed    
  
  var objTestData = {EmployeeID : ""}; //Blank Employee ID  
    
  try {                  
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit empty emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage=objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted empty emp id.");
       
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. The error message is displayed as expected for empty/blank employee ID";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for empty/blank employee ID";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                                             
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
}


function TC_POUT_EMP_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_004 : Validating PunchOut by providing invalid code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  var sExpectedErrorMessage = "TEMPLATE ENTERED NOT MATCH."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed    
  
  var objTestData = {
                      EmployeeID   :  SQLQueries.getValidEmployeeID(),
                      EmployeeCode :  Utility.getRandomValue("ALPHANUMERIC",4)                                          
                    }; //TestData object to punch out an employee
  
  try {          
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch Out button.");
    
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
    //Step-3: Navigate into Employee code screen and submit invalid code
    //--------------------------------------------------------------------
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    sActualErrorMessage=objEmployeeCodeForm.InputAndSubmitFormWithErrors(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to Employee Code screen and submitted invalid code.");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. Expected error message displayed for PunchOut with Invalid Employee Code";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for the Invalid Employee Code";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);         
     
       } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess(); 
      Log.PopLogFolder();
    } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
  objEmployeeCodeForm = null;
}


function TC_POUT_EMP_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_005 : Verify Transaction time out during PunchOut an employee after entering details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  var objEmployeePunchForm; //Stores the instance of Employee Punch Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  var sExpectedErrorMessage = "PUNCH TRANSACTION HAS TIMED OUT. PLEASE, TRY AGAIN."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed    

  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  if(eEmpLastPunchDetails.bPunchInOutStatus == 0)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,1,eEmpLastPunchDetails.sLastPunchDateTime);
  
  var eEmpCurrentPunchDetails;//stores the latest punch Out Details of the Employee after Test case execution
  
  try {                 
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
    //Step-3: Navigate into Employee code screen and submit valid code
    //----------------------------------------------------------------- 
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid code.");
      
    //Step-4: Navigate into Employee punch screen and click Enter button after 3 minutes
    //------------------------------------------------------------------------------------
    objEmployeePunchForm = EmployeePunchForm.New();
      
    //Delay the script for 3 minutes for the transaction to get timed out
    Delay(180000);
      
    //Click Enter button from Navigation panel
    objEmployeePunchForm.SubmitForm();
    if (objEmployeePunchForm.lastError.name !== undefined) throw objEmployeePunchForm.lastError;
    
    TestLog.Message("Step-4 :Navigated into Employee punch screen and clicked Enter button after 3 minutes");
      
    //Step-5: Navigate into MainDialog and check the error message
    //-----------------------------------------------------------------
    objMainDialog = MainDialog.New();
    eMainDialogDetails = objMainDialog.GetFormInfo();

    sActualErrorMessage = eMainDialogDetails.Message;
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-5 :Error Message: "+eMainDialogDetails.Message);  
    
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. Expected error message displayed for Punch Transaction TimeOut";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for Punch Transaction TimeOut";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);         
  } //End try 
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application 
    Log.PopLogFolder();    
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
  objEmployeeCodeForm = null;
  objEmployeePunchForm = null;
}


function TC_POUT_EMP_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_006 : Verify Transaction timed out for punch out an employee before entering details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var bTestCaseResult; //Boolean variable to store TestCase result
  var sExpectedErrorMessage = "PUNCH TRANSACTION HAS TIMED OUT. PLEASE, TRY AGAIN."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
    
    //Delay the script for 3 minutes for the transaction to get timed out
    Delay(180000);
      
    //Click Enter button from Navigation panel
    objEmployeeInfoForm.SubmitForm();
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
    
    TestLog.Message("Step-4 :Clicked Enter Button");
      
    //Step-3: Navigate into MainDialog and check the error message
    //------------------------------------------------------------
    objMainDialog = MainDialog.New();
    eMainDialogDetails = objMainDialog.GetFormInfo();

    sActualErrorMessage = eMainDialogDetails.Message;
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-5 :Error Message: "+eMainDialogDetails.Message);  
    
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. Expected error message displayed for Punch Transaction TimeOut";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for Punch Transaction TimeOut";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);         
  } //End try 
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application 
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
}


function TC_POUT_EMP_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_007 : Verify that employee is able to do duplicate punch out
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Screen
  var objEmployeePunchForm; //Stores the instance of Employee Punch Form
  var objConfirmActionForm; //Stores the instance of ConfirmAction Form
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime,1);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch Out Details of the Employee after Test case execution
 
  try {
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //Step-3: Navigate to confirm Action screen and click yes button
    //-----------------------------------------------------------------
    confirmAction = ConfirmActionForm.New();
    TestLog.Message("Step-3 : Navigated to ConfirmAction Form");
      
    //Click Yes button from YesNoConfirmAction panel
    confirmAction.ConfirmYes();
    if (confirmAction.lastError.name !== undefined) throw confirmAction.lastError;
    
    TestLog.Message("Step-4 :Clicked Yes Button in confirm action form");
     
    //Step-3: Navigate into Employee code screen and submit valid code
    //--------------------------------------------------------------------
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid code.");
         
    //Step-4: Navigate into Employee punch screen and click Enter button
    //------------------------------------------------------------------
    objEmployeePunchForm = EmployeePunchForm.New();
      
    //Click Enter button from Navigation panel
    objEmployeePunchForm.SubmitForm();
    if (objEmployeePunchForm.lastError.name !== undefined) throw objEmployeePunchForm.lastError;
      
    TestLog.Message("Step-6: Navigated to Employee Punch screen and Clicked Enter.");
      
    //TestCase Result : verify the last punch details with the latest punch detail, punch detail change indicates the test case is passed
    eEmpCurrentPunchDetails =  SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
    sLastPunchDate = eEmpLastPunchDetails.sLastPunchDateTime;
    sCurrPunchDate = eEmpCurrentPunchDetails.sLastPunchDateTime;
    
    bTestCaseResult = ((eEmpCurrentPunchDetails.bPunchInOutStatus == 0 )&& (sLastPunchDate != sCurrPunchDate));
    sPassMessage    = "TestCase Passed. The Employee "+objTestData.EmployeeID+" can do duplicate PunchOut";
    sFailMessage    = "TestCase Failed. Duplicate PunchOut had unexpeceted behaviour";
    
    TestLog.Message("EmployeeID: " +objTestData.EmployeeID+ "'s Current Punch Status " +eEmpCurrentPunchDetails.bPunchInOutStatus+ " and Current Punch DateTime: "+sCurrPunchDate);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                                       
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
  objEmployeeCodeForm = null;
  objEmployeePunchForm = null;
  objConfirmActionForm = null;
}


function TC_POUT_EMP_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_008 : Verify that employee gets back to the previous screen when 'No' button is clicked
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  var objConfirmActionForm; //Stores the instance of ConfirmAction Form
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime,1);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch Out Details of the Employee after Test case execution
  
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //Step-3: Navigate to confirm Action screen and click No button
    //-------------------------------------------------------------
    objConfirmActionForm = ConfirmActionForm.New();
    TestLog.Message("Step-3 : Navigated to ConfirmAction Form");
     
    //Click No button from YesNoConfirmAction panel
    objConfirmActionForm.ConfirmNo();
    if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError;
    TestLog.Message("Step-4 :Clicked No Button in Confirm Action screen");
        
    //TestCase Result : verify the last punch details with the latest punch detail, punch detail indicates the test case is passed
    eEmpCurrentPunchDetails =  SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
    sLastPunchDate = eEmpLastPunchDetails.sLastPunchDateTime;
    sCurrPunchDate = eEmpCurrentPunchDetails.sLastPunchDateTime;
    
    bTestCaseResult = (sLastPunchDate === sCurrPunchDate);
    sPassMessage    = "TestCase Passed. The Employee Duplicate PunchOut Terminated successfully by clicking No";
    sFailMessage    = "TestCase Failed. The Employee Duplicate PunchOut Termination had unexpected behaviour";
    
    TestLog.Message("EmployeeID: " +objTestData.EmployeeID+ "'s Last Punch DateTime: "+sCurrPunchDate);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);     
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
  objEmployeeCodeForm = null;
  objConfirmActionForm = null;
}

function TC_POUT_EMP_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_009 : Verify the PunchOut of an employee who has already punched out but tries to punch out again within an hour
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var sExpectedErrorMessage = "YOU ARE ALREADY PUNCHED OUT AT"; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed  
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime,0);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch Out Details of the Employee after Test case execution
 
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage=objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (aqString.Find(sActualErrorMessage,sExpectedErrorMessage)!=-1);
    sPassMessage    = "TestCase Passed. Expected error message is displayed for already PunchOut employee";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for already PunchOut employee";
    
    TestLog.Message("Error Message: "+sActualErrorMessage);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                                        
  } //End try
     
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application 
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
}


function TC_POUT_EMP_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_010 : Verify the PunchOut of an employee who has already punched In a day ago  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var sExpectedErrorMessage = "YOU MISSED OUT THE PUNCH OUT TIME. PUNCH OUT CANCELLED. PREVIOUS PUNCH IN AT";//Stores the expected error message 
  var sActualErrorMessage; //Stores the error message to be dispalyed    
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,1,eEmpLastPunchDetails.sLastPunchDateTime,24);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch Out Details of the Employee after Test case execution
    
  try {
    
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchOutScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-1: Clicked Punch Out button.");
      
    //Initialize object of EmployeeInfoForm
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage = objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id");
        
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (aqString.Find(sActualErrorMessage,sExpectedErrorMessage)!=-1);
    sPassMessage    = "TestCase Passed. Expected error message is displayed for Cancelled PunchOut";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for Cancelled PunchOut";
    
    TestLog.Message("Error Message: "+sActualErrorMessage);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage); 
                                             
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
}