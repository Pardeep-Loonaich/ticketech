//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT XMLReader
//USEUNIT MainDialog
//USEUNIT CheckInCustomerInfoForm
//USEUNIT CheckInCustomerVehicleForm
//USEUNIT CheckInVehicleDamageForm
//USEUNIT PrinterStatusForm
//USEUNIT NavigationPanelForm
//USEUNIT TechnicianMenuForm
//USEUNIT CheckInTicketNumberForm
//USEUNIT ManualDateInformationDateForm
//USEUNIT UserInfoForm
//USEUNIT VehicleInfoForm
//USEUNIT CheckInVehicleInfoColorForm
//USEUNIT CheckInVehicleInfoMakeForm
//USEUNIT TicketNumberForm

function TC_REPLACE_VEHICLE_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_001 : Verify Check In ticket is printed when valid tag number is given and 'No' button is clicked for Damaged Vehicle Confirmation Form
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objPrinterStatusForm;//Stores the instance of Printer Status Form
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag,
                    sPlateNumber : Utility.getRandomValue("NUMERIC", 7),
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo","Other"])                                          
                  }; //TestData object to replace a check in vehicle
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
    
    TestLog.Message("Step-2: Submitted Valid Vehicle Tag.");
      
    //Click Other vehicle to checkin
    objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    objCheckInCustomerVehicleForm.SelectOtherVehicle();
    if (objCheckInCustomerVehicleForm.lastError.name !== undefined) throw objCheckInCustomerVehicleForm.lastError;
    
    TestLog.Message("Step-3: Clicked Other vehicle to checkin.");
      
    //Enter vehicle information for vehicle replace checkin.       
    objVehicleInfoForm = VehicleInfoForm.New();
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    TestLog.Message("Step-4: Entered vehicle Plate number, selected color and Make.");
      
    //Click No for vehicle damage confirmation.
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
    objCheckInVehicleDamageForm.ConfirmNo();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
    
    TestLog.Message("Step-5: Click No button to confirm vehicle not damage");
      
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    TestLog.Message("Step-6: Click Cancel button on Printer Status Window");
      
    //TestCase Result: Verify user navigated back to Main screen and Details added to DB
    bTestCaseResult = objMainDialog.Exists() && SQLQueries.getLastAddedReplaceDetails(objTestData.sVehicleTag).bResult;
    sPassMessage    = "Test Passed. Check In Successful for the Alternate Vehicle with TagNumber "+objTestData.sVehicleTag;
    sFailMessage    = "Test Passed. Unexpected behaviour during Replace vehicle CheckIn";  
      
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);     
      
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
  objCheckInCustomerInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;
  
} //TC_REPLACE_VEHICLE_001


function TC_REPLACE_VEHICLE_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_002 : Verify a proper message is displayed  by giving a vehicle tag which is already checked in.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  
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

    objTestData = { sVehicleTag : eTagNumberDetail.sVehicleTag }; //TestData object to check in a replace vehicle
   
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    actualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;            
  
    TestLog.Message("Step-2: Submited Already Checked In Vehicle Tag.");

    //TestCase Result: Verify proper error message displayed on giving a vehicle tag which is already checked in
    bTestCaseResult = aqString.StrMatches(expectedErrorMessage, actualErrorMessage);
    sPassMessage    = "TestCase Passed. Expected Error message displayed for already checked in tag number";
    sFailMessage    = "TestCase Failed. Unexpected/No error message displayed for already checked in tag number";
    
    TestLog.Message("Error Message displayed: "+actualErrorMessage);

    //Assert Result 
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objCheckInCustomerInfoForm = null;

} //TC_REPLACE_VEHICLE_002


function TC_REPLACE_VEHICLE_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_003 : Verify proper message is displayed when invalid vehicle tag is given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var expectedErrorMessage = "TAG NUMBER ENTERED IS NOT VALID."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed 
  
  try {
     
    objTestData = {
                    sVehicleTag : Utility.getRandomString(["X1","","000001"])
                  }; //TestData object to replace a check in vehicle
     
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    actualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;            
    
    TestLog.Message("Error Message displayed: "+actualErrorMessage);
    // Verify proper error message displayed on giving invalid vehicle tag
    Utility.assertResult( actualErrorMessage === expectedErrorMessage
                         ,"Test Passed. Expected Error message displayed for invalid tag number"
                         ,"Test Failed. Unexpected/No error message displayed for invalid tag number"
                        );      
     
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
  objCheckInCustomerInfoForm = null;

} //TC_REPLACE_VEHICLE_003


