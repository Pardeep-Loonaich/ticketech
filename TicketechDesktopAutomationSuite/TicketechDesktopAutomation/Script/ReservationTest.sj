//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT MainDialog
//USEUNIT NavigationPanelForm
//USEUNIT UserInfoForm
//USEUNIT ReservationMenuForm
//USEUNIT ReservationsInquiryReportParametersForm
//USEUNIT H6000IIPrinterForm
//USEUNIT PrepaymentsTableTimeSegmentForm
//USEUNIT SelectOptionForm

var eReservationUser = SQLQueries.userLoginDetails("ReservationUser");

function TC_RESERVATION_INQ_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_INQ_001 : Verify the reservation report is printed when valid credentials are given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objH6000IIPrinterForm;
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objReservationsInquiryReportParametersForm;//variable to store ReservationsInquiryReportParametersForm
  var objUserInfo;//variable to store UserInfoForm
  
  var eReservationDetails = SQLQueries.insertAndReturnNewReservationBarcode();

  try {
  
    objTestData = { 
                     sBarcode  : eReservationDetails.sPReservationBarcode,
                     sFirstname: eReservationDetails.sFirstName,
                     sLastname : eReservationDetails.sLastName                                          
                  }; //TestData object for reservation inquiry
                  
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password   
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    
    TestLog.Message("Clicked Log In button.");      
     
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Step-3: Navigate to Reservation menu screen
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();     
    //click Reservation Inquiry button
    objReservationMenuForm.ClickReservationInquiry();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
    
    TestLog.Message("Clicked Reservation Inquiry button.");
      
    //Fill and Submit reservation inquiry form
    objReservationsInquiryReportParametersForm = ReservationsInquiryReportParametersForm.New();
    //Get latest barocde, firstname and lastname entry from parkingReservations table
    objReservationsInquiryReportParametersForm.FillAndSubmitReservationInquiry(objTestData);     
    if (objReservationsInquiryReportParametersForm.lastError.name !== undefined) 
      throw objReservationsInquiryReportParametersForm.lastError;
    
    TestLog.Message("Filled and Submited reservation inquiry form");
    
    //Initialize object of H6000IIPrinterForm 
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the reservation report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The reservation report Available";
    sFailMessage    = "Test Failed. The reservation report not available";
    
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
  objReservationMenuForm = null;
  objReservationsInquiryReportParametersForm = null;
  objH6000IIPrinterForm = null;
  objUserInfo = null; 
    
} //TC_RESERVATION_INQ_001


