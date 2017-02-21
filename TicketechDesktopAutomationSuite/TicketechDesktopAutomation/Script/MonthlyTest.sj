//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT CheckInCustomerInfoForm
//USEUNIT CheckInVehicleDamageForm
//USEUNIT PrinterStatusForm
//USEUNIT NavigationPanelForm
//USEUNIT TechnicianMenuForm
//USEUNIT CheckInTicketNumberForm
//USEUNIT ManualDateInformationDateForm
//USEUNIT UserInfoForm

function TC_MONTH_CHKN_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_001 : Verify Check In ticket is printed when valid tag number is given and 'No' button is clicked for Damaged Vehicle Confirmation Form
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objPrinterStatusForm;//Stores the instance of Printer Status Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
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
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog= MainDialog.New();
      
      //Step-2: Navigate into Customer info screen and submit valid vehicle tag
      //--------------------------------------------------------------------
      objMainDialog.NavigateToMonthlyScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Monthly button.");
      
      //Initialize object of CheckInCustomerInfoForm 
      objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.VehicleTag);
      if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
      TestLog.Message("Step-2: Navigated to CheckInCustomerInfo Form and submitted Vehicle Tag.");
      
      //Initialize object of CheckInVehicleDamageForm 
      objCheckInVehicleDamageForm= CheckInVehicleDamageForm.New();
      
      //Click No for vehicle damage confirmation.
      objCheckInVehicleDamageForm.ConfirmNo();
      if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
      TestLog.Message("Step-3: Click No button to confirm vehicle not damage");
      
      //Click Cancel button on Printer Status window 
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      
      // TestCase Result : To verify whether the expected error message is displayed
      bTestCaseResult = objMainDialog.Exists();
      sPassMessage    = "TestCase.Passed  :CheckIn ticket is printed for the valid tag number";
      sFailMessage     = "TestCase.Failed : Failed to Check In";
      
      //Assert Result
      Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;
  DataPool.Close(); 
}

function TC_MONTH_CHKN_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_002 : Verify Check In ticket is printed when valid tag number is given and 'Yes' button is clicked under Damaged Vehicle Confirmation Form
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objPrinterStatusForm; //Stores the instance of Printer Status Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Monthly.xls";
    DataPool.SheetName = "TC_MONTH_CHKN_002";
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
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog = MainDialog.New();
      
      //Step-2: Navigate into Customer info screen and submit valid vehicle tag
      //--------------------------------------------------------------------
      objMainDialog.NavigateToMonthlyScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Monthly button.");
      
      //Initialize object of CheckInCustomerInfoForm 
      objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.VehicleTag);
      if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
      TestLog.Message("Step-2: Navigated to CheckInCustomerInfo Form and submitted Vehicle Tag.");
      
      //Initialize object of CheckInVehicleDamageForm 
      objCheckInVehicleDamageForm= CheckInVehicleDamageForm.New();
      
      //Click No for vehicle damage confirmation.
      objCheckInVehicleDamageForm.ConfirmYes();
      if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
      TestLog.Message("Step-3: Click Yes button to confirm vehicle not damage");
      
      //Click on Cancel button on Printer Status window 
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      
      /// TestCase Result : To verify whether the expected error message is displayed
      bTestCaseResult = objMainDialog.Exists();
      sPassMessage    = "TestCase.Passed  :CheckIn ticket is printed for the valid tag number";
      sFailMessage     = "TestCase.Failed : Failed to Check In";
      
      //Assert Result
      Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;
  DataPool.Close(); 

}