function TC_REPLACE_VEHICLE_004() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_004 : Verify the screen gets back to the home page when screen is kept inactive for 3 minutes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form 
  
  try {

    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
            
    //Wait for specified time
    Delay(180000);            

    //Initialize the objMainDialog screen
    objMainDialog = MainDialog.New();
    // Verify user naviagted back to home screen
    Utility.assertResult( objMainDialog.Exists()
                         ,"Test Passed. Screen returned to the home page after keeping inactive for 3 minutes"
                         ,"Test Failed. Screen not returned to the home page after keeping inactive for 3 minutes");      
     
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
  objCheckInCustomerInfoForm = null;

} //TC_REPLACE_VEHICLE_004


function TC_REPLACE_VEHICLE_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_005 : Verify the field does not move to the next field when given 
                           empty value in the 'Plate Field'.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag,
                    sPlateNumber : ""                                          
                  }; //TestData object to replace a check in vehicle

    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    //click Other vehicle to checkin
    objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    objCheckInCustomerVehicleForm.SelectOtherVehicle();
    if (objCheckInCustomerVehicleForm.lastError.name !== undefined) throw objCheckInCustomerVehicleForm.lastError;
    
    TestLog.Message("Step-2: Clicked Other vehicle to checkin.");
      
    // Enter vehicle plate for vehicle replace checkin.       
    objVehicleInfoForm = VehicleInfoForm.New();
    objVehicleInfoForm.provideVehiclePlate(objTestData.sPlateNumber);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    TestLog.Message("Step-3: Clicked enter button Providing Empty Vehicle Plate nnumber");

    // Initialize object of CheckInVehicleInfoColorForm
    objCheckInVehicleInfoColorForm = CheckInVehicleInfoColorForm.New();      

    // Verify user color panel not displayed
    Utility.assertResult( !objCheckInVehicleInfoColorForm.Exists()
                         ,"Test Passed. Vehicle color panel has not appeared without Entering Plate Number"
                         ,"Test Failed. Unexpected behaviour OR Vehicle Plate might not be a required field"); 
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
  objCheckInCustomerVehicleForm = null;
  objVehicleInfoForm = null;
  objCheckInVehicleInfoColorForm = null;

} //TC_REPLACE_VEHICLE_005


function TC_REPLACE_VEHICLE_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_006 : Verify the field does not move to the next field when given 
                           empty value in the vehicle 'color'.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  var objNavigationPanelForm;//Variable to store NavigationPanelForm
  var objCheckInVehicleInfoMakeForm;//Varible to store CheckInVehicleInfoMakeForm
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag,
                    sPlateNumber : Utility.getRandomValue("NUMERIC", 7)
                  }; //TestData object to replace a check in vehicle
     
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    //click Other vehicle to checkin
    objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    objCheckInCustomerVehicleForm.SelectOtherVehicle();
    if (objCheckInCustomerVehicleForm.lastError.name !== undefined) throw objCheckInCustomerVehicleForm.lastError;
    
    TestLog.Message("Step-2: Clicked Other vehicle to checkin.");
      
    // Enter vehicle plate for vehicle replace checkin.       
    objVehicleInfoForm = VehicleInfoForm.New();
    objVehicleInfoForm.provideVehiclePlate(objTestData.sPlateNumber);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    TestLog.Message("Step-3: Entered Valid vehicle Plate number");
      
    // Without selecting vehicle color, click enter button.       
    objNavigationPanelForm = NavigationPanelForm.New();
    objNavigationPanelForm.ClickEnter();
    if (objNavigationPanelForm.lastError.name !== undefined) throw objNavigationPanelForm.lastError;
    
    TestLog.Message("Step-4: Clicked Enter button without selecting Color");
      
    // Initialize object of CheckInVehicleInfoMakeForm
    objCheckInVehicleInfoMakeForm = CheckInVehicleInfoMakeForm.New();      

    // Verify Make panel not displayed
    Utility.assertResult( !objCheckInVehicleInfoMakeForm.Exists()
                          ,"Test Passed. Vehicle Make panel has not appeared without selecting vehicle color"
                          ,"Test Failed. Unexpeced behaviour OR Vehicle Color might not be a required field"
                        );
     
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
  objCheckInCustomerVehicleForm = null;
  objVehicleInfoForm = null;
  objCheckInVehicleInfoMakeForm = null;

} //TC_REPLACE_VEHICLE_006


