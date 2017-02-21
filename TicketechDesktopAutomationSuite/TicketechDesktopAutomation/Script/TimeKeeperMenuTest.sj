//USEUNIT UserInfoForm
//USEUNIT MainDialog
//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT TimekeeperMenuForm
//USEUNIT EmployeeEnrollmentMenuForm
//USEUNIT EmployeeEnrollmentInfoForm
//USEUNIT EmployeeEnrollmentTypeForm
//USEUNIT EmployeeCodeForm
//USEUNIT FingerPrintForm
//USEUNIT ConfirmActionForm
//USEUNIT EmployeePrintTimecardForm
//USEUNIT EmployeePrintTimecardPreviewForm
//USEUNIT PrinterStatusForm


function TC_TKM_ACCESS_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_001 : Validate that the user whose role is mapped to Timekeeper feature "Enrollment Menu" (ADMINSTRATOR) is able to access the Features successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of User Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var bTestCaseResult;//Boolean variable to store TestCase result

  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     username : eTimekeeperUserDetail.username, password : eTimekeeperUserDetail.password
                    };
  
  try {
    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate to user info form and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Employee ID field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    //Step-3: Reloading main Screen, and Navigating to TimeKeeper Menu Form
    //---------------------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
    //Step-4: Initializing Timekeeper Menu Form and Navigating to Enrollment Menu Form
    //--------------------------------------------------------------------------------
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
      
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Step-5: Initializing Enrollment Menu Form and Verifying the Menu is available to user
    //-------------------------------------------------------------------------------------
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");
      
    //TestCase Result : To verify whether the expected title is displayed
    bTestCaseResult = (objEmpEnrollMenuForm.sTitle === "EMPLOYEE ENROLLMENT");
    sPassMessage    = "TestCase Passed. Timekeeper User CAN able to access EmployeeEnrollmentMenu Form";
    sFailMessage    = "TestCase Failed. Timekeeper User DO NOT have access to EmployeeEnrollmentMenu Form";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);
  
  } //End try
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
  
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally 
  
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
}


function TC_TKM_ACCESS_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_002 : Validate that the user whose role is NOT mapped to Timekeeper feature "Enrollment Menu" is not able to access the Features
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  
 //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithoutEnrollMenu");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    };
   try {
    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info form and submit username and password
    //---------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Employee ID field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username+" with pass "+objTestData.password);
    objMainDialog = MainDialog.New();
    
    //Step-3: Verify TimekeeperMenu is available to user, if true, Verify Employee Enroll Menu is available
    //-----------------------------------------------------------------------------------------------------
    if(!objMainDialog.NavigateToTimeKeeperMenu()) {
      TestLog.Pass("TestCase Passed. Timekeeper Menu not available for user "+objTestData.username+ " who is not mapped to Any TKM Feature");
    }
    else {
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
      //Initialize object of TimekeeperMenuForm 
      objTimekeeperMenuForm = TimekeeperMenuForm.New();
      
      //Verify if Employee Enroll Menu is available  
      if (!objTimekeeperMenuForm.NavigateToEnrollmentForm()) {
        TestLog.Pass("TestCase Passed. Employee Enrollment not available for user "+objTestData.username+ " who is not mapped to Enrollment TKM Feature");
      }
      else {
        if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
        TestLog.Fail("TestCase Failed. Employee Enrollment available for user "+objTestData.username+ " who is not mapped to Enrollment TKM Feature");
      }
    }
  }//End Try
 
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally 
  
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
}