function TC_MONTH_CHKN_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_003 : Verify the monthly checkin of the employee who has already checked in 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var actualErrorMessage;
  var expectedErrorMessage ="VEHICLE IS ALREADY CHECKED IN.";
  
  
  try {
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Monthly.xls";
    DataPool.SheetName = "TC_MONTH_CHKN_003";
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
                    }; //TestData object to for vehicle tag field
      
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog = MainDialog.New();
      
     //Step-2: Navigate into Customer info screen and submit invalid vehicle tag
     //--------------------------------------------------------------------
      objMainDialog.NavigateToMonthlyScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Monthly  button.");
      
      //Initialize object of CustomerInfoScreen 
      objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
      //Set data in Vehicle Tag field and click Enter button from Navigation panel
      actualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.VehicleTag)
      if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
      TestLog.Message("Step-2: Navigated to Customer Info screen and submitted invalid vehicle Tag");
      
       // TestCase Result : To verify whether the expected error message is displayed
      bTestCaseResult = (aqString.Find(actualErrorMessage,expectedErrorMessage)!=-1);
      sPassMessage    = "Expected error is displayed for the employee who has already checked in.Testcase Passed.";
      sFailMessage    = "Unexpected error Message is displayed. TestCase Failed";
      
      //Assert Result 
      Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);
      
  }//End try
        
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
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  DataPool.Close(); 

}

function TC_MONTH_CHKN_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_004 : Verify that a proper error message is getting displayed when invalid/empty employee is given as input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var actualErrorMessage;
  var expectedErrorMessage ="TAG NUMBER ENTERED IS NOT VALID.";
  
  try {
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Monthly.xls";
    DataPool.SheetName = "TC_MONTH_CHKN_004";
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
                    }; //TestData object to for vehicle tag field
      
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog = MainDialog.New();
      
     //Step-2: Navigate into Customer info screen and submit invalid vehicle tag
     //--------------------------------------------------------------------
      objMainDialog.NavigateToMonthlyScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Monthly  button.");
      
      //Initialize object of CustomerInfoScreen 
      objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
      //Set data in Vehicle Tag field and click Enter button from Navigation panel
      actualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.VehicleTag)
      if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
      TestLog.Message("Step-2: Navigated to Customer Info screen and submitted invalid vehicle Tag");
      
       // TestCase Result : To verify whether the expected error message is displayed
      bTestCaseResult = (aqString.Find(actualErrorMessage,expectedErrorMessage)!=-1);
      sPassMessage    = "Expected error is displayed for invalid/empty tag number.Testcase Passed.";
      sFailMessage     = "Unexpected error Message is displayed. TestCase Failed";
      
      //Assert Result 
      Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);
      
  }//End try
        
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
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  DataPool.Close(); 

}

