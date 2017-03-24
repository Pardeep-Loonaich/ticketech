//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT MainDialog
//USEUNIT EmployeeInfoForm
//USEUNIT EmployeeCodeForm
//USEUNIT EmployeePunchForm
//USEUNIT ConfirmActionForm
//USEUNIT FingerPrintForm


function TC_PIN_EMP_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_001 : Verify Employee can able to successfully PunchIn by giving valid credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  var objEmployeePunchForm; //Stores the instance of Employee Punch Form
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  if(eEmpLastPunchDetails.bPunchInOutStatus == 1)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime);
  
  var eEmpCurrentPunchDetails;//stores the latest punch In Details of the Employee after Test case execution
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
    //Initialize object of EmployeeCodeForm
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Step-3: Set data in Employee Code field and click Enter button from Navigation panel
    //------------------------------------------------------------------------------------
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid emp code.");
      
    //Initialize object of EmployeePunchForm
    objEmployeePunchForm = EmployeePunchForm.New();
      
    //Step-4: Click Enter button from Navigation panel
    //------------------------------------------------
    objEmployeePunchForm.SubmitForm();
    if (objEmployeePunchForm.lastError.name !== undefined) throw objEmployeePunchForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Employee Punch screen and Clicked Enter.");
    
    //TestCase Result : verify the last punch details with the latest punch detail, punch detail change indicates the test case is passed
    eEmpCurrentPunchDetails =  SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
    sLastPunchDate = eEmpLastPunchDetails.sLastPunchDateTime;
    sCurrPunchDate = eEmpCurrentPunchDetails.sLastPunchDateTime;
    
    bTestCaseResult = ((eEmpCurrentPunchDetails.bPunchInOutStatus == 1 )&& (sLastPunchDate != sCurrPunchDate));
    sPassMessage    = "TestCase Passed. The Employee "+objTestData.EmployeeID+" PunchIn Successfully";
    sFailMessage    = "TestCase Failed. The Employee "+objTestData.EmployeeID+" PunchIn Failed";
    
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
}

function TC_PIN_EMP_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_002 : Verify that a proper error message is displayed when empty/blank employee ID is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var sExpectedErrorMessage = "EMPLOYEE ID CANNOT BE EMPTY."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed    
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  var objTestData = {EmployeeID : ""}; //Blank Employee ID
  
  try {
      
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit blank emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage = objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted blank emp id.");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. The error message is displayed as expected for blank employee ID";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for the blank employee ID";
    
    TestLog.Message("Error Message: "+sActualErrorMessage);
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

function TC_PIN_EMP_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_003 : Verify that a proper error message is displayed when Invalid employee ID is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var sExpectedErrorMessage = "EMPLOYEE NOT FOUND."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed
  var bTestCaseResult; //Boolean variable to store TestCase result
  
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
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage = objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted invalid emp id.");
           
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage);
    sPassMessage    = "TestCase Passed. The error message is displayed as expected for invalid employee ID";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for the invalid employee ID";
    
    TestLog.Message("Error Message: "+sActualErrorMessage);
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