function TC_TKM_ENR_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_001 : Verify that field validations are proper while adding new employee
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmpEnrollInfoForm;//Stores the instance of EmployeeEnrollmentInfo Form
  var objEmpEnrollTypeForm;//Stores the instance of EmployeeEnrollmentType Form
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  //Declaring and initializing Test Data object 
  var objTestData = {sEmpId : null, sFirstName : null, sLastName : null, iSSNum : null, sBirthDate: null, sExpectedMsg : null,
                     username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    };
    
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "TimekeeperMenu.xls";
    DataPool.SheetName = "TC_TKM_ENR_001";
    DataPool.New(); //Creating a New Excel Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {
      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      Log.Message(DataPool.Item("EmpID").toString());
      
      //Storing Test Data from Excel into Test data Object
      objTestData.sEmpId = DataPool.Item("EmpID").toString(); 
      objTestData.sFirstName = DataPool.Item("FirstName");
      objTestData.sLastName = DataPool.Item("LastName");
      objTestData.iSSNum = DataPool.Item("SSN");
      objTestData.sBirthDate = DataPool.Item("BirthDate");
      objTestData.sExpectedMsg = DataPool.Item("ErrorMessage");                                             
                                                                 
       
      //Step-1: Launching the POS application and Initialize the MainDialog
      //-------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog = MainDialog.New();
      
      //Step-2: Navigate into user info screen and submit username and password
      //-----------------------------------------------------------------------
      objMainDialog.NavigateToUserInfoScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Log In button.");
      
      //Initialize object of UserInfoForm 
      objUserInfoForm = UserInfoForm.New(); 
      
      //Set data in Username and Password field and click Enter button from Navigation panel
      objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
      if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
      TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
            
      //Initializing MainDialog after user Login        
      objMainDialog = MainDialog.New();
      
      //Step-3: Navigate into user Timekeeper Menu screen
      //-------------------------------------------------                
      objMainDialog.NavigateToTimeKeeperMenu();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
      TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
      //Initialize object of TimekeeperMenuForm 
      objTimekeeperMenuForm = TimekeeperMenuForm.New();
      
      //Step-4: Navigate into Enrollment Form
      //-------------------------------------
      objTimekeeperMenuForm.NavigateToEnrollmentForm();
      if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
      TestLog.Message("Step-4: Clicked Enrollment option button.");
      
      //Initialize object of EmployeeEnrollmentMenuForm
      objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
      //Step-5: Navigate into Add Employee Form
      //---------------------------------------
      objEmpEnrollMenuForm.NavigateToAddEmployeeForm();
      if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;  
      
      TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");                      
        
      //Initialize object of EmployeeEnrollmentInfoForm 
      objEmpEnrollInfoForm = EmployeeEnrollmentInfoForm.New();
      
      //Step-6: Adding New Employee details in Information Form and Submitting
      //----------------------------------------------------------------------
      actualMessage = objEmpEnrollInfoForm.InputAndSubmitFormWithErrors(objTestData);
      if (objEmpEnrollInfoForm.lastError.name !== undefined) throw objEmpEnrollInfoForm.lastError;  
      
      TestLog.Message("Step-6: Navigated to EmployeeEnrollmentInfo Form.");
      
      //TestCase Result : To verify Actual Error Message with the Expected Error Message
      bTestCaseResult = (actualMessage === objTestData.sExpectedMsg || (actualMessage == null && objTestData.sExpectedMsg === "NO MESSAGE EXPECTED"));
      sPassMessage    = "TestCase Passed. "+objTestData.sExpectedMsg;
      sFailMessage    = "TestCase Failed. "+actualMessage+ " " +objTestData.sExpectedMsg;
    
      //Assert Result
      Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);
      
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {  
      Utility.closePOSProcess(); //Close the POS Application      
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
  } // while EOF
    
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objEmpEnrollInfoForm = null;
  objEmpEnrollTypeForm = null;
}