function TC_RESERVATION_INQ_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_INQ_002 : Verify the error message is displayed when invalid bar code is given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objReservationsInquiryReportParametersForm;//variable to store ReservationsInquiryReportParametersForm
  var objUserInfo;//variable to store UserInfoForm
  
  var bTestCaseResult;//Boolean variable to store TestCase result
  var expectedErrorMessage = "RESERVATION DOES NOT EXIST.";
  var actualErrorMessage;
    
  var eReservationDetails = SQLQueries.insertAndReturnNewReservationBarcode();
     
  try {
  
    objTestData = { 
                    sBarcode  : Utility.getRandomValue("ALPHANUMERIC",10)
                   ,sFirstname: eReservationDetails.sFirstName
                   ,sLastname : eReservationDetails.sLastName                                          
                  }; //TestData object for reservation inquiry
                
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password   
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    
    TestLog.Message("Clicked Log In button.");      
     
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Step-3: Navigate to Reservation menu screen
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();     
    //click Reservation Inquiry button
    objReservationMenuForm.ClickReservationInquiry();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
    
    TestLog.Message("Clicked Reservation Inquiry button.");
      
    //Fill and Submit reservation inquiry form
    objReservationsInquiryReportParametersForm = ReservationsInquiryReportParametersForm.New();
    
    //Get latest barocde, firstname and lastname entry from parkingReservations table
    objReservationsInquiryReportParametersForm.FillAndSubmitReservationInquiry(objTestData); 
    if (objReservationsInquiryReportParametersForm.lastError.name !== undefined) throw objReservationsInquiryReportParametersForm.lastError;    
      
    //Get actual error message from reservation inquiry report info screen
    objReservationsInquiryReportParametersForm.Refresh();
    actualErrorMessage = objReservationsInquiryReportParametersForm.GetFooterMessage();
      
    // Verify correct error message exists on screen       
    TestLog.Message("Verified "+expectedErrorMessage+" message exists on screen");
    
    //TestCase Result : To verify that the correct error message displays on entering invalid barcode on reservation inquiry report info screen
    bTestCaseResult = (actualErrorMessage === expectedErrorMessage); 
    sPassMessage    = "Test Passed. The error message displayed for invalid barcode";
    sFailMessage    = "Test Failed. The error message not displayed";
    
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
  objReservationMenuForm = null;
  objReservationsInquiryReportParametersForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_INQ_002

function TC_RESERVATION_INQ_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_INQ_003 : Verify the error message is displayed when invalid first name is given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objReservationsInquiryReportParametersForm;//variable to store ReservationsInquiryReportParametersForm
  var objUserInfo;//variable to store UserInfoForm
  
  var expectedErrorMessage = "RESERVATION DOES NOT EXIST.";
  var actualErrorMessage = null;
  
  var eReservationDetails = SQLQueries.insertAndReturnNewReservationBarcode();
    
  objTestData = { 
                     sBarcode  : eReservationDetails.sBarcode,
                     sFirstname: Utility.getRandomValue("ALPHA",7),
                     sLastname : eReservationDetails.sLastname                                          
                }; //TestData object for reservation inquiry
   
  try {
  
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password   
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    
    TestLog.Message("Clicked Log In button.");      
     
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Step-3: Navigate to Reservation menu screen
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New(); 
        
    //click Reservation Inquiry button
    objReservationMenuForm.ClickReservationInquiry();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
    
    TestLog.Message("Clicked Reservation Inquiry button.");
      
    //Fill and Submit reservation inquiry form
    objReservationsInquiryReportParametersForm = ReservationsInquiryReportParametersForm.New();
    
    //Get latest barocde, firstname and lastname entry from parkingReservations table
    objReservationsInquiryReportParametersForm.FillAndSubmitReservationInquiry(objTestData);
    if (objReservationsInquiryReportParametersForm.lastError.name !== undefined) throw objReservationsInquiryReportParametersForm.lastError;
    
    TestLog.Message("Filled and Submited reservation inquiry form");     
      
    //Get actual error message from reservation inquiry report info screen
    objReservationsInquiryReportParametersForm.Refresh();
    actualErrorMessage = objReservationsInquiryReportParametersForm.GetFooterMessage();
      
    // Verify correct error message exists on screen       
    TestLog.Message("Verified "+expectedErrorMessage+" message exists on screen");
    
    //TestCase Result : To verify that the correct error message displays on entering invalid barcode on reservation inquiry report info screen
    bTestCaseResult = (actualErrorMessage === expectedErrorMessage); 
    sPassMessage    = "Test Passed. The error message displayed for invalid firstname";
    sFailMessage    = "Test Failed. The error message not displayed";
    
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
  objReservationMenuForm = null;
  objReservationsInquiryReportParametersForm = null;
  objUserInfo = null;   
  
} //TC_RESERVATION_INQ_003


function TC_RESERVATION_INQ_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_INQ_004 : Verify the error message is displayed when invalid last name  is given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objReservationsInquiryReportParametersForm;//variable to store ReservationsInquiryReportParametersForm
  var objUserInfo;//variable to store UserInfoForm
  var expectedErrorMessage = "RESERVATION DOES NOT EXIST.";
  var actualErrorMessage = null;
  
  var eReservationDetails = SQLQueries.insertAndReturnNewReservationBarcode();
    
  objTestData = { 
                     sBarcode  : eReservationDetails.sBarcode,
                     sFirstname: eReservationDetails.sFirstname,
                     sLastname : Utility.getRandomValue("ALPHA",7)                                         
                }; //TestData object for reservation inquiry
   
  try {
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password   
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    
    TestLog.Message("Clicked Log In button.");      
     
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Step-3: Navigate to Reservation menu screen
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New(); 
  
    //click Reservation Inquiry button
    objReservationMenuForm.ClickReservationInquiry();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
    
    TestLog.Message("Clicked Reservation Inquiry button.");
      
    //Fill and Submit reservation inquiry form
    objReservationsInquiryReportParametersForm = ReservationsInquiryReportParametersForm.New();
    //Get latest barocde, firstname and lastname entry from parkingReservations table
    objReservationsInquiryReportParametersForm.FillAndSubmitReservationInquiry(objTestData);
    if (objReservationsInquiryReportParametersForm.lastError.name !== undefined) throw objReservationsInquiryReportParametersForm.lastError;
    TestLog.Message("Filled and Submited reservation inquiry form");     
      
    //Get actual error message from reservation inquiry report info screen
    objReservationsInquiryReportParametersForm.Refresh();
    actualErrorMessage = objReservationsInquiryReportParametersForm.GetFooterMessage();
      
    // Verify correct error message exists on screen       
    TestLog.Message("Verified "+expectedErrorMessage+" message exists on screen");
    
    //TestCase Result : To verify that the correct error message displays on entering invalid barcode on reservation inquiry report info screen
    bTestCaseResult = (actualErrorMessage === expectedErrorMessage); 
    sPassMessage    = "Test Passed. The error message displayed for invalid lastname";
    sFailMessage    = "Test Failed. The error message not displayed";
    
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
  objReservationMenuForm = null;
  objReservationsInquiryReportParametersForm = null;
  objUserInfo = null;   
  
} //TC_RESERVATION_INQ_004

function TC_RESERVATION_DLY_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_DLY_005 : Verify the daily report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  //var currentTime = aqDateTime.Time();
  //var endTime = aqDateTime.AddHours(currentTime,10)
  
  objTestData = { starttime: "0100", endtime: "0500" }; //TestData object for reservation inquiry   
          
  try {
    
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;  
      
    TestLog.Message("Clicked Log In button.");    
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //click Daily Reservation button
    objReservationMenuForm.ClickDailyReservation();
      
    //Fill start and end time to print report
    objPrepaymentsTableTimeSegmentForm = PrepaymentsTableTimeSegmentForm.New();
    
    //Enter start and end time to print daily report
    objPrepaymentsTableTimeSegmentForm.EnterTimeSegment(objTestData);     
    if (objPrepaymentsTableTimeSegmentForm.lastError.name !== undefined) throw objPrepaymentsTableTimeSegmentForm.lastError; 
       
    //Initialize object of H6000IIPrinterForm
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the reservation report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The daily reservation report Available";
    sFailMessage    = "Test Failed. The daily reservation report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;  
   
} //TC_RESERVATION_DLY_005


function TC_RESERVATION_EVNT_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_EVNT_006 : Verify the event reservation report is printed.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
        
  try {
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    TestLog.Message("Step-1: Clicked Log In button.");     
             
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+eReservationUser.username); 
            
    //Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click Event Reservation button
    objReservationMenuForm.ClickEventReservation();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
      
    //Click All button on Oprion List panel
    objSelectOptionForm = SelectOptionForm.New();
    objSelectOptionForm.SelectAll();     
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the event reservation report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.ClickCancel()); 
    sPassMessage    = "Test Passed. The event reservation report Available";
    sFailMessage    = "Test Failed. The event reservation report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_EVNT_006