function TC_PIN_EMP_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_004 : Verify that a proper error message is displayed when invalid code is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  
  var sExpectedErrorMessage = "TEMPLATE ENTERED NOT MATCH."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed   
  var bTestCaseResult; //Boolean variable to store TestCase result 
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = Utility.getRandomValue("ALPHANUMERIC",4);

  //Update Last punch Details of the Employee
  if(eEmpLastPunchDetails.bPunchInOutStatus == 1)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime);
   
  try {
 
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //Initialize object of EmployeeCodeForm 
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Step-3: Set invalid Employee code and click Enter button from Navigation panel
    //------------------------------------------------------------------------------
    sActualErrorMessage = objEmployeeCodeForm.InputAndSubmitFormWithErrors(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to EmployeeCode Form and submitted invalid emp code.");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = sActualErrorMessage === sExpectedErrorMessage;
    sPassMessage    = "TestCase Passed. Expected error message displayed for PunchIn with Invalid Employee Code";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for the Invalid Employee Code";
    
    TestLog.Message("Error Message: "+sActualErrorMessage);
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

function TC_PIN_EMP_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_005 : Verify that a proper error message is displayed when empty/blank code is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  
  var sExpectedErrorMessage = "CODE ENTERED NOT VALID."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed   
  var bTestCaseResult; //Boolean variable to store TestCase result 
      
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = "";

  //Update Last punch Details of the Employee
  if(eEmpLastPunchDetails.bPunchInOutStatus == 1)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime);
   
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //Initialize object of EmployeeCodeForm 
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set blank Employee code and click Enter button from Navigation panel
    sActualErrorMessage = objEmployeeCodeForm.InputAndSubmitFormWithErrors(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to EmployeeCode Form and submitted blank emp code.");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = sActualErrorMessage === sExpectedErrorMessage;
    sPassMessage    = "TestCase Passed. Expected error message displayed for PunchIn with Blank/Empty Employee Code";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for the Blank/Empty Employee Code";
    
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
  objEmployeeCodeForm = null;
}

function TC_PIN_EMP_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_006 : Verify Transaction timed out for punch in an employee after entering details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  var objEmployeePunchForm; //Stores the instance of Employee Punch Form
  
  var sExpectedErrorMessage = "PUNCH TRANSACTION HAS TIMED OUT. PLEASE, TRY AGAIN."; //Stores the expected error message    
  var sActualErrorMessage; //Stores the error message to be dispalyed  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Employee whose punch Details are available in Punches Table
  var eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee();
 
  //Declaring and initializing Test Data object 
  var objTestData = { EmployeeID : eEmpLastPunchDetails.sEmployeeID, EmployeeCode : null }; 

  //setting EmployeeID as EmployeeCode after updating via SQL in DB
  if(SQLQueries.updateEmployeeCode(objTestData.EmployeeID))
   objTestData.EmployeeCode = objTestData.EmployeeID;

  //Update Last punch Details of the Employee
  if(eEmpLastPunchDetails.bPunchInOutStatus == 1)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime);
  
  var eEmpCurrentPunchDetails;//stores the latest punch In Details of the Employee after Test case execution  
  
  try {
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoScreen 
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
    
    //Delaying the Script for 3 minutes, to get the transaction timeout error
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
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for Transaction TimeOut";
    
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

function TC_PIN_EMP_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_007 : Verify that employee is able to do duplicate punch in
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
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
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,1,eEmpLastPunchDetails.sLastPunchDateTime,1);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch In Details of the Employee after Test case execution
  
  try {
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //Step-3: Navigate to confirm Action screen and click yes button
    //---------------------------------------------------------------
    objConfirmActionForm = ConfirmActionForm.New();
    TestLog.Message("Step-3 : Navigated to ConfirmAction Form");
     
    //Click Yes button from YesNoConfirmAction panel
    objConfirmActionForm.ConfirmYes();
    if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError;
    TestLog.Message("Step-4 :Clicked Yes Button");
     
    //Step-3: Navigate into Employee code screen and submit valid code
    //--------------------------------------------------------------------
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-5: Navigated to Employee Code screen and submitted valid code.");
      
    //Initialize object of EmployeePunchForm
    objEmployeePunchForm = EmployeePunchForm.New();
      
    //Click Enter button from Navigation panel
    objEmployeePunchForm.SubmitForm();
    if (objEmployeePunchForm.lastError.name !== undefined) throw objEmployeePunchForm.lastError;
      
    TestLog.Message("Step-6: Navigated to Employee Punch screen and Clicked Enter.");
      
    //TestCase Result : verify the last punch details with the latest punch detail, punch detail change indicates the test case is passed
    eEmpCurrentPunchDetails =  SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
    sLastPunchDate = eEmpLastPunchDetails.sLastPunchDateTime;
    sCurrPunchDate = eEmpCurrentPunchDetails.sLastPunchDateTime;
    
    bTestCaseResult = ((eEmpCurrentPunchDetails.bPunchInOutStatus == 1 )&& (sLastPunchDate != sCurrPunchDate));
    sPassMessage    = "TestCase Passed. The Employee "+objTestData.EmployeeID+" can do duplicate PunchIn Successfully";
    sFailMessage    = "TestCase Failed. The Employee "+objTestData.EmployeeID+" duplicate PunchIn Failed";
    
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

function TC_PIN_EMP_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_008 : Verify the PunchIn of an employee who has already punched in and tries to punch In again within an hour   
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/ 
  
  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form
  
  var sExpectedErrorMessage = "YOU ARE ALREADY PUNCHED IN AT"; //Stores the expected error message    
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
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,1,eEmpLastPunchDetails.sLastPunchDateTime,0);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch In Details of the Employee after Test case execution
 
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage=objEmployeeInfoForm.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //TestCase Result : verify the Actual Error Message respective to expected error message
    bTestCaseResult = (aqString.Find(sActualErrorMessage,sExpectedErrorMessage)!=-1);
    sPassMessage    = "TestCase Passed. Expected error message is displayed for already PunchIn employee";
    sFailMessage    = "TestCase Failed. Unexpected/No error message is displayed for already PunchIn employee";
    
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