function TC_TKM_ENR_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_002 : Verify that a new employee is added successfully through the enrollment ADD Menu providing valid inputs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmpEnrollInfoForm;//Stores the instance of EmployeeEnrollmentInfo Form
  var objEmpEnrollTypeForm;//Stores the instance of EmployeeEnrollmentType Form
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  //Declaring and initializing Test Data object 
  var objTestData = {sEmpId : null, sFirstName : null, sLastName : null, iSSNum : null, sBirthDate: null, sExpectedMsg : null,
                     username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    };
      
  try {
  
    //Data Generator
    objTestData.sEmpId     = Utility.getRandomValue("ALPHA",1)+Utility.getRandomValue("NUMERIC",6);
    objTestData.sFirstName = Utility.getRandomString(["JOHN","DANIEL","PETER","NORMAN","HARRY","MARY",Utility.getRandomValue("ALPHA",6)]);
    objTestData.sLastName  = Utility.getRandomString(["THOMPSON","CRAIG","PARKER","OSBORNE",Utility.getRandomValue("ALPHA",6)]);
    objTestData.iSSNum     = Utility.getRandomValue("NUMERIC",9);
    objTestData.sBirthDate = "12121983"; 
        
    TestLog.Message("The employee ID is "+objTestData.sEmpId+ " " +objTestData.sFirstName+ " " +objTestData.sLastName);
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info form and submit username and password
    //---------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    //Step-3: Navigate into user Timekeeper Menu form
    //-------------------------------------------------        
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
    //Step-4: Navigate to employee enrollment form
    //--------------------------------------------
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
      
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Step-4: Navigate to Add Employee Form
    //-------------------------------------
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    objEmpEnrollMenuForm.NavigateToAddEmployeeForm();
    if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;  
      
    TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");
    
    //Step-5: Give Valid Employee Details in Employee Info form and Submit the details
    //-------------------------------------------------------------------------------- 
    objEmpEnrollInfoForm = EmployeeEnrollmentInfoForm.New();
    
    objEmpEnrollInfoForm.InputAndSubmitForm(objTestData);
    if (objEmpEnrollInfoForm.lastError.name !== undefined) throw objEmpEnrollInfoForm.lastError;  
      
    TestLog.Message("Step-6: Navigated to EmployeeEnrollmentInfo Form and Submitted Employee Details.");
    
    //Step-6: Navigate to EmployeeEnrollmentType Form and cancel the Enrollment type
    //------------------------------------------------------------------------------
    objEmpEnrollTypeForm = EmployeeEnrollmentTypeForm.New();
    
    objEmpEnrollTypeForm.CancelForm();
    if (objEmpEnrollTypeForm.lastError.name !== undefined) throw objEmpEnrollTypeForm.lastError;  
      
    TestLog.Message("Step-7: Navigated to EmployeeEnrollmentType Form and cancel the Enrollment type");
    
    //TestCase Result : To verify that the employee is added successfully
    bTestCaseResult = SQLQueries.getEmployeeDetails(objTestData.sEmpId).bResult; // DB verification carried out for the given employeeID
    sPassMessage    = "Test Passed. The employee " +objTestData.sEmpId + " details added successfully" ;
    sFailMessage    = "Test Failed. The employee " +objTestData.sEmpId + " details not added" ;
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);
        
  } //End try 
  
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  }
  
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objEmpEnrollInfoForm = null;
  objEmpEnrollTypeForm = null;
}


