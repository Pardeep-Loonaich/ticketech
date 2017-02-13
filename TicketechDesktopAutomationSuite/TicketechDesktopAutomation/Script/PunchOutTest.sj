//USEUNIT Utility
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
  var home; //Stores the instance of home screen
  var employeeCode; //Stores the instance of Employee Info Screen
  //var expectedErrorMessage = "PLEASE WAIT..."; //Stores the expected error message    
  //var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_001";
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
                      EmployeeID : DataPool.Item("EmpID"),EmployeeCode : DataPool.Item("code")                                         
                    }; //TestData object to punch out an employee
                    
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      

      //Step-2: Navigate into Employee info screen and submit valid emp ID
     //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      employeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
      //Step-3: Navigate into Employee code screen and submit valid code
      //--------------------------------------------------------------------
       
      //Initialize object of EmployeeCodeScreen 
      employeeCode = new EmployeeCodeForm.New();
      
      //Set data in Employee Code field and click Enter button from Navigation panel
      employeeCode.InputAndSubmitForm(objTestData.EmployeeCode);
      if (employeeCode.lastError.name !== undefined) throw employeeCode.lastError;
      
      TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid code.");
      TestLog.Message(objTestData.EmployeeCode);
      
       //Step-4: Navigate into Employee punch screen and click Enter button
      //--------------------------------------------------------------------
      
      //Initialize object of EmployeePunchScreen 
      employeePunch = new EmployeePunchForm.New();
      
      //Click Enter button from Navigation panel
      employeePunch.SubmitForm();
      if (employeePunch.lastError.name !== undefined) throw employeePunch.lastError;
      
      TestLog.Message("TestCase Passed.The Employee is punched out successfully");
       
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
  employeeInfo = null;
  employeeCode=null;
  DataPool.Close(); 

}


function TC_POUT_EMP_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_002 : Validating PunchOut by providing invalid empID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeInfo; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "EMPLOYEE NOT FOUND."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_002";
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
                    }; //TestData object to punch out an employee
                    
      TestLog.Message(objTestData.EmployeeID);
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
     //Step-2: Navigate into Employee info screen and submit invalid emp ID
     //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage = employeeInfo.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted invalid emp id");
      
       //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. Expected error message displayed successfuly for Punch Out with Invalid Employee ID");    
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
  employeeInfo = null;
  DataPool.Close(); 

}


function TC_POUT_EMP_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PIN_EMP_003 : Validating PunchOut by providing empty Employee ID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeCode; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "EMPLOYEE ID CANNOT BE EMPTY."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_003";
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
                    }; //TestData object to punch out an employee
                    
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit valid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage=employeeInfo.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted empty emp id.");
      
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The error message is displayed as expected when blank Employee ID is given");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the empty Employee ID");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the Employee ID");    
                                             
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
  employeeInfo = null;
  employeeCode=null;
  DataPool.Close(); 

}


function TC_POUT_EMP_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_004 : Validating PunchOut by providing invalid code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeCode; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "TEMPLATE ENTERED NOT MATCH."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_004";
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
                      EmployeeID : DataPool.Item("EmpID"),EmployeeCode : DataPool.Item("code")                                         
                    }; //TestData object to punch out an employee
                    
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit valid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      employeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
      //Step-3: Navigate into Employee code screen and submit invalid code
      //--------------------------------------------------------------------
       
      //Initialize object of EmployeeCodeScreen 
      employeeCode = new EmployeeCodeForm.New();
      
      //Set data in Employee Code field and click Enter button from Navigation panel
      actualErrorMessage=employeeCode.InputAndSubmitFormWithErrors(objTestData.EmployeeCode);
      if (employeeCode.lastError.name !== undefined) throw employeeCode.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Code screen and submitted invalid code.");
      TestLog.Message(objTestData.EmployeeCode);
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. Expected error message displayed successfuly for Punch Out with Invalid Employee Code");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the  invalid Code");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the  invalid Code"); 
              
     
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
  employeeInfo = null;
  employeeCode=null;
  DataPool.Close(); 

}