function TC_PIN_EMP_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TC_PIN_EMP_009 : Verify Transaction timed out message after clicking PunchIn, not proving any detail for 3 minutes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of Employee Info Form

  var sExpectedErrorMessage = "PUNCH TRANSACTION HAS TIMED OUT. PLEASE, TRY AGAIN.";
  var sActualErrorMessage; //Stores the error message to be dispalyed
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  try {
                         
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit invalid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
    
    //Delaying the script for 3 minutes without further interaction
    Delay(180000);
      
    //Click Enter button from Navigation panel
    objEmployeeInfoForm.SubmitForm();
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;

    TestLog.Message("Step-2 :Clicked Enter Button");
      
    //Step-3: Navigate into MainDialog and check the error message
    //-----------------------------------------------------------------
    objMainDialog = MainDialog.New();
    eMainDialogDetails = objMainDialog.GetFormInfo();
      
    sActualErrorMessage = eMainDialogDetails.Message;
      
    TestLog.Message("Step-3 :Error Message: "+eMainDialogDetails.Message);  
    
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


function TC_PIN_EMP_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_010 : Verify the PunchIn of an employee when cancel button is clicked after giving user credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
  if(eEmpLastPunchDetails.bPunchInOutStatus == 1)
    SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,0,eEmpLastPunchDetails.sLastPunchDateTime);
  
  var eEmpCurrentPunchDetails;//stores the latest punch In Details of the Employee after Test case execution
  
  try {
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit invalid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
    //Initialize object of EmployeeCodeForm
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.EmployeeCode);
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid emp code.");
      
    //Initialize object of EmployeePunchForm
    objEmployeePunchForm = EmployeePunchForm.New();
      
    //Click Cancel button from Navigation panel
    objEmployeePunchForm.CancelForm();
    if (objEmployeePunchForm.lastError.name !== undefined) throw objEmployeePunchForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Employee Punch screen and Clicked Cancel.");
      
    //To verify whether the MainDialog is loaded after Cancel PunchIn
    objMainDialog = MainDialog.New();
      
    sScreenTitle = objMainDialog.GetFormInfo().Title;
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    //TestCase Result : verify the last punch details with the latest punch detail, punch detail indicates the test case is passed
    eEmpCurrentPunchDetails =  SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
    sLastPunchDate = eEmpLastPunchDetails.sLastPunchDateTime;
    sCurrPunchDate = eEmpCurrentPunchDetails.sLastPunchDateTime;
    
    bTestCaseResult = ((sScreenTitle === "MAIN MENU" )&& (sLastPunchDate === sCurrPunchDate));
    sPassMessage    = "TestCase Passed. The Employee "+objTestData.EmployeeID+" PunchIn Terminated successfully by clicking Cancel";
    sFailMessage    = "TestCase Failed. The Employee "+objTestData.EmployeeID+" PunchIn Termination had unexpected behaviour";
    
    TestLog.Message("EmployeeID: " +objTestData.EmployeeID+ "'s Last Punch DateTime: "+sCurrPunchDate);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                                             
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
      Utility.closePOSProcess();//Close the POS Application  
      Log.PopLogFolder();
    } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objEmployeeInfoForm = null;
  objEmployeeCodeForm = null;
  objEmployeePunchForm = null;
}


function TC_PIN_EMP_011() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_011 :Verify that the duplicate punch in terminates when 'No' button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
  SQLQueries.updateEmployeePunchDetails(eEmpLastPunchDetails.sEmployeeGUID,1,eEmpLastPunchDetails.sLastPunchDateTime,1);
  
  eEmpLastPunchDetails = SQLQueries.getPunchInOutEmployee(objTestData.EmployeeID);
  
  var eEmpCurrentPunchDetails;//stores the latest punch In Details of the Employee after Test case execution
  
  try {    
      
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit valid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
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
    sPassMessage    = "TestCase Passed. The Employee Duplicate PunchIn Terminated successfully by clicking No";
    sFailMessage    = "TestCase Failed. The Employee Duplicate PunchIn Termination had unexpected behaviour";
    
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


function TC_PIN_EMP_012() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_012 : Verify that an employee with fingerprint enrollment type can navigate to capture finger print screen when given valid Employee ID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objEmployeeInfoForm; //Stores the instance of EmployeeInfo Form
  var objFingerPrintForm; //Stores the instance of FingerPrint Form
  
  var sScreenTitle;
  var eMainDialogDetails;

  var objTestData = {EmployeeID : SQLQueries.getValidEmployeeID("FingerPrint")}; //TestData object to punch in an employee
  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Employee info screen and submit invalid emp ID
    //--------------------------------------------------------------------
    objMainDialog.NavigateToPunchInScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Punch In button.");
      
    //Initialize object of EmployeeInfoForm 
    objEmployeeInfoForm = EmployeeInfoForm.New();
      
    //Set data in Employee ID field and click Enter button from Navigation panel
    objEmployeeInfoForm.InputAndSubmitForm(objTestData.EmployeeID);
    if (objEmployeeInfoForm.lastError.name !== undefined) throw objEmployeeInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
    //Step-3: Navigate into Finger Print Form 
    //---------------------------------------
    objFingerPrintForm = FingerPrintForm.New();
    sScreenTitle = objFingerPrintForm.sTitle;
    if (objFingerPrintForm.lastError.name !== undefined) throw objFingerPrintForm.lastError; 
    
    TestLog.Message("Step-3: Navigated to Finger Print Form.");  
    
    //TestCase Result : To verify that the employee is added successfully
    bTestCaseResult = (sScreenTitle === "CAPTURE FINGERPRINT"); 
    sPassMessage    = "Test Passed. Navigated to FingerPrint Form";
    sFailMessage    = "Test Failed. Failed to Navigate to FingerPrint Form";
    
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
  objFingerPrintForm = null;

}
      
      