function TC_TKM_ENR_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_003: Verify that an existing employee details can be modified and saved succesfully via CORRECT button in Enrollment Menu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmpEnrollInfoForm;//Stores the instance of EmployeeEnrollmentInfo Form
  var objEmpEnrollTypeForm;//Stores the instance of EmployeeEnrollmentType Form
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  //retrives and stores recently added Employee details
  var eEmpCurrentData = SQLQueries.getLastAddedEmployeeDetails();
  
  var objTestData = {
                      sEmpId : eEmpCurrentData.sEmployeeID, sFirstName : null, sLastName : null, iSSNum : null, sBirthDate: null, 
                      username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    };  
  try {
  
    //Data Generator
    objTestData.sFirstName = Utility.getRandomValue("ALPHA",5);
    objTestData.sLastName  = Utility.getRandomValue("ALPHA",5);
    objTestData.iSSNum     = Utility.getRandomValue("NUMERIC",9);
    objTestData.sBirthDate = "12121983";     
    TestLog.Message("The employee ID is "+objTestData.sEmpId+ " " +objTestData.sFirstName+ " " +objTestData.sLastName);
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info form and submit username and password
    //---------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    //Step-3: Reloading MainDialog and navigating to Timekeeper menu Form
    //-------------------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
    //Step-4: Navigate into Enrollment Menu Form and click Correct button
    //------------------------------------------------------------------- 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
      
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Initialize object of EmployeeEnrollmentMenuForm
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    empCurrentData = objEmpEnrollMenuForm.NaviagteToUpdateEmployeeDataForm(objTestData.sEmpId);   
    if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;  
      
    TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");
    
    //Step-5: Navigate into EnrollmentInfo Form and updating Employee Details
    //----------------------------------------------------------------------- 
    objEmpEnrollInfoForm = EmployeeEnrollmentInfoForm.New();
    
    objEmpEnrollInfoForm.UpdateAndSubmitForm(objTestData);
    if (objEmpEnrollInfoForm.lastError.name !== undefined) throw objEmpEnrollInfoForm.lastError;  
      
    TestLog.Message("Step-6: Navigated to EmployeeEnrollmentInfo Form.");
    
    //DB Verification of updated result
    eEmpUpdatedData = SQLQueries.getEmployeeDetails(objTestData.sEmpId);
    
    //TestCase Result : To verify that the employee is added successfully
    bTestCaseResult = (eEmpUpdatedData.sFirstName === objTestData.sFirstName && eEmpUpdatedData.sLastName === objTestData.sLastName); 
    sPassMessage    = "Test Passed. The employee " +objTestData.sEmpId + " details Updated successfully" ;
    sFailMessage    = "Test Failed. The employee " +objTestData.sEmpId + " details not Updated" ;
    
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
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objEmpEnrollInfoForm = null;
  objEmpEnrollTypeForm = null;
}

function TC_TKM_ENR_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_004 : Verify that an existing employee's punch in option (Enrollment type) can be modified via Correct Enrollment (Change Enrollment to Fingerprint)
  Note: As Fingerprint scanner is external device, this test case is limited upto navigation to fingerprint screen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmpEnrollInfoForm;//Stores the instance of EmployeeEnrollmentInfo Form
  var objEmpEnrollTypeForm;//Stores the instance of EmployeeEnrollmentType Form
  var objFingerPrintForm;//Stores the instance of FingerPrint Form
  var sScreenTitle;

  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  //retrives and stores recently added Employee details
  var eEmpCurrentData = SQLQueries.getLastAddedEmployeeDetails();
  
  var objTestData = {
                      sEmpId : eEmpCurrentData.sEmployeeID,
                      username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    };   
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Time Keeper option"); 
      
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4: Navigate into Employee Enrollment Menu screen by clicking Enrollment button
    //-----------------------------------------------------------------------------------    
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Step-5: Navigate into Employee Enrollment Type screen by clicking CorrectEnrollment button
    //------------------------------------------------------------------------------------------
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    objEmpEnrollMenuForm.NavigateToCorrectEnrollmentForm(objTestData.sEmpId);
    if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;
    
    TestLog.Message("Step-5: Navigated to Employee Enrollment Type screen"); 
      
    //Initialize object of EmployeeEnrollmentTypeForm
    objEmpEnrollTypeForm = EmployeeEnrollmentTypeForm.New();
    
    //Step-6: Navigate into Finger Print screen 
    //-----------------------------------------
    objEmpEnrollTypeForm.SelectFingerPrint();      
    if (objEmpEnrollTypeForm.lastError.name !== undefined) throw objEmpEnrollTypeForm.lastError;  
      
    TestLog.Message("Step-6: Navigated to Finger Print Form.");
  
    //Initialize object of FingerPrintForm and get screen title
    objFingerPrintForm = FingerPrintForm.New(); 
       
    sScreenTitle = objFingerPrintForm.sTitle;
    if (objFingerPrintForm.lastError.name !== undefined) throw objFingerPrintForm.lastError; 
    
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
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objEmpEnrollInfoForm = null;
  objEmpEnrollTypeForm = null;
  objFingerPrintForm = null;

}