function TC_POUT_EMP_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_005 : Verify Transaction timed out for punch out an employee after entering details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeCode; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "PUNCH TRANSACTION HAS TIMED OUT. PLEASE, TRY AGAIN."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_005";
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
                      EmployeeID : DataPool.Item("EmpID"),EmployeeCode : DataPool.Item("code")                                         
                    }; //TestData object to punch out an employee
                    
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      frmInfo = home.GetFormInfo();
      
      //Step-2: Navigate into Employee info screen and submit valid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      employeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted valid emp id.");
      
      //Step-3: Navigate into Employee code screen and submit valid code
      //-----------------------------------------------------------------
       
      //Initialize object of EmployeeCodeScreen 
      employeeCode = new EmployeeCodeForm.New();
      
      //Set data in Employee Code field and click Enter button from Navigation panel
      employeeCode.InputAndSubmitForm(objTestData.EmployeeCode);
      if (employeeCode.lastError.name !== undefined) throw employeeCode.lastError;
      
      TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid code.");
      TestLog.Message(objTestData.EmployeeCode);
      
       //Step-4: Navigate into Employee punch screen and click Enter button after 3 minutes
      //------------------------------------------------------------------------------------
      
      //Initialize object of EmployeePunchScreen 
      employeePunch = new EmployeePunchForm.New();
      Delay(180000);
      
      //Click Enter button from Navigation panel
      employeePunch.SubmitForm();
      if (employeePunch.lastError.name !== undefined) throw employeePunch.lastError;
      TestLog.Message("Step-4 :Clicked Enter Button");
      
      //Step-5: Navigate into home screen and check the error message
      //-----------------------------------------------------------------
      home = MainDialog.New();
      frmInfo = home.GetFormInfo();
      Log.Message (frmInfo.Message);
      actualErrorMessage = frmInfo.Message;
      
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. Expected error message displayed successfuly for PunchOut Transaction TimeOut");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for Transaction TimeOut");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for Transaction TimeOut"); 
              
    
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
  employeeInfo = null;
  employeeCode=null;
  DataPool.Close(); 

}

function TC_POUT_EMP_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_006 : Verify Transaction timed out for punch out an employee before entering details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeCode; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "PUNCH TRANSACTION HAS TIMED OUT. PLEASE, TRY AGAIN."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_006";
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
                    }; //TestData object to punch out an employee
                    
    
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      frmInfo = home.GetFormInfo();
      
      //Step-2: Navigate into Employee info screen and submit valid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      Delay(180000);
      
      //Click Enter button from Navigation panel
      employeeInfo.SubmitForm();
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      TestLog.Message("Step-4 :Clicked Enter Button");
      
      //Step-5: Navigate into home screen and check the error message
      //-----------------------------------------------------------------
      home = MainDialog.New();
      frmInfo = home.GetFormInfo();
      Log.Message (frmInfo.Message);
      actualErrorMessage = frmInfo.Message;
      
      
      //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. Expected error message displayed successfuly for PunchOut Transaction TimeOut");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for Transaction TimeOut");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for Transaction TimeOut"); 
              
    
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
  employeeInfo = null;
  employeeCode=null;
  DataPool.Close(); 

}

function TC_POUT_EMP_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_007 : Verify that employee is able to duplicate punch out .
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeInfo; //Stores the instance of Employee Info Screen
  var employeeCode; //Stores the instance of Employee Code Screen
  //var expectedErrorMessage = "CODE ENTERED NOT VALID."; //Stores the expected error message    
  //var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_007";
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
                      EmployeeID   : DataPool.Item("EmpID"),
                      EmployeeCode : DataPool.Item("Code")                                        
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit valid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoForm 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      employeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
      //Step-3: Navigate to confirm Action screen and click yes button
      //-----------------------------------------------------------------
      confirmAction = new ConfirmActionForm.New();
      TestLog.Message("Step-3 : Navigated to ConfirmAction Form");
      
      //Click Yes button from YesNoConfirmAction panel
      confirmAction.ConfirmYes();
      if (confirmAction.lastError.name !== undefined) throw confirmAction.lastError;
      TestLog.Message("Step-4 :Clicked Yes Button");
     
     ///Step-3: Navigate into Employee code screen and submit valid code
      //--------------------------------------------------------------------
       
      //Initialize object of EmployeeCodeScreen 
      employeeCode = new EmployeeCodeForm.New();
      
      //Set data in Employee Code field and click Enter button from Navigation panel
      employeeCode.InputAndSubmitForm(objTestData.EmployeeCode);
      if (employeeCode.lastError.name !== undefined) throw employeeCode.lastError;
      
      TestLog.Message("Step-3: Navigated to Employee Code screen and submitted valid code.");
      TestLog.Message(objTestData.EmployeeCode);
      
       //Step-4: Navigate into Employee punch screen and click Enter button
      //--------------------------------------------------------------------
      
      //Initialize object of EmployeePunchScreen 
      employeePunch = new EmployeePunchForm.New();
      
      //Click Enter button from Navigation panel
      employeePunch.SubmitForm();
      if (employeePunch.lastError.name !== undefined) throw employeePunch.lastError;
      
      TestLog.Message("TestCase Passed.The Employee is punched out successfully");
      
      //DB Verification : To verify if the employee PunchIn is successful
      //------------------------------------------------------------------
      //if (actualErrorMessage === expectedErrorMessage)
        TestLog.Pass("TestCase Passed. The Employee "+objTestData.EmployeeID+" PunchOut Successfully");    
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


