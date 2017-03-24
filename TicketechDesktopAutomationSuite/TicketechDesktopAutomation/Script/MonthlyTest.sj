//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
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
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_001 : Verify Check In ticket is printed when valid tag number is given and 'No' button is clicked for Damaged Vehicle Confirmation Form
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm; //Stores the instance of CheckInVehicleDamage Form
  var objPrinterStatusForm; //Stores the instance of Printer Status Form
  var bTestCaseResult; //Boolean variable to store the TestCase result
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }

    objTestData = { sVehicleTag : eTagNumberDetail.sVehicleTag }; //TestData object to check in a monthly customer vehicle
     
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
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
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
    
    eVehicleTagDetailLatest = SQLQueries.getLastAddedMonthlyDetails(objTestData.sVehicleTag);
      
    // TestCase Result : To verify whether the Main screen appears after monthly and the Check In details got added in DB
    bTestCaseResult = objMainDialog.Exists() && eVehicleTagDetailLatest.bResult;
    sPassMessage    = "TestCase.Passed : CheckIn ticket is printed for the valid tag number "+objTestData.sVehicleTag;
    sFailMessage    = "TestCase.Failed : Unexpected behaviour during Monthly Check in ";
      
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
  } //End try
        
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;
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
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }

    objTestData = { sVehicleTag : eTagNumberDetail.sVehicleTag }; //TestData object to check in a monthly customer vehicle
   
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
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
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
    
    eVehicleTagDetailLatest = SQLQueries.getLastAddedMonthlyDetails(objTestData.sVehicleTag);
    
    objMainDialog = MainDialog.New();
      
    // TestCase Result : To verify whether the Main screen appears after monthly and the Check In details got added in DB
    bTestCaseResult = objMainDialog.Exists() && eVehicleTagDetailLatest.bResult;
    sPassMessage    = "TestCase.Passed : CheckIn ticket is printed for the valid tag number "+objTestData.sVehicleTag;
    sFailMessage    = "TestCase.Failed : Unexpected behaviour during Monthly Check in ";   
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage); 
     
  } //End try
        
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;

}

function TC_MONTH_CHKN_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_003 : Verify the monthly checkin for already checked in Vehicle Tag
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //--------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  
  var bTestCaseResult; //Boolean variable to store the TestCase result
  var actualErrorMessage; //Stores the error message to be dispalyed
  var expectedErrorMessage = "VEHICLE IS ALREADY CHECKED IN."; //Stores the expected error message 
  
  var eTagNumberDetail = SQLQueries.getLastAddedMonthlyDetails();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }

    objTestData = { sVehicleTag : eTagNumberDetail.sVehicleTag }; //TestData object to check in a monthly customer vehicle
   
    //Launching the POS application and Initialize the objMainDialog screen
    //---------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Navigate into Customer info screen and submit invalid vehicle tag
    //-----------------------------------------------------------------
    objMainDialog.NavigateToMonthlyScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly  button.");
      
    //Initialize object of CustomerInfoScreen 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle Tag field and click Enter button from Navigation panel
    actualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.sVehicleTag)
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Customer Info screen and submitted invalid vehicle Tag");
      
    //TestCase Result : To verify whether the expected error message is displayed for already checked in vehicle
    bTestCaseResult = (aqString.Find(actualErrorMessage,expectedErrorMessage)!=-1);
    sPassMessage    = "Testcase Passed. Expected error is displayed for the Vehicle that has already checked in.";
    sFailMessage    = "TestCase Failed. Unexpected/No error Message is displayed for already check in Vehicle.";
      
    //Assert Result 
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);
      
  }//End try
        
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;

}

function TC_MONTH_CHKN_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_004 : Verify that a proper error message is getting displayed when empty Vehicle Tag is given as input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  
  var bTestCaseResult; //Boolean variable to store the TestCase result
  var actualErrorMessage; //Stores the error message to be dispalyed
  var expectedErrorMessage ="TAG NUMBER ENTERED IS NOT VALID."; //Stores the expected error message 
  
  var objTestData = { VehicleTag : "" }; //TestData object to for vehicle tag field
                      
  try {
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
      
    //TestCase Result : To verify whether the expected error message is displayed empty tag number
    bTestCaseResult = (actualErrorMessage === expectedErrorMessage)
    sPassMessage    = "Testcase Passed. Expected error is displayed for invalid/empty tag number.";
    sFailMessage    = "TestCase Failed. Unexpected/No error Message is displayed for invalid/empty tag number.";
      
    //Assert Result 
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);
      
  }//End try
        
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally

  //Disposing objects 
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
  
}

