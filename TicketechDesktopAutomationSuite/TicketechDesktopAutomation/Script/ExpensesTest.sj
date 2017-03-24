//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT MainDialog
//USEUNIT UserInfoForm
//USEUNIT ExpensesInfoForm
//USEUNIT H6000IIPrinterForm


function TC_EXP_AMT_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_EXP_AMT_001 : Verify that ExpensesUser (Admin) can Print an Expenses successfully  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objExpensesInfoForm; //Stores the instance of ExpensesInfo Form
    
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Window
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Expenses user Login details
  var eExpensesUserDetail = SQLQueries.userLoginDetails("ExpensesUser");
  
  var objTestData = {
                      sDescription : Utility.getRandomValue("ALPHA",6),
                      iPayAmount   : Utility.randomIntFromInterval(10,40),
                      username     : eExpensesUserDetail.username, 
                      password     : eExpensesUserDetail.password,
                      sSubmitCode  : "Enter"
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
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into Expenses Info Form by clicking Expenses button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToExpensesScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Expenses option"); 
       
    //Initialize object of ExpensesInfoForm 
    objExpensesInfoForm = ExpensesInfoForm.New();
    
    //Step-4: Give expense details in Expenses screen
    //----------------------------------------------- 
    objExpensesInfoForm.InputExpensesDetails(objTestData);
    if (objExpensesInfoForm.lastError.name !== undefined) throw objExpensesInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Expenses Screen and submitted Expense Details");
    
    //Step-5: Verify PrintForm and Click Cancel
    //----------------------------------------------- 
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
          
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    bCheck1 = objH6000IIPrinterForm.Exists();
    if (objH6000IIPrinterForm.lastError.name !== undefined) throw objH6000IIPrinterForm.lastError;
    
    eExpensesDetails = SQLQueries.getExpensesDetails();
    
    //TestCase Result : To verify that the screen retuirns to main menu after Print, and details added in DB
    bCheck2 = eExpensesDetails.sDescription === objTestData.sDescription;
    bCheck3 = eExpensesDetails.sAmount === objTestData.iPayAmount;
    bTestCaseResult = (bCheck1 && bCheck2 && bCheck3); 
    sPassMessage    = "Test Passed. The Expenses details added and Printed successfully by user "+objTestData.username;
    sFailMessage    = "Test Failed. Unexpected behaviour while doing Expenses";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);    
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
  objExpensesInfoForm = null;
  objH6000IIPrinterForm = null;
}

function TC_EXP_AMT_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_EXP_AMT_002 : Validate Invalid Expense Code error message by giving empty ExpensesCode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objExpensesInfoForm; //Stores the instance of ExpensesInfo Form

  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Expenses user Login details
  var eExpensesUserDetail = SQLQueries.userLoginDetails("ExpensesUser");
  
  var objTestData = {
                      username     : eExpensesUserDetail.username, 
                      password     : eExpensesUserDetail.password
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
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into Expenses Info Form by clicking Expenses button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToExpensesScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Expenses option"); 
       
    //Initialize object of ExpensesInfoForm 
    objExpensesInfoForm = ExpensesInfoForm.New();
    
    //Step-4: Give expense details in Expenses screen
    //----------------------------------------------- 
    sErrorMessage = objExpensesInfoForm.SubmitWithoutSelectingExpensesCode();
    if (objExpensesInfoForm.lastError.name !== undefined) throw objExpensesInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Expenses Screen and submitted Without Selecting ExpensesCode");
    
    //TestCase Result : To verify that the expexted error message is displayed if Form submitted Without Selecting ExpensesCode
    bTestCaseResult = (sErrorMessage === "EXPENSE IS NOT VALID."); 
    sPassMessage    = "Test Passed. Expexted error message displayed for Empty ExpensesCode";
    sFailMessage    = "Test Failed. Unexpected/No error message displayed for Empty ExpensesCode";
    
    TestLog.Message("Error Message Displayed: "+sErrorMessage);
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);    
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
  objExpensesInfoForm = null;
}

function TC_EXP_AMT_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_EXP_AMT_003 : Verify that a proper error message is getting displayed for an empty Expenses Description  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objExpensesInfoForm; //Stores the instance of ExpensesInfo Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Expenses user Login details
  var eExpensesUserDetail = SQLQueries.userLoginDetails("ExpensesUser");
  
  var objTestData = {
                      sDescription : "",
                      username     : eExpensesUserDetail.username, 
                      password     : eExpensesUserDetail.password
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
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into Expenses Info Form by clicking Expenses button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToExpensesScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Expenses option"); 
       
    //Initialize object of ExpensesInfoForm 
    objExpensesInfoForm = ExpensesInfoForm.New();
    
    //Step-4: Give expense details in Expenses screen
    //----------------------------------------------- 
    sErrorMessage = objExpensesInfoForm.InputExpensesDetails(objTestData);
    if (objExpensesInfoForm.lastError.name !== undefined) throw objExpensesInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Expenses Screen and submitted Empty Expenses Description");
    
    //TestCase Result : To verify that the Expected error message is getting displayed for empty description
    bTestCaseResult = sErrorMessage === "EXPENSE DESCRIPTION IS NOT VALID." ; 
    sPassMessage    = "Test Passed. Expected error message is getting displayed for an empty Expenses Description";
    sFailMessage    = "Test Failed. Unexpected/No error message is getting displayed for an empty Expenses Description";
    
    TestLog.Message("Error Message Displayed: "+sErrorMessage);
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);    
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
  objExpensesInfoForm = null;
}