function TC_TKM_ENR_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_005 : Verify that an existing employee's punch in option (Enrollment Type) can be modified via Correct Enrollment  (Change Enrollment to Code)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmpEnrollInfoForm;//Stores the instance of EmployeeEnrollmentInfo Form
  var objEmpEnrollTypeForm;//Stores the instance of EmployeeEnrollmentType Form
  var objEmployeeCodeForm; //Stores the instance of Employee Code Form
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  var objTestData = {
                      sEmpId : SQLQueries.getValidEmployeeID("FingerPrint"),//retrives and stores an Employee's Id whose enrollment type is fingerprint 
                      username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    }; 
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked TimeKeeper option"); 
      
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4: Navigate into Employee Enrollment Menu screen by clicking Enrollment button
    //-----------------------------------------------------------------------------------  
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Step-5: Navigate into Enrollment Type form by Correct Enrollment button
    //----------------------------------------------------------------------- 
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    objEmpEnrollMenuForm.NavigateToCorrectEnrollmentForm(objTestData.sEmpId);
    if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;
    
    TestLog.Message("Step-5: Navigated to Employee Enrollment Type screen"); 
      
    //Step-6: Select the enrollment type as Code
    //------------------------------------------  
    objEmpEnrollTypeForm = EmployeeEnrollmentTypeForm.New();
    
    objEmpEnrollTypeForm.SelectCode();
    if (objEmpEnrollTypeForm.lastError.name !== undefined) throw objEmpEnrollTypeForm.lastError;  
      
    TestLog.Message("Step-6: Navigated to Code Form.");
    
    //Step-7: Navigate into EmployeeCode Form  and submit a new employee code
    //-----------------------------------------------------------------------
    objEmployeeCodeForm = EmployeeCodeForm.New();
      
    //Set data in Employee Code field and click Enter button from Navigation panel
    objEmployeeCodeForm.InputAndSubmitForm(objTestData.sEmpId);//EmployeeID is set as employee code
    if (objEmployeeCodeForm.lastError.name !== undefined) throw objEmployeeCodeForm.lastError;
      
    TestLog.Message("Step-7: The code is entered entered ");
      
    //DB Verification of updated result
    eEmpUpdatedData = SQLQueries.getEmployeeDetails(objTestData.sEmpId);
    
    //TestCase Result : To verify that the employee is added successfully
    bTestCaseResult = aqString.Find(eEmpUpdatedData.sTemplateImage,"<TemplateType>Password</TemplateType>"); 
    sPassMessage    = "Test Passed. The employee " +objTestData.sEmpId + " Enrollment Type Updated  to Code "+objTestData.sEmpId+" successfully" ;
    sFailMessage    = "Test Failed. The employee " +objTestData.sEmpId + " Enrollment Type not Updated" ;
    
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
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objEmpEnrollInfoForm=null;
  objEmpEnrollTypeForm=null;
  objEmployeeCodeForm=null;
}