//function TC_RESERVATION_EVNT_007() {
//  
///*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//  TC_RESERVATION_EVNT_007 : Verify the Event Reservation report is not printed.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//
//  //Variable Declaration 
//  //---------------------
//  var objMainDialog; //Stores the instance of MainDialog
//  var bTestCaseResult;//Boolean variable to store TestCase result
//  var objReservationMenuForm;//variable to store ReservationMenuForm
//  var objReservationsInquiryReportParametersForm;//variable to store ReservationsInquiryReportParametersForm
//  var objUserInfo;//variable to store UserInfoForm
//  var objH6000IIPrinterForm;  
//  var objReservationMenuForm;
//  var objNavigationPanelForm;
//  
//   objTestData = { username: "ADMINISTRATOR",
//                     password: "POSTICKETECH"                          
//                   }; //TestData object for All event reservation report          
////    try {
////      //Step-1: Launching the POS application and Initialize the objMainDialog screen
////      //--------------------------------------------------------------------
////      Utility.launchApp();
////      objMainDialog = MainDialog.New();
////
////       //Step-2: Navigate into user info screen and submit username and password
////      TestLog.Message("Step-1: Clicked Log In button.");    
////      objMainDialog.NavigateToUserInfoScreen();
////      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
////      
////      //Initialize object of UserInfoForm       
////      TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.UserName); 
////      //Set data in Username and Password field and click Enter button from Navigation panel
////      objUserInfo = UserInfoForm.New();
////      objUserInfo.InputAndSubmitForm(objTestData);
////      if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
////            
////      //Step-3: Navigate to Reservation menu screen
////      Delay(1000);
////      objMainDialog = MainDialog.New();
////      objMainDialog.NavigateToReservationMenu();
////      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
////      
////      TestLog.Message("Step-3: Clicked Reservation Menu button.");
////      
////      //Initialize object of ReservationMenuForm 
////      objReservationMenuForm = ReservationMenuForm.New();
////      
////      //Click Event Reservation button
////      objReservationMenuForm.ClickEventReservation();
////      if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
////      
////      //Click Enter button on Navigation Panel Form
////      objNavigationPanelForm = NavigationPanelForm.New();
////      objNavigationPanelForm.ClickEnter();     
////          
////      objH6000IIPrinterForm = H6000IIPrinterForm.New();
////      
////      TestLog.Message("Step-4: Verified "+objH6000IIPrinterForm+" Window not exist");
////    
////      //TestCase Result : To verify that the event reservation report printer popup is not available
////      bTestCaseResult = (!objH6000IIPrinterForm.Exists()); 
////      sPassMessage    = "Test Passed. The event reservation report not Available";
////      sFailMessage    = "Test Failed. The event reservation report is available";
////    
////      //Assert Result
////      Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);                   
////      
////  } //End try
////        
////     catch(exception) {
////      TestLog.Error(exception.description, Utility.formattedException(exception));
////    } //End catch
////    
////    finally {
////      //Close the POS Application
////      Utility.closePOSProcess();  
////      Log.PopLogFolder();
////    } //End finally
//      
//  //Disposing objects 
//  objMainDialog = null;
//  objReservationMenuForm = null;
//  objReservationsInquiryReportParametersForm = null;
//  objUserInfo = null;   
//} //TC_RESERVATION_EVNT_007


