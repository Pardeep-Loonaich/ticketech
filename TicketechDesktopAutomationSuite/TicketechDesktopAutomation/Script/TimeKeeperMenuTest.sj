//USEUNIT UserInfoForm
//USEUNIT MainDialog
//USEUNIT Utility

function TC_POUT_EMP_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_POUT_EMP_002 : Validating Employee PunchIn Time by providing invalid emp ID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var userInfo; //Stores the instance of Employee Info Screen
  
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
                      username : DataPool.Item("username"), password : DataPool.Item("password")                                            
                    }; //TestData object to punch in an employee
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      home.NavigateToUserInfoScreen();
      
      //Step-2: Navigate into user info screen and submit username and password
      //--------------------------------------------------------------------
      userInfo = UserInfoForm.New();
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-1: Clicked LogIn button.");
      //Initialize object of EmployeeInfoScreen 
      
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      userInfo.InputandSubmitForm(objTestData.username,objTestData.password);
      if (userInfo.lastError.name !== undefined) throw userInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to User Info screen and Logged in as"+objTestData.username);
      home1 = MainDialog.New();
      home1.NavigateToTimeKeeperMenu();
      delay(1000);
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-3: Navigated to Time Keeper screen");    
                                             
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