function TC_TKM_ENR_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_006 : Verify that an existing employee's record can be soft deleted using Delete Enrollment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objConfirmActionForm;
  var sScreenTitle;
  var sActualScreenText;
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  var objTestData = {
                      sEmpId : SQLQueries.getValidEmployeeID("FingerPrint"),//retrives and stores an Employee's Id whose enrollment type is fingerprint 
                      username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    }; 
   
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked TimeKeeper option"); 
      
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4: Navigate into Employee Enrollment Menu screen by clicking Enrollemnt button
    //-----------------------------------------------------------------------------------
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option.");
      
    //Initialize object of EmployeeEnrollmentMenuForm
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    //Step-5: clicking Delete Enrollemnt button after selecting the required employee
    //-------------------------------------------------------------------------------
    objEmpEnrollMenuForm.NavigateToDeleteEnrollmentForm(objTestData.sEmpId);
    if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;
    
    TestLog.Message("Step-5: Clicked Delete Enrollment button"); 
      
        
    //Step-6: Navigate into Confirm Action screen and confirm yes to delete the record
    //--------------------------------------------------------------------------------
    objConfirmActionForm = ConfirmActionForm.New();

    sActualScreenText = objConfirmActionForm.GetFormInfo().ScreenText;
    
    if(aqString.Find(sActualScreenText,objTestData.sEmpId)!=-1){
      objConfirmActionForm.ConfirmYes();
      if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError;     
      TestLog.Message("Step-6: Yes button is clicked.'");  
    } else {
      TestLog.Message("Expected Employee not selected. Refer EmpId in Screen text: "+sActualScreenText);
    }
    
    //TestCase Result : To verify that the employee is deleted successfully
    bTestCaseResult = SQLQueries.getEmployeeDetails(objTestData.sEmpId).bEmployeeDeleted; 
    sPassMessage    = "Test Passed. The Employee "+objTestData.sEmpId+" deleted successfully";
    sFailMessage    = "Test Failed. The Employee "+objTestData.sEmpId+" not deleted";
    
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
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objConfirmActionForm=null;

}

function TC_TKM_ENR_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_007 : Verify that an existing employee's record is not deleted if user selects NO as the option 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objConfirmActionForm;
  var sScreenTitle;
  var sActualScreenText;
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Timekeeper user Login details
  var eTimekeeperUserDetail = SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu");
  
  var objTestData = {
                      sEmpId : SQLQueries.getValidEmployeeID("FingerPrint"),//retrives and stores an Employee's Id whose enrollment type is fingerprint 
                      username: eTimekeeperUserDetail.username, password: eTimekeeperUserDetail.password
                    }; 
   
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked TimeKeeper option"); 
      
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4: Navigate into Employee Enrollment Menu screen by clicking Enrollemnt button
    //-----------------------------------------------------------------------------------
    objTimekeeperMenuForm.NavigateToEnrollmentForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option.");
      
    //Initialize object of EmployeeEnrollmentMenuForm
    objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
    //Step-5: clicking Delete Enrollemnt button after selecting the required employee
    //-------------------------------------------------------------------------------
    objEmpEnrollMenuForm.NavigateToDeleteEnrollmentForm(objTestData.sEmpId);
    if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;
    
    TestLog.Message("Step-5: Clicked Delete Enrollment button"); 
      
        
    //Step-6: Navigate into Confirm Action screen and confirm No to not delete the record
    //-----------------------------------------------------------------------------------
    objConfirmActionForm = ConfirmActionForm.New();

    sActualScreenText = objConfirmActionForm.GetFormInfo().ScreenText;
    
    if(aqString.Find(sActualScreenText,objTestData.sEmpId)!=-1){
      objConfirmActionForm.ConfirmNo();
      if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError;     
      TestLog.Message("Step-6: No button is clicked.'");  
    } else {
      TestLog.Message("Expected Employee not selected. Refer EmpId in Screen text: "+sActualScreenText);
    }
    
    //TestCase Result : To verify that the employee is deleted or not
    bTestCaseResult = !SQLQueries.getEmployeeDetails(objTestData.sEmpId).bEmployeeDeleted; 
    sPassMessage    = "Test Passed. The Employee "+objTestData.sEmpId+" not deleted";
    sFailMessage    = "Test Failed. The Employee "+objTestData.sEmpId+" delete status is True";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage); 
  }
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objConfirmActionForm=null;

}