function TC_MONTH_CHKN_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_005 : Veriy that the Monthly Check In can be done successfully when Manual entry is enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog;// variable to store  main dialog unit object
  var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
  var objUserInfoForm;//Stores the instance of User Info Form
  var objPrinterStatusForm;//variable to store PrinterStatusForm
  var objNavigationPanelForm;//Variable to store NavigationPanelForm           
  var objTechnicianMenuForm; //variable to store TechnicianMenuForm
  var objCheckInTicketNumberForm; //variable to store CheckInTicketNumberForm
  var objManualDateInformationDateForm; //variable to store ManualDateInformationDateForm
  var objCheckInCustomerInfoForm;// Stores the instance of CheckInCustomerInfoForm
  var bTestCaseResult; //Boolean variable to store the TestCase result
  
  var eUserDetails = SQLQueries.userLoginDetails("TechnicianMenuUser");
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
     
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }

    objTestData = { username     : eUserDetails.username,
                    password     : eUserDetails.password,
                    sVehicleTag  : eTagNumberDetail.sVehicleTag,
                    sCheckInDate : aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"),
                    sTicketNumber: ("12"+Utility.getRandomValue("NUMERIC",4))
                  }; //TestData object to check in a monthly Customer
                                                   
    //Step-1: Launching the POS application and Initialize the home screen
    TestLog.Message("Step-1: Launching the POS application and Initialize the home screen");
    Utility.launchApp();
      
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    //Step-2: Navigate into user info screen and submit username and password
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    TestLog.Message("Step-2: Clicked Log In button.");     
      
    //Initialize object of UserInfoForm       
    objUserInfo = UserInfoForm.New();
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo.InputAndSubmitForm(objTestData);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
      
    TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.username);
           
    //Initialize object of MainDialog Form 
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToTechnicianMenu();
      
    TestLog.Message("Step-4:clicking on Technician Menu Button..");
      
    //Enable manual ticket entry
    objTechnicianMenuForm = TechnicianMenuForm.New();
    objTechnicianMenuForm.EnableManualTicketEntry();
      
    TestLog.Message("Step-5:Enabled manual ticket entry");
      
    //Initialize object of MainDialog Form 
    objMainDialog = MainDialog.New();
    Delay(1000);
      
    //Click Monthly button
    objMainDialog.NavigateToMonthlyScreen();
      
    TestLog.Message("Clicked Monthly button");
      
    //Initialize object of CheckInTicketNumber Form 
    objCheckInTicketNumberForm = CheckInTicketNumberForm.New();
    objCheckInTicketNumberForm.SetTicketNumber(objTestData.sTicketNumber);
      
    //Enter manual ticket number
    TestLog.Message("Step-7:Entered manual ticket number");
      
    //Initialize object of ManualDateInformationDate Form
    objManualDateInformationDateForm = ManualDateInformationDateForm.New();
    objManualDateInformationDateForm.EnterCheckInDate(objTestData.sCheckInDate);
    objManualDateInformationDateForm.EnterCheckInTime(null);
    if(objManualDateInformationDateForm.lastError.name !== undefined) throw objManualDateInformationDateForm.lastError;  
    //Enter manual checkin Date and Time
    TestLog.Message("Step-8:Entered Manual checkin Date and Time");
      
    //Initialize object of CustomerInfoScreen 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
            
    //Set data in Employee ID field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    TestLog.Message("Step-9: Navigated to CheckInCustomerInfo Form and submitted Vehicle Tag.");
      
    //Initialize object of CheckInVehicleDamageForm 
    objCheckInVehicleDamageForm= CheckInVehicleDamageForm.New();
      
    //Click Yes for vehicle damage confirmation.
    objCheckInVehicleDamageForm.ConfirmYes();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    TestLog.Message("Step-10: Click Yes button to confirm vehicle damage");
    
    objMainDialog = MainDialog.New();
      
    eVehicleTagDetailLatest = SQLQueries.getLastAddedMonthlyDetails(objTestData.sVehicleTag);
      
    // TestCase Result : To verify whether the Main screen appears after monthly and the Check In details got added in DB
    bTestCaseResult = objMainDialog.Exists() && eVehicleTagDetailLatest.bResult;
    sPassMessage    = "TestCase.Passed. Monthly Checkin done successfully when manual ticket entry is enabled";
    sFailMessage    = "TestCase.Failed. Unexpected behaviour during Monthly CheckIn when Manual ticket entry is enabled ";
      
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);        
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
  objCheckInVehicleDamageForm = null;
  objUserInfoForm = null;
  objPrinterStatusForm = null;
  objNavigationPanelForm = null;           
  objTechnicianMenuForm = null;
  objCheckInTicketNumberForm = null;
  objManualDateInformationDateForm = null;
  objCheckInCustomerInfoForm = null;
  
}
  