function TC_EXP_AMT_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_EXP_AMT_004 : Verify that a proper error message is getting displayed if Expenses Amount is 0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objExpensesInfoForm; //Stores the instance of ExpensesInfo Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Expenses user Login details
  var eExpensesUserDetail = SQLQueries.userLoginDetails("ExpensesUser");
  
  var objTestData = {
                      sDescription : Utility.getRandomValue("ALPHA",6),
                      iPayAmount   : 0,
                      username     : eExpensesUserDetail.username, 
                      password     : eExpensesUserDetail.password,
                      sSubmitCode  : "Enter"
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
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into Expenses Info Form by clicking Expenses button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToExpensesScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Expenses option"); 
       
    //Initialize object of ExpensesInfoForm 
    objExpensesInfoForm = ExpensesInfoForm.New();
    
    //Step-4: Give expense details in Expenses screen
    //----------------------------------------------- 
    sErrorMessage = objExpensesInfoForm.InputExpensesDetails(objTestData);
    if (objExpensesInfoForm.lastError.name !== undefined) throw objExpensesInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Expenses Screen and submitted Expense Details with Expense Amount as 0");  
    
    //TestCase Result : To verify that the EXPECTED ERROR MESSGE is getting displayed for amount 0
    bTestCaseResult = sErrorMessage === "AMOUNT ENTERED NOT VALID." ; 
    sPassMessage    = "Test Passed. Expected error message is getting displayed for 0 Expenses Amount";
    sFailMessage    = "Test Failed. Unexpected/No error message is getting displayed for 0 Expenses Amount";
    
    TestLog.Message("Error Message Displayed: "+sErrorMessage);
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);    
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
  objExpensesInfoForm = null;
}

function TC_EXP_AMT_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_EXP_AMT_005 : Verify that Clicking Cancel button return to Main Screen  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objExpensesInfoForm; //Stores the instance of ExpensesInfo Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Expenses user Login details
  var eExpensesUserDetail = SQLQueries.userLoginDetails("ExpensesUser");
  
  var objTestData = {
                      sDescription : Utility.getRandomValue("ALPHA",6),
                      iPayAmount   : Utility.randomIntFromInterval(10,40),
                      username     : eExpensesUserDetail.username, 
                      password     : eExpensesUserDetail.password,
                      sSubmitCode  : "Cancel"
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
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into Expenses Info Form by clicking Expenses button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToExpensesScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Expenses option"); 
       
    //Initialize object of ExpensesInfoForm 
    objExpensesInfoForm = ExpensesInfoForm.New();
    
    //Step-4: Give expense details in Expenses screen and Click Cancel
    //---------------------------------------------------------------- 
    objExpensesInfoForm.InputExpensesDetails(objTestData);
    if (objExpensesInfoForm.lastError.name !== undefined) throw objExpensesInfoForm.lastError;
      
    TestLog.Message("Step-4: Entered Expense Details and Cancel Form");
    
    //Initialize Main Dialog
    objMainDialog = MainDialog.New();
    
    //Step-5: Verify the Screen returns to MainDialog
    //-----------------------------------------------
    sTitle = objMainDialog.GetFormInfo().Title;
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    //TestCase Result : To verify that the screen returns to main menu after Cancel button is clicked
    bTestCaseResult = (sTitle === "MAIN MENU"); 
    sPassMessage    = "Test Passed. The Screen  Returns to "+sTitle+" after clicking Cancel from Expenses Screen";
    sFailMessage    = "Test Failed. Unexpected behaviour while doing Cancel in Expenses";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);    
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
  objExpensesInfoForm = null;
}

function TC_EXP_AMT_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TC_EXP_AMT_006 : Verify that Clicking Back button traverse back to the upper field in Expenses Screen  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objExpensesInfoForm; //Stores the instance of ExpensesInfo Form
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  //Getting Expenses user Login details
  var eExpensesUserDetail = SQLQueries.userLoginDetails("ExpensesUser");
  
  var objTestData = {
                      sDescription : Utility.getRandomValue("ALPHA",6),
                      iPayAmount   : Utility.randomIntFromInterval(10,40),
                      username     : eExpensesUserDetail.username, 
                      password     : eExpensesUserDetail.password,
                      sSubmitCode  : "Back"
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
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    objMainDialog = MainDialog.New();
    
    //Step-3: Navigate into Expenses Info Form by clicking Expenses button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToExpensesScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3: Clicked Expenses option"); 
       
    //Initialize object of ExpensesInfoForm 
    objExpensesInfoForm = ExpensesInfoForm.New();
    
    //Step-4: Give expense details in Expenses screen and Click Back button
    //--------------------------------------------------------------------- 
    bFieldFocus = objExpensesInfoForm.InputExpensesDetails(objTestData);
    if (objExpensesInfoForm.lastError.name !== undefined) throw objExpensesInfoForm.lastError;
      
    TestLog.Message("Step-4: Entered Expense Details and Clicked Back button");
    
    //TestCase Result : To verify that the Focus returns to the above field after clicking Back button
    bTestCaseResult = (bFieldFocus); 
    sPassMessage    = "Test Passed. The Focus returns to the above field after clicking Back button in Expenses Screen";
    sFailMessage    = "Test Failed. Unexpected behaviour while doing Expenses";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);    
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
  objExpensesInfoForm = null;
}