function TC_TKM_PTC_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_TKM_PTC_001 : Verify that Admin can Print Timecard Report for a particular employee  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmployeePrintTimecardForm;
  var frmemployeePrintPreviewForm;
  var frmPrinterStatus;
  
  var sScreenTitle;
  
  var objTestData = {sEmpId : "62220", username : "ADMINISTRATOR" , password : "POSTICKETECH"};
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked TimeKeeper option"); 
       
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4:  Navigate into  Menu screen by clicking  print card button
    //-------------------------------------------------------------------
      
    objTimekeeperMenuForm.NavigateToPrintTimecardForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Print Time Card option.");
      
    //Initialize object of EmployeePrintcardForm
      objEmployeePrintTimecardForm = EmployeePrintTimecardForm.New();
    
    //Set data in Employee ID field and click Enter button from Navigation panel
      objEmployeePrintTimecardForm.InputAndSubmitForm(objTestData.sEmpId);
      if (objEmployeePrintTimecardForm.lastError.name !== undefined) throw objEmployeePrintTimecardForm.lastError;
      
      TestLog.Message("Step-5: Navigated to Employee Print Timecard screen and submitted valid emp id.");
      
      //Initialize object for EmployeePrintTimecardPreviewForm
      frmemployeePrintPreviewForm= EmployeePrintTimecardPreviewForm.New();
      
      //Click Enter button from Navigation panel
      frmemployeePrintPreviewForm.SubmitForm();
      if (frmemployeePrintPreviewForm.lastError.name !== undefined) throw frmemployeePrintPreviewForm.lastError;
      
      TestLog.Message("Step-6: Navigated to EmployeePrintTimecardPreview Clicked Enter.");
      
      Delay(20000);
      
       //Initialize object of PrinterStatusForm
     frmPrinterStatus = PrinterStatusForm.New();
     
     //Click Cancel button
      frmPrinterStatus.ClickCancel();
      if (frmPrinterStatus.lastError.name !== undefined) throw frmPrinterStatus.lastError;
      
      TestLog.Message("Step-7: Navigated to EmployeePrintTimecardPreview Clicked Cancel under PrintStatusForm.");
      
  }// End Try
  
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objConfirmActionForm=null;

}


function TC_TKM_PTC_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_TKM_PTC_002 : Verify that Admin can Print Timecard Report for ALL employees 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var frmPrinterStatus;
  var sScreenTitle;
  var objEmployeePrintTimecardForm;
  var frmemployeePrintPreviewForm;
  var frmPrinterStatus;
  
  //Getting Timekeeper user Login details
  TimekeeperUserDetail = SQLQueries.timekeeperUserLoginDetails();
  
  //Declaring and initializing Test Data object 
  var objTestData = {EmployeeId : null,
                     username: TimekeeperUserDetail.username, password: TimekeeperUserDetail.password
                    };
  
  try {
  
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked TimeKeeper option"); 
       
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4:  Navigate into  Menu screen by clicking  print card button
    //-------------------------------------------------------------------
      
    objTimekeeperMenuForm.NavigateToPrintTimecardForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Print Time Card option.");
      
    //Initialize object of EmployeePrintcardForm
      objEmployeePrintTimecardForm = EmployeePrintTimecardForm.New();
    
    //Click All Employees button from Print Timecard Options panel
    objEmployeePrintTimecardForm.NavigateToAllEmployees();
    if (objEmployeePrintTimecardForm.lastError.name !== undefined) throw objEmployeePrintTimecardForm.lastError;
      
      TestLog.Message("Step-5: Navigated to Employee Print Timecard screen and clicked All Employees button.");
      
      Delay(40000);
      
      frmPrinterStatus = PrinterStatusForm.New();
     
     //Click Cancel button
      frmPrinterStatus.ClickCancel();
      Delay(40000);
      
      //Initialize object for EmployeePrintTimecardPreviewForm
      frmemployeePrintPreviewForm= EmployeePrintTimecardPreviewForm.New();
      
      //Click Enter button from Navigation panel
      frmemployeePrintPreviewForm.SubmitForm();
      if (frmemployeePrintPreviewForm.lastError.name !== undefined) throw frmemployeePrintPreviewForm.lastError;
      
      TestLog.Message("Step-6: Navigated to EmployeePrintTimecardPreview Clicked Enter.");
      
      Delay(40000);
      
       //Initialize object of PrinterStatusForm
     frmPrinterStatus = PrinterStatusForm.New();
     
     //Click Cancel button
      frmPrinterStatus.ClickCancel();
      Delay(40000);
      if (frmPrinterStatus.lastError.name !== undefined) throw frmPrinterStatus.lastError;
      
      TestLog.Message("Step-7: Navigated to EmployeePrintTimecardPreview Clicked Cancel under PrintStatusForm.");
      
  }// End Try
  
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objConfirmActionForm=null;

}