function TC_MONTH_CHKN_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_006 : Verify the screen gets back to the home screen when 'Cancel' button is clicked. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  
  var bTestCaseResult; //Boolean variable to store TestCase result
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }

    objTestData = { sVehicleTag : eTagNumberDetail.sVehicleTag }; //TestData object to check in a monthly customer vehicle
    
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
    objCheckInCustomerInfoForm.ClickCancel(objTestData.sVehicleTag)
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    TestLog.Message("Step-2:Clicked Cancel button");
    
    objMainDialog   = MainDialog.New();    
     
    //Test Result: Verify the home screen Exists
    //------------------------------------------------
    bTestCaseResult = objMainDialog.Exists();
    sPassMessage    = "TestCase Passed. Navigated to the home screen when Cancel button is clicked from Monthly";
    sFailMessage    = "TestCase Failed. Failed to Navigateto the home screen ";
      
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);          
  }//End try
        
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;

}


function TC_MONTH_CHKN_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_007 : Validating Transaction time out for monthly Customer. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  try{ 
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
    Delay(150000);
      
    TestLog.Message("The screen is kept inactive for 2.5 minutes")
    objMainDialog   = MainDialog.New();
      
    //Test Result: Verify the home screen Exists
    //-------------------------------------
    bTestCaseResult = objMainDialog.Exists();
    sPassMessage    = "TestCase Passed. Navigated to the home screen if monthly checkin scren is kept inactive for 2.5 minutes";
    sFailMessage    = "TestCase Failed. Failed to Navigateto the home screen ";
      
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);    
      
  }//End try
        
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
  objCheckInCustomerInfoForm = null;
}

function TC_MONTH_CHKN_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_CHKN_EMP_008 : Verify that a proper error message is displayed when the customer tag is soft deleted in the DB.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of objMainDialog screen
  var objCheckInCustomerInfoForm; //Stores the instance of Customer info Screen
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var actualErrorMessage;//Stores the error message to be dispalyed
  var expectedErrorMessage ="TAG NUMBER ENTERED IS NOT VALID."; //Stores the expected error message 
  var bTestCaseResult;//Boolean variable to store TestCase result
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }

    objTestData = { sVehicleTag : eTagNumberDetail.sVehicleTag }; //TestData object to check in a monthly customer vehicle
   
    SQLQueries.updateVehicleTagStatus(objTestData.sVehicleTag,1);
      
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into Customer info screen and submit vehicle tag
    //--------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly  button.");
      
    //Initialize object of CustomerInfoScreen 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle Tag field and click Enter button from Navigation panel
    actualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.sVehicleTag)
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to Customer Info screen and submitted sof deleted vehicle Tag");
      
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = actualErrorMessage === expectedErrorMessage;
    sPassMessage    = "Testcase Passed. Expected error is displayed for soft deleted tag number.";
    sFailMessage    = "TestCase Failed. Unexpected/No error Message is displayed.";
      
    //Assert Result 
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);
    
    SQLQueries.updateVehicleTagStatus(objTestData.sVehicleTag,0);
      
  }//End try
        
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess();
    Log.PopLogFolder();
  } //End finally

  //Disposing objects 
  objMainDialog = null;
  objCheckInCustomerInfoForm = null;
}

  
  