function TC_REPLACE_VEHICLE_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_007 : Verify the field does not move to the next field when given 
                           empty value in the vehicle 'Make'.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  var objNavigationPanelForm;//Variable to store NavigationPanelForm
  var objCheckInVehicleInfoMakeForm;//Varible to store CheckInVehicleInfoMakeForm
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag,
                    sPlateNumber : Utility.getRandomValue("NUMERIC", 7),
                    sColor       : SQLQueries.getRandomVehicleColor().sColor
                  }; //TestData object to replace a check in vehicle
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    //click Other vehicle to checkin
    objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    objCheckInCustomerVehicleForm.SelectOtherVehicle();
    if (objCheckInCustomerVehicleForm.lastError.name !== undefined) throw objCheckInCustomerVehicleForm.lastError;
    
    TestLog.Message("Step-2: Clicked Other vehicle to checkin.");
      
    // Enter vehicle plate for vehicle replace checkin.       
    objVehicleInfoForm = VehicleInfoForm.New();
    objVehicleInfoForm.provideVehiclePlate(objTestData.sPlateNumber);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    TestLog.Message("Step-3: Entered vehicle Plate number");
      
    // Select vehicle color, click enter button.       
    objCheckInVehicleInfoColorForm = CheckInVehicleInfoColorForm.New();
    objCheckInVehicleInfoColorForm.provideVehicleColor(objTestData.sColor);    
    if (objCheckInVehicleInfoColorForm.lastError.name !== undefined) throw objCheckInVehicleInfoColorForm.lastError;
    
    TestLog.Message("Step-4: Selected vehicle color");                          
      
    // Initialize object of CheckInVehicleInfoMakeForm
    objCheckInVehicleInfoMakeForm = CheckInVehicleInfoMakeForm.New();
    bMakePanelExist = objCheckInVehicleInfoMakeForm.Exists();
    if (objCheckInVehicleInfoMakeForm.lastError.name !== undefined) throw objCheckInVehicleInfoMakeForm.lastError;
      
    // Click Enter button
    objNavigationPanelForm = NavigationPanelForm.New();
    objNavigationPanelForm.ClickEnter();    
    if (objNavigationPanelForm.lastError.name !== undefined) throw objNavigationPanelForm.lastError;
    
    TestLog.Message("Step-5: Clicked Enter without selecting Vehicle Make");  
      
    // Initialize object of objCheckInVehicleDamageForm 
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();  

    // Verify Make panel not displayed
    Utility.assertResult( (bMakePanelExist && !objCheckInVehicleDamageForm.Exists())
                          ,"Test Passed. Vehicle Damage Form has not appeared without selecting vehicle Make"
                          ,"Test Failed. Unexpeced behaviour OR Vehicle Make might not be a required field"
                        );
     
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
  objCheckInCustomerVehicleForm = null;
  objVehicleInfoForm = null;
  objCheckInVehicleInfoMakeForm = null;
  objCheckInVehicleDamageForm = null;

} //TC_REPLACE_VEHICLE_007


function TC_REPLACE_VEHICLE_008() {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_008 : Verfiy the Replace button is enabled/disabled as per Policy  document
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of UserInfoForm
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
   
  try { 
    
    bReplaceEnabled = XMLReader.getXMLData("//Replacements/Enabled/Value");
    
    eReplaceUserDetails = SQLQueries.userLoginDetails("CheckInReplacement");
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Employee ID field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(eReplaceUserDetails);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+eReplaceUserDetails.username);
    
    objMainDialog = MainDialog.New();
    
    bButtonExists = objMainDialog.NavigateToReplaceScreen();
    
    TestLog.Message("Replace Set as Enabled = "+bReplaceEnabled[0]+" in Policy File; Is Replace available in App = "+bButtonExists);
    
    // Verify Make panel not displayed
    
    Utility.assertResult( (aqString.ToUpper(bButtonExists) === aqString.ToUpper(bReplaceEnabled[0]))
                          ,"Test Passed. Replace button set in application as set in Policy File"
                          ,"Test Failed. Replace button not set as per policy document"
                        );
     
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

} //TC_REPLACE_VEHICLE_008



//function TC_REPLACE_VEHICLE_009() {-- Skipped
//  
///*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  TC_REPLACE_VEHICLE_009 : Verify replacement can be done for a newly added monthly customer.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//// TODO - Option not available to add new monthly customer in this configuration - Pardeep
// 
//} //TC_REPLACE_VEHICLE_009

//TC_REPLACE_VEHICLE_010 --Skipped



