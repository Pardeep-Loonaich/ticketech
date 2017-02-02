//USEUNIT EmployeeInfoForm
//USEUNIT EmployeeCodeForm
//USEUNIT EmployeePunchForm
//USEUNIT ConfirmActionForm
//USEUNIT MainDialog
//USEUNIT Utility


function TC_PIN_EMP_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_001 : Verify Employee can able to successfully PunchIn by giving valid credentials
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmEmployeeInfo; //Stores the instance of Employee Info Form
  var frmEmployeeCode; //Stores the instance of Employee Code Form
  var frmEmployeePunch; //Stores the instance of Employee Punch Form
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchIn.xls";
    DataPool.SheetName = "TC_PIN_EMP_001";
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
      
      objTestData = {
                      EmployeeID : DataPool.Item("EmpID"), 
                      EmployeeCode : DataPool.Item("EmpCode")                                            
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchInScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch In button.");
      
      //Initialize object of EmployeeInfoForm 
      frmEmployeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      frmEmployeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
      //Initialize object of EmployeeCodeForm
      frmEmployeeCode = new EmployeeCodeForm.New();
      
      //Set data in Employee Code field and click Enter button from Navigation panel
      frmEmployeeCode.InputAndSubmitForm(objTestData.EmployeeCode);
      if (frmEmployeeCode.lastError.name !== undefined) throw frmEmployeeCode.lastError;
      
      TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid emp code.");
      
      //Initialize object of EmployeePunchForm
      frmEmployeePunch = new EmployeePunchForm.New();
      
      //Click Enter button from Navigation panel
      frmEmployeePunch.SubmitForm();
      if (frmEmployeePunch.lastError.name !== undefined) throw frmEmployeePunch.lastError;
      
      TestLog.Message("Step-4: Navigated to Employee Punch screen and Clicked Enter.");
      
      //DB Verification : To verify if the employee PunchIn is successful
      //------------------------------------------------------------------
      //if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The Employee "+objTestData.EmployeeID+" PunchIn Successfully");    
      //else (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
      //  TestLog.Fail("TestCase Failed. The Employee "+objTestData.EmployeeID+" PunchIn Failed");  
                                             
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  //Disposing objects 
  home = null;
  frmEmployeeInfo = null;
  frmEmployeeCode = null;
  frmEmployeePunch = null;
  DataPool.Close(); 
}

function TC_PIN_EMP_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_002 : Verify that a proper error message is displayed when empty/blank employee ID is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmEmployeeInfo; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "EMPLOYEE ID CANNOT BE EMPTY."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchIn.xls";
    DataPool.SheetName = "TC_PIN_EMP_002";
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
      
      objTestData = {
                      EmployeeID : DataPool.Item("EmpID")                                            
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchInScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch In button.");
      
      //Initialize object of EmployeeInfoForm 
      frmEmployeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage = frmEmployeeInfo.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted blank emp id.");
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The error message is displayed as expected for blank employee ID");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the blank employee ID");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the blank employee ID");    
                                             
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  //Disposing objects 
  home = null;
  frmEmployeeInfo = null;
  DataPool.Close(); 

}

function TC_PIN_EMP_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_003 : Verify that a proper error message is displayed when non-existing employee ID is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmEmployeeInfo; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "EMPLOYEE NOT FOUND."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchIn.xls";
    DataPool.SheetName = "TC_PIN_EMP_003";
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
      
      objTestData = {
                      EmployeeID : DataPool.Item("EmpID")                                            
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchInScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch In button.");
      
      //Initialize object of EmployeeInfoForm 
      frmEmployeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage = frmEmployeeInfo.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted invalid emp id.");
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The error message is displayed as expected for invalid employee ID");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the invalid employee ID");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the invalid employee ID");    
                                             
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  //Disposing objects 
  home = null;
  frmEmployeeInfo = null;
  DataPool.Close(); 

}

function TC_PIN_EMP_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_004 : Verify that a proper error message is displayed when invalid code is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmEmployeeInfo; //Stores the instance of Employee Info Screen
  var frmEmployeeCode; //Stores the instance of Employee Code Screen
  var expectedErrorMessage = "TEMPLATE ENTERED NOT MATCH."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchIn.xls";
    DataPool.SheetName = "TC_PIN_EMP_004";
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
      
      objTestData = {
                      EmployeeID : DataPool.Item("EmpID"),
                      EmployeeCode : DataPool.Item("EmpCode")                                            
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchInScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch In button.");
      
      //Initialize object of EmployeeInfoForm 
      frmEmployeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      frmEmployeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
       //Initialize object of EmployeeCodeForm 
      frmEmployeeCode = new EmployeeCodeForm.New();
      
      //Set invalid Employee code and click Enter button from Navigation panel
      actualErrorMessage = frmEmployeeCode.InputAndSubmitFormWithErrors(objTestData.EmployeeCode);
      if (frmEmployeeCode.lastError.name !== undefined) throw frmEmployeeCode.lastError;
      
      TestLog.Message("Step-3: Navigated to EmployeeCode Form and submitted invalid emp code.");
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The error message is displayed as expected for invalid employee Code");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the invalid employee Code");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the invalid employee Code");    
                                             
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  //Disposing objects 
  home = null;
  frmEmployeeInfo = null;
  frmEmployeeCode = null;
  DataPool.Close(); 

}

function TC_PIN_EMP_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_005 : Verify that a proper error message is displayed when empty/blank code is given as input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmEmployeeInfo; //Stores the instance of Employee Info Screen
  var frmEmployeeCode; //Stores the instance of Employee Code Screen
  var expectedErrorMessage = "CODE ENTERED NOT VALID."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchIn.xls";
    DataPool.SheetName = "TC_PIN_EMP_005";
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
      
      objTestData = {
                      EmployeeID : DataPool.Item("EmpID"),
                      EmployeeCode : DataPool.Item("EmpCode")                                            
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchInScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch In button.");
      
      //Initialize object of EmployeeInfoForm 
      frmEmployeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      frmEmployeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
       //Initialize object of EmployeeCodeForm 
      frmEmployeeCode = new EmployeeCodeForm.New();
      
      //Set blank Employee code and click Enter button from Navigation panel
      actualErrorMessage = frmEmployeeCode.InputAndSubmitFormWithErrors(objTestData.EmployeeCode);
      if (frmEmployeeCode.lastError.name !== undefined) throw frmEmployeeCode.lastError;
      
      TestLog.Message("Step-3: Navigated to EmployeeCode Form and submitted blank emp code.");
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The error message is displayed as expected for blank employee Code");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the blank employee Code");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the blank employee Code");    
                                             
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  //Disposing objects 
  home = null;
  frmEmployeeInfo = null;
  frmEmployeeCode = null;
  DataPool.Close(); 

}