function TC_POUT_EMP_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_008 : Verify that employee gets back to the previous screen when 'No' button is clicked
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmEmployeeInfo; //Stores the instance of Employee Info Screen
  //var frmEmployeeCode; //Stores the instance of Employee Code Screen
  //var expectedErrorMessage = "CODE ENTERED NOT VALID."; //Stores the expected error message    
  //var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_008";
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
                      EmployeeID   : DataPool.Item("EmpID")
                      }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToPunchInScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoForm 
      frmEmployeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      frmEmployeeInfo.InputAndSubmitForm(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and submitted valid emp id.");
      
      //Step-3: Navigate to confirm Action screen and click yes button
      //---------------------------------------------------------------
      confirmAction = new ConfirmActionForm.New();
      TestLog.Message("Step-3 : Navigated to ConfirmAction Form");
     
       //Click Yes button from YesNoConfirmAction panel
      confirmAction.ConfirmNo();
      if (confirmAction.lastError.name !== undefined) throw confirmAction.lastError;
      TestLog.Message("Step-4 :Clicked No Button");
     
     //Step-3:/Navigate to the Employee info form and click cancel button
      
       //Set data in Employee ID field and click Enter button from Navigation panel
      frmEmployeeInfo.CancelForm(objTestData.EmployeeID);
      if (frmEmployeeInfo.lastError.name !== undefined) throw frmEmployeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to EmployeeInfo Form and clicked cancel button.");
      
                              
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

function TC_POUT_EMP_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_009 : Verify the PunchOut of an employee who has already punched out within an hour
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeInfo; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "YOU ARE ALREADY PUNCHED OUT AT"; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_009";
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
                    }; //TestData object to punch out an employee
                    
      TestLog.Message(objTestData.EmployeeID);
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
     //Step-2: Navigate into Employee info screen and submit invalid emp ID
     //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage = employeeInfo.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted invalid emp id");
      
       //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (aqString.Find(actualErrorMessage,expectedErrorMessage)!=-1)
        TestLog.Pass("TestCase Passed. Expected error message is displayed successfuly for already punched out employee ");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the already punched out employee");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the already punched out employee");    
                                             
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
  employeeInfo = null;
  DataPool.Close(); 

}


function TC_POUT_EMP_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_POUT_EMP_010 : Verify the PunchOut of an employee who has already punched In a day ago  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var employeeInfo; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "YOU MISSED OUT THE PUNCH OUT TIME. PUNCH OUT CANCELLED. PREVIOUS PUNCH IN AT";//Stores the expected error message 
  var actualErrorMessage; //Stores the error message to be dispalyed    
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "PunchOut.xls";
    DataPool.SheetName = "TC_POUT_EMP_010";
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
                    }; //TestData object to punch out an employee
                    
      TestLog.Message(objTestData.EmployeeID);
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
     //Step-2: Navigate into Employee info screen and submit invalid emp ID
     //--------------------------------------------------------------------
      home.NavigateToPunchOutScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked Punch Out button.");
      
      //Initialize object of EmployeeInfoScreen 
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage = employeeInfo.InputAndSubmitFormWithErrors(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted invalid emp id");
      
       //Verification : To verify if the expected error message is displayed
      //-------------------------------------------------------------------
      if (aqString.Find(actualErrorMessage,expectedErrorMessage)!=-1)
        TestLog.Pass("TestCase Passed. Expected error message is displayed successfuly for already punched out employee ");    
      else if (actualErrorMessage === "THE SYSTEM IS WAITING FOR YOUR SELECTION")  
        TestLog.Fail("TestCase Failed. No error message is displayed for the already punched out employee");
      else
        TestLog.Fail("TestCase Failed. Unexpected error message is displayed for the already punched out employee");    
                                             
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
  employeeInfo = null;
  DataPool.Close(); 

}