function TC_RESERVATION_NV_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_NV_008 : Verify the non valid reservation report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
          
  try {
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password
    TestLog.Message("Clicked Log In button.");    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click Non-Valid Reservation button
    objReservationMenuForm.ClickNonValidReservation();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the non-valid reservation report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The non-valid reservation report Available";
    sFailMessage    = "Test Failed. The non-valid reservation report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_NV_008

function TC_RESERVATION_OR_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_OR_009 : Verify the open reservation report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
           
  try {
    // Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    // Navigate into user info screen and submit username and password
    TestLog.Message(" Clicked Log In button.");    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    // Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message(" Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click Open Reservation button
    objReservationMenuForm.ClickOpenReservation();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the Open reservation report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The Open reservation report Available";
    sFailMessage    = "Test Failed. The Open reservation report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_OR_009

function TC_RESERVATION_ORP_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_ORP_010 : Verify the current reservation  by provider report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
          
  try {
  
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Navigate into user info screen and submit username and password    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
     
    TestLog.Message("Clicked Log In button.");    
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click Open Reservation By Provider button
    objReservationMenuForm.ClickOpenReservationByProvider();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message(" Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the Open reservation by provider report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The Open reservation by provider report Available";
    sFailMessage    = "Test Failed. The Open reservation by provider report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_ORP_010

function TC_RESERVATION_CR_011() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_CR_011 : Verify the closed reservation report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
            
  try {
    // Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

     //Step-2: Navigate into user info screen and submit username and password
    TestLog.Message(" Clicked Log In button.");    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click Closed Reservation button
    objReservationMenuForm.ClickClosedReservation();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the Close reservation report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The Close reservation report Available";
    sFailMessage    = "Test Failed. The Close reservation report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_CR_011

function TC_RESERVATION_CURRENT_RES_012() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_CURRENT_RES_012 : Verify the current reservation  by provider report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
           
  try {
    // Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

     // Navigate into user info screen and submit username and password
    TestLog.Message(" Clicked Log In button.");    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    // Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click Current Reservation button
    objReservationMenuForm.ClickCurrentReservation();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the Current Reservation Report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The Current reservation report Available";
    sFailMessage    = "Test Failed. The Current reservation report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_CURRENT_RES_012

function TC_RESERVATION_CRP_013() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RESERVATION_CRP_013 : Verify the close reservation report is printed when the button is clicked.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var bTestCaseResult;//Boolean variable to store TestCase result
  var objReservationMenuForm;//variable to store ReservationMenuForm
  var objUserInfo;//variable to store UserInfoForm
  var objH6000IIPrinterForm;  
  var objReservationMenuForm;
         
  try {
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

     //Step-2: Navigate into user info screen and submit username and password
    TestLog.Message("Step-1: Clicked Log In button.");    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(eReservationUser);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
    
    TestLog.Message("Navigated to UserInfo screen and Logged in as "+eReservationUser.username);
            
    //Step-3: Navigate to Reservation menu screen
    Delay(1000);
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToReservationMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Reservation Menu button.");
      
    //Initialize object of ReservationMenuForm 
    objReservationMenuForm = ReservationMenuForm.New();
      
    //Click closed reservation by provider button
    objReservationMenuForm.ClickClosedReservationByProvider();
    if (objReservationMenuForm.lastError.name !== undefined) throw objReservationMenuForm.lastError;
          
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-4: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify that the Closed Reservation By Provider Report printer popup is available
    bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
    sPassMessage    = "Test Passed. The Closed Reservation By Provider report Available";
    sFailMessage    = "Test Failed. The Closed Reservation By Provider report not available";
    
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
  objReservationMenuForm = null;
  objUserInfo = null;   
} //TC_RESERVATION_CRP_013