function TC_MONTH_CHKN_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_005 : Create manual Entry successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog;// variable to store  main dialog unit object
  var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
  var objUserInfoForm;//Stores the instance of Employee Info Form
  var objPrinterStatusForm;//variable to store PrinterStatusForm
  var objNavigationPanelForm;//Variable to store NavigationPanelForm           
  var objTechnicianMenuForm; //variable to store TechnicianMenuForm
  var objCheckInTicketNumberForm; //variable to store CheckInTicketNumberForm
  var objManualDateInformationDateForm; //variable to store ManualDateInformationDateForm
  var objCheckInCustomerInfoForm;// Stores the instance of CheckInCustomerInfoForm
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
      //Connecting to testdata file & reading the given data
      TestDataIdx = 0;
      DataPool.FilePath = Project.Path + "TestData\\";
      DataPool.FileName = "Monthly.xls";
      DataPool.SheetName = "TC_MONTH_CHKN_005";
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
      
      objTestData = { UserName: DataPool.Item("UserName"),
                      Password: DataPool.Item("Password"),
                      TicketNumber: ("1"+Utility.getRandomValue("NUMERIC",5)),
                      VehicleTag : DataPool.Item("VehicleTag")              
                      }; //TestData object for Monthly module                                         
    var CheckInDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"); 
                                                  
      //Step-1: Launching the POS application and Initialize the home screen
      TestLog.Message("Step-1: Launching the POS application and Initialize the home screen");
      Utility.launchApp();
      
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      //Step-2: Navigate into user info screen and submit username and password
      objMainDialog.NavigateToUserInfoScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
      TestLog.Message("Step-2: Clicked Log In button.");     
      
      //Initialize object of UserInfoForm       
       objUserInfo = UserInfoForm.New();
      
      //Set data in Username and Password field and click Enter button from Navigation panel
      objUserInfo.InputAndSubmitForm(objTestData.UserName,objTestData.Password);
      if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
      
      TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.UserName);
           
      //Initialize object of MainDialog Form 
      objMainDialog = MainDialog.New();
      objMainDialog.NavigateToTechnicianMenu();
      
      TestLog.Message("Step-4:clicking on Technician Menu Button..");
      
      // Enable manual ticket entry
      objTechnicianMenuForm = TechnicianMenuForm.New();
      objTechnicianMenuForm.EnableManualTicketEntry();
      
      TestLog.Message("Step-5:Enabled manual ticket entry");
      
      //Initialize object of MainDialog Form 
      objMainDialog = MainDialog.New();
      Delay(1000);
      
      // Click Monthly button
      objMainDialog.NavigateToMonthlyScreen();
      
      TestLog.Message("Clicked Monthly button");
      
      //Initialize object of CheckInTicketNumber Form 
      objCheckInTicketNumberForm = CheckInTicketNumberForm.New();
      objCheckInTicketNumberForm.SetTicketNumber(objTestData.TicketNumber);
      
      // Enter manual ticket number
      TestLog.Message("Step-7:Entered manual ticket number");
      
      //Initialize object of ManualDateInformationDate Form
      objManualDateInformationDateForm = ManualDateInformationDateForm.New();
      objManualDateInformationDateForm.EnterCheckInDate(CheckInDate);
      objManualDateInformationDateForm.EnterCheckInTime(null);
      
      // Enter manual checkin Date and Time
      TestLog.Message("Step-8:Entered Manual checkin Date and Time");
      
       //Initialize object of CustomerInfoScreen 
      objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
            
      //Set data in Employee ID field and click Enter button from Navigation panel
      objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.VehicleTag);
      TestLog.Message(objTestData.VehicleTag);
      if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
      TestLog.Message("Step-2: Navigated to CheckInCustomerInfo Form and submitted Vehicle Tag.");
      
      //Initialize object of CheckInVehicleDamageForm 
      objCheckInVehicleDamageForm= CheckInVehicleDamageForm.New();
      
      //Click No for vehicle damage confirmation.
      objCheckInVehicleDamageForm.ConfirmYes();
      if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
      TestLog.Message("Step-3: Click Yes button to confirm vehicle not damage");
      
      //Click on Cancel button on Printer Status window 
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      
      /// TestCase Result : To verify whether the expected error message is displayed
      bTestCaseResult = objMainDialog.Exists();
      sPassMessage    = "TestCase.Passed  :CheckIn ticket is printed for the valid tag number";
      sFailMessage     = "TestCase.Failed : Failed to Check In";
      
      //Assert Result
      Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objMainDialog = null;
  DataPool.Close(); 
  
  }
  
function TC_MONTH_CHKN_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_006 : Verify the screen gets back to the home screen when 'Cancel' button is clicked. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  var screenTitle;
  var bTestCaseResult;
  
  try {
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Monthly.xls";
    DataPool.SheetName = "TC_MONTH_CHKN_006";
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
                    }; //TestData object to for vehicle tag field
      
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog = MainDialog.New();
      
     //Step-2: Navigate into Customer info screen and submit invalid vehicle tag
     //--------------------------------------------------------------------
      objMainDialog.NavigateToMonthlyScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Monthly  button.");
      
      //Initialize object of CustomerInfoScreen 
      objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
      //Set data in Vehicle Tag field and click Enter button from Navigation panel
      objCheckInCustomerInfoForm.ClickCancel(objTestData.VehicleTag)
      if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
      TestLog.Message("Step-2:Clicked Cancel button");
      
      //Verify the title of the home screen
      //-------------------------------------
      objMainDialog   = MainDialog.New();
      bTestCaseResult = objMainDialog.GetFormInfo().Title;
      TestLog.Message(bTestCaseResult);
      sPassMessage    ="TestCase Passed. Navigated to the home screen when Cancel button is clicked";
      sFailMessage    ="TestCase Failed. Failed to Navigateto the home screen ";
      
      //Assert Result
      Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);    
      
  }//End try
        
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
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  DataPool.Close(); 

}

  
  