function TC_TKM_PTC_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_TKM_PTC_003 : Verify that a proper error message is getting displayed for an Invalid/non-existing employee ID is given as input to get a timecard report
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objTimekeeperMenuForm;//Stores the instance of TimekeeperMenu Form
  var objEmpEnrollMenuForm;//Stores the instance of EmployeeEnrollmentMenu Form
  var objEmployeePrintTimecardForm;//Stores the instance of EmployeePrintTimeCard Screen
  var sActualErrorMessage;
  
  //Getting Timekeeper user Login details
  TimekeeperUserDetail = SQLQueries.timekeeperUserLoginDetails();
  
  //Declaring and initializing Test Data object 
  var objTestData = {EmployeeId : null, ExpectedErrorMsg : null,
                     username: TimekeeperUserDetail.username, password: TimekeeperUserDetail.password
                    };
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "TimekeeperMenu.xls";
    DataPool.SheetName = "TC_TKM_PTC_003";
    DataPool.New(); //Creating a New Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
    
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {

      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      
      //TestData object to print the time card report. 
      objTestData.EmployeeId = DataPool.Item("EmpID");
      objTestData.ExpectedErrorMsg  = DataPool.Item("expectedErrorMessage");                                          
                     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToTimeKeeperMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
    
    //Initialize object of TimekeeperMenuForm 
    objTimekeeperMenuForm = TimekeeperMenuForm.New();
    
    //Step-4:  Navigate into  Menu screen by clicking  print card button
    //-------------------------------------------------------------------
      
    objTimekeeperMenuForm.NavigateToPrintTimecardForm();
    if (objTimekeeperMenuForm.lastError.name !== undefined) throw objTimekeeperMenuForm.lastError;
      
    TestLog.Message("Step-4: Clicked Print Time Card option.");
      
    //Initialize object of EmployeePrintcardForm
    objEmployeePrintTimecardForm = EmployeePrintTimecardForm.New();
    
    //Set data in Employee ID field and click Enter button from Navigation panel
    sActualErrorMessage=objEmployeePrintTimecardForm.InputAndSubmitFormWithErrors(objTestData.EmployeeId,objTestData.ExpectedErrorMsg);
    if (objEmployeePrintTimecardForm.lastError.name !== undefined) throw objEmployeePrintTimecardForm.lastError;
      
      TestLog.Message("Step-5: Navigated to Employee Print Timecard screen and submitted invalid emp id.");
      
     //Asserting Actual Error Message with the Expected Error Message
      Utility.assertResult((sActualErrorMessage === objTestData.ExpectedErrorMsg),"TestCase Passed. "+sActualErrorMessage,"TestCase Failed. "+sActualErrorMessage+ " " +objTestData.ExpectedErrorMsg);//Verification : To verify if the expected error message is displayed
     
  }// End Try
  
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    DataPool.NextItem()
    Log.PopLogFolder();
     } //End finally

  } // while EOF
  
  //Disposing objects 
  objMainDialog = null;
  objUserInfoForm = null;
  objTimekeeperMenuForm = null;
  objEmpEnrollMenuForm = null;
  objConfirmActionForm=null;
  objEmployeePrintTimecardForm = null;
  DataPool.Close();
}





