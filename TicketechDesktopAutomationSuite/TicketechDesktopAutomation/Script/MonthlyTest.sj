//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT CheckInCustomerInfoForm

function TC_MONTH_CHKN_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_001 : Verify Check In ticket is printed when valid tag number is given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var frmCheckInCustomerInfo; //Stores the instance of Employee Info Screen
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Monthly.xls";
    DataPool.SheetName = "TC_MONTH_CHKN_001";
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
                      VehicleTag : DataPool.Item("VehicleTag")                                            
                    }; //TestData object to check in a monthly employee
     Log.Message(objTestData.VehicleTag);
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into Customer info screen and submit valid vehicle tag
      //--------------------------------------------------------------------
      home.NavigateToMonthlyScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Monthly button.");
      
      //Initialize object of CheckInCustomerInfoForm 
      frmCheckInCustomerInfo = CheckInCustomerInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      frmCheckInCustomerInfo.InputAndSubmitForm(objTestData.VehicleTag);
      if (frmCheckInCustomerInfo.lastError.name !== undefined) throw frmCheckInCustomerInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to CheckInCustomerInfo Form and submitted Vehicle Tag.");
 
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
  frmCheckInCustomerInfo = null;
  DataPool.Close(); 

}
