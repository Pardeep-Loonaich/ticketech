//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT EmployeeInfoForm

function TC_PIN_EMP_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_PIN_EMP_002 : Validating Employee PunchIn Time by providing invalid emp ID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen...
  var employeeInfo; //Stores the instance of Employee Info Screen
  var expectedErrorMessage = "EMPLOYEE NOT FOUND."; //Stores the expected error message    
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
      
      TestLog.Message("Step-1: Clicked Punch In button.");

      //Step-2: Navigate into Employee info screen and submit invalid emp ID
      //--------------------------------------------------------------------
      home.NavigateToEmployeeInfoScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      //Initialize object of EmployeeInfoScreen..Ragapriya.
      employeeInfo = new EmployeeInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      actualErrorMessage = employeeInfo.InputandSubmitFormWithErrors(objTestData.EmployeeID);
      if (employeeInfo.lastError.name !== undefined) throw employeeInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to Employee Info screen and submitted invalid emp id.");
      
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
  employeeInfo = null;
  DataPool.Close(); 

}