function TC_REPLACE_VEHICLE_011() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_011 : Verify existing customer is able to check in with the alternate vehicle that the customer already have
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objPrinterStatusForm;//Stores the instance of Printer Status Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag                                          
                  }; //TestData object to replace a check in vehicle

    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();     
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);      
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;   
      
    TestLog.Message("Step-2: Entered Vehicle Tag in Customer Info form");
      
    //click first vehicle to checkin from customer vehicle grid
    objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    objCheckInCustomerVehicleForm.SelectFirstVehicle();
    if (objCheckInCustomerVehicleForm.lastError.name !== undefined) throw objCheckInCustomerVehicleForm.lastError; 
             
    TestLog.Message("Step-3: Clicked first vehicle to checkin.");
      
    //Click No for vehicle damage confirmation.
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
    objCheckInVehicleDamageForm.ConfirmNo();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    TestLog.Message("Step-4: Click No button to confirm vehicle not damage");
      
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
      
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
      
    //TestCase Result: Verify user navigated back to Main screen and Details added to DB
    bTestCaseResult = objMainDialog.Exists() && SQLQueries.getLastAddedReplaceDetails(objTestData.sVehicleTag).bResult;
    sPassMessage    = "Test Passed. Check In Successful with available Alternate Vehicle with TagNumber "+objTestData.sVehicleTag;
    sFailMessage    = "Test Passed. Unexpected behaviour during Replace vehicle CheckIn";  
      
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
  objCheckInCustomerInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;

} //TC_REPLACE_VEHICLE_011


function TC_REPLACE_VEHICLE_012() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_012 : Verify the present screen gets back to the home page when 'Cancel' button is pressed.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag                                          
                  }; //TestData object to replace a check in vehicle

    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen and submit valid vehicle tag
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();     
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.ClickCancel(objTestData.VehicleTag);      
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;         

    //Verify user navigated back to Main screen
    Utility.assertResult( objMainDialog.Exists()
                         ,"Test Passed. Returns back to Main screen after clicking Cancel during Replace checkin"
                         ,"Test Failed. Unexpected behaviour during Replace Cancel");            
                
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
  objCheckInCustomerInfoForm = null;
  
} //TC_REPLACE_VEHICLE_012


function TC_REPLACE_VEHICLE_013() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_013 : Verify the present screen gets back to the home page when 'Cancel' button is pressed on Damage confirmation form.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objCheckInCustomerInfoForm; //Stores the instance of Employee Info Form
  var objCheckInVehicleDamageForm;//Stores the instance of CheckInVehicleDamage Form
  var objPrinterStatusForm;//Stores the instance of Printer Status Form
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();
   
  try { 
    
    if(!eTagNumberDetail.bResult) {
      exception = { name        : "Data Exception",
                    description : "No Vehicle Tag Available in DB",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = { 
                    sVehicleTag  : eTagNumberDetail.sVehicleTag,
                    sPlateNumber : Utility.getRandomValue("NUMERIC", 7),
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo","Other"])                                          
                  }; //TestData object to replace a check in vehicle
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Navigate into Customer info screen
    objMainDialog.NavigateToReplaceScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Replace button.");
      
    //Initialize object of CheckInCustomerInfoForm 
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
    //Set data in Vehicle tag field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
    
    TestLog.Message("Step-2: Submitted Valid Vehicle Tag.");
      
    //Click Other vehicle to checkin
    objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    objCheckInCustomerVehicleForm.SelectOtherVehicle();
    if (objCheckInCustomerVehicleForm.lastError.name !== undefined) throw objCheckInCustomerVehicleForm.lastError;
    
    TestLog.Message("Step-3: Clicked Other vehicle to checkin.");
      
    //Enter vehicle information for vehicle replace checkin.       
    objVehicleInfoForm = VehicleInfoForm.New();
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    TestLog.Message("Step-4: Entered vehicle Plate number, selected color and Make.");
      
    //Click Cancel button on vehicle damage confirmation screen.
    objNavigationPanelForm = NavigationPanelForm.New();
    objNavigationPanelForm.ClickCancel();
    if (objNavigationPanelForm.lastError.name !== undefined) throw objNavigationPanelForm.lastError;
    
    TestLog.Message("Step-5: Clicked Cancel button on confirm vehicle damage screen");  
            
    // Verify user navigated back to Main screen
    Utility.assertResult( objMainDialog.Exists()
                         ,"Test Passed. Returns back to Main screen after clicking Cancel during Replace checkin"
                         ,"Test Failed. Unexpected behaviour during Replace Cancel"); 
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
  objCheckInCustomerInfoForm = null;
 
} //TC_REPLACE_VEHICLE_013
