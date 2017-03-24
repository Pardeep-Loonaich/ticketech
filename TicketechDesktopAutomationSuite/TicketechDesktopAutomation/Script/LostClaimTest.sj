//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT UserInfoForm
//USEUNIT TicketNumberForm
//USEUNIT CheckOutShowPriceForm
//USEUNIT SQLQueries
//USEUNIT CheckOutChangeRateForm
//USEUNIT CheckOutPaymentCreditCardOfflineForm
//USEUNIT CheckOutPaymentCashForm
//USEUNIT CheckOutSelectPaymentTypeForm
//USEUNIT H6000IIPrinterForm
//USEUNIT CheckOutPaymentNoChargeNoPaymentReasonsForm
//USEUNIT CheckOutPaymentChargeForm
//USEUNIT CheckInCustomerInfoForm
//USEUNIT NavigationPanelForm
//USEUNIT TechnicianMenuForm
//USEUNIT ManualDateInformationDateForm

function TC_LST_CLM_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_001 : Verify that the user can choose to alter the payable amount successfully during 
                   LOST CLAIM via Alternate Rate/Coupons options availble
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPrice Form
  var objCheckOutChangeRateForm;//Stores the instance of CheckOutChange Rate Form
  var objCheckOutPaymentCreditCardOfflineForm;//Stores the instance of CreditCardOfflineForm
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Daily");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Daily Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    //Declaring and initializing Test Data object 
    objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };
                  
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Step-3: Navigate to Ticket Number form and submit ticket number
    //-----------------------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +"; StayRateType: " +eFormDetails.StayRateType);
    
    objCheckOutShowPriceForm.NavigateToAlternateRateScreen();
    if (objCheckOutShowPriceForm.lastError.name !== undefined) throw objCheckOutShowPriceForm.lastError;
    
    TestLog.Message("Step-5: Clicked AlternateRate button in CheckOutShowPriceForm");
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutChangeRateForm = CheckOutChangeRateForm.New();
    
    //Clicks the AudioCommand from ChangeRatePanel
    objCheckOutChangeRateForm.SelectRateType();
    if (objCheckOutChangeRateForm.lastError.name !== undefined) throw objCheckOutChangeRateForm.lastError;
    
    TestLog.Message("Step-6: Clicked AudioCommand button in CheckOutChangeRateForm");
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    eFormCurrDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormCurrDetails.StayPrice +"; StayRateType: " +eFormCurrDetails.StayRateType);
      
    //Navigate to the Credit Card Screen from CheckOutShowPriceForm 
    objCheckOutShowPriceForm.NavigateToCreditCardScreen();
    if (objCheckOutShowPriceForm.lastError.name !== undefined) throw objCheckOutShowPriceForm.lastError;
    
    TestLog.Message("Step-7: Clicked Credit Card in CheckOutShowPriceForm");
    
    //Initialize object for CheckOutPaymentCreditCardOfflineForm
    objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
    //Navigate to the Credit Card Offline form and select the card type
    objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
    if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
    
    TestLog.Message("Step-8: Clicked Card in CheckOutPaymentCreditCardOfflineForm");
    
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    
    TestLog.Message("Step-9: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result : To verify the checkout ticket is printed for the Dialy customers
    bTestCaseResult = objH6000IIPrinterForm.Exists() && SQLQueries.verifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNo);
    sPassMessage    = "Test Passed. The checkout ticket is printed for the daily customer who has paid the alternate rate via Credit Card ";
    sFailMessage    = "Test Failed. Unexpected behaviour";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null; 
  objTicketNumberForm = null;
  objUserInfoForm =  null;
  objCheckOutShowPriceForm = null;
  objCheckOutChangeRateForm= null;
  objCheckOutPaymentCreditCardOfflineForm= null;
  objH6000IIPrinterForm = null;
  
}//TC_LST_CLM_001
 

function TC_LST_CLM_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_002 : verify a valid ticket number can be used to do successful LOST CLAIM for a monthly customer 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPrice Form
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Monthly");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Monthly Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    //Declaring and initializing Test Data object 
    objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Step-3: Navigate to Ticket Number form and submit ticket number
    //-----------------------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +" ");
    
    objNavigationPanelForm = NavigationPanelForm.New();
    
    objNavigationPanelForm.ClickEnter();
    
    //Initialize object for H6000IIPrinter Form   
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result :  To verify the checkout ticket is printed for monthly customers
    bTestCaseResult = objH6000IIPrinterForm.Exists() && SQLQueries.verifyLostClaimDetailsByTicketNumber("Monthly",objTestData.sTicketNo);
    sPassMessage    = "Test Passed. The checkout ticket is printed for the Monthly customer  ";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim for Monthly Customers ";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  objCheckOutShowPriceForm = null;

}//TC_LST_CLM_002


function TC_LST_CLM_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_003 : Verify that the user can choose the NO CAHRGE option during LOST CLAIM 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPrice Form
  var objNoChargePaymentForm;//Stores the instance of NoChargePaymentForm Form
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Daily");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Daily Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }  
  
    //Declaring and initializing Test Data object 
    objTestData = {
                    Description: Utility.getRandomValue("ALPHA", 3),
                    username  : eLostClaimUserDetail.username, 
                    password  : eLostClaimUserDetail.password,
                    sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };
  
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //-----------------------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Select the option "No Charge" from CheckOutShowPriceForm
    objCheckOutShowPriceForm.NavigateToNoChargeScreen();
    if (objCheckOutShowPriceForm.lastError.name !== undefined) throw objCheckOutShowPriceForm.lastError;
    
    TestLog.Message("Step-5: Clicked the No Charge button");
    
    //Initialize object for FormCheckOutPaymentNoChargeNoPaymentReasons Form
    objNoChargePaymentForm = CheckOutPaymentNoChargeNoPaymentReasonsForm.New();
    
    //Select the option "No Charge" from CheckOutPaymentNoChargeNoPaymentReasonsForm
    objNoChargePaymentForm.ClickNoChargeType();
    if (objNoChargePaymentForm.lastError.name !== undefined) throw objNoChargePaymentForm.lastError;
    
    TestLog.Message("Step-6: Clicked No Charge button");
    
    //Set description and click Enter button from Navigation panel
    objNoChargePaymentForm.EnterDescription(objTestData.Description);
    if (objNoChargePaymentForm.lastError.name !== undefined) throw objNoChargePaymentForm.lastError;
      
    TestLog.Message("Step-7: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");     
    
    //Initialize object for H6000IIPrinter Form   
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-8: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
        
    //TestCase Result : To verify the checkout ticket is printed
    bTestCaseResult =  objH6000IIPrinterForm.Exists() && SQLQueries.verifyLostClaimDetailsByTicketNumber("NoCharge",objTestData.sTicketNo); 
    sPassMessage    = "Test Passed. The checkout ticket is printed for the customer with No Charge as an option";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim via No Charge";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  objCheckOutShowPriceForm = null;
  objNoChargePaymentForm   = null;
  objH6000IIPrinterForm    = null;

}//TC_LST_CLM_003


function TC_LST_CLM_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_004 : Verify that the user can pay the amount successfully during LOST CLAIM through the mode of payment in CARD
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPrice Form
  var objCheckOutChangeRateForm;//Stores the instance of CheckOutChange Rate Form
  var objCheckOutPaymentCreditCardOfflineForm;//Stores the instance of CreditCardOfflineForm
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Daily");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Daily Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    //Declaring and initializing Test Data object 
    objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };    
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +" ");
    
    //Navigate to the Credit Card Screen from CheckOutShowPriceForm 
    objCheckOutShowPriceForm.NavigateToCreditCardScreen();
    if (objCheckOutShowPriceForm.lastError.name !== undefined) throw objCheckOutShowPriceForm.lastError;
    
    TestLog.Message("Step-5: Clicked Credit Card in CheckOutShowPriceForm");
    
    //Initialize object for CheckOutPaymentCreditCardOfflineForm
    objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
    //Navigate to the Credit Card Offline form and select the card type
    objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
    if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
    
    TestLog.Message("Step-6: Clicked Card in CheckOutPaymentCreditCardOfflineForm");
    
    //Initialize object for H6000IIPrinterForm
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    
    TestLog.Message("Step-9: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
        
    //TestCase Result : To verify the checkout ticket is printed
    bTestCaseResult =  objH6000IIPrinterForm.Exists()&& SQLQueries.verifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNo); 
    sPassMessage    = "Test Passed. The checkout ticket is printed for the customer with Credit Card as an option";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim via Credit Card";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  objCheckOutShowPriceForm = null;
  objCheckOutPaymentCreditCardOfflineForm  = null;
  objH6000IIPrinterForm    = null;

}//TC_LST_CLM_004


function TC_LST_CLM_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_005 : Verify that the user can pay the amount successfully during LOST CLAIM through the mode of payment as CHARGE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPrice Form
  var objCheckOutPaymentChargeForm;//Stores the instance of CheckOutChange Rate Form
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail    = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail   = SQLQueries.getCheckInTicketDetails("Daily");
  var eCustomerAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Daily Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
  
    //Declaring and initializing Test Data object 
    objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber,
                     sAccountNo : eCustomerAccountDetails.sAccountNo
                  };
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Navigate to the CheckOutCharge Screen by clicking the Charge button
    objCheckOutShowPriceForm.NavigateToChargeScreen();
    if (objCheckOutShowPriceForm.lastError.name !== undefined) throw objCheckOutShowPriceForm.lastError;
    
    TestLog.Message("Step-5: Clicked Charge button in CheckOutShowPriceForm");
    
    //Initialize object for CheckOutPaymentChargeForm
    objCheckOutPaymentChargeForm = CheckOutPaymentChargeForm.New();
    
    //Navigate to the CheckOutPaymentChargeForm and give account number
    objCheckOutPaymentChargeForm.SetAccountNumber(objTestData.sAccountNo);
    if (objCheckOutPaymentChargeForm.lastError.name !== undefined) throw objCheckOutPaymentChargeForm.lastError;
    
    TestLog.Message("Step-6: Entered the valid accoount number in CheckOutPaymentCharge Form");
    
    //Initialize object for H6000IIPrinterForm
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    
    TestLog.Message("Step-7: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
        
    //TestCase Result : To verify the checkout ticket is printed
    bTestCaseResult =  objH6000IIPrinterForm.Exists()&& SQLQueries.verifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNo); 
    sPassMessage    = "Test Passed. The checkout ticket is printed for the customer with Credit Card as an option";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim via Credit Card";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog = null; 
  objTicketNumberForm = null;
  objUserInfoForm = null;
  objCheckOutShowPriceForm = null;
  objCheckOutPaymentChargeForm = null;
  objH6000IIPrinterForm = null;
  
}//TC_LST_CLM_005


//TC_LST_CLM_006 - Skipped
 

function TC_LST_CLM_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_007 : verify a valid TAG number can be used to do successful LOST CLAIM 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckInCustomerInfoForm;//Stores the instance of CheckInCustomerInfoForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail = SQLQueries.userLoginDetails("LostClaimUser");
  
  var eTagNumberDetail     = SQLQueries.getVehicleTagToDoLostClaim();
  
  try {
    
    if (!eTagNumberDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No Monthly TagNumber currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    objTestData = {
                   username    : eLostClaimUserDetail.username, 
                   password    : eLostClaimUserDetail.password,
                   sVehicleTag : eTagNumberDetail.sVehicleTag
                  };//Declaring and initializing Test Data object 
      
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    objTicketNumberForm.NavigateToTagNumber();
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
    
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objCheckInCustomerInfoForm.InputAndSubmitForm(objTestData.sVehicleTag);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered  with the tag number "+objTestData.sTagNumber);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +" ");
    
    objNavigationPanelForm = NavigationPanelForm.New();
    
    objNavigationPanelForm.ClickEnter();
    
    //Initialize object for H6000IIPrinter Form   
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
         
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result :  To verify the checkout ticket is printed for monthly customers
    bTestCaseResult =  objH6000IIPrinterForm.Exists();
    sPassMessage    = "Test Passed. The checkout ticket is printed for the Monthly customer  ";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim for Monthly Customers ";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {

    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  
}//TC_LST_CLM_007


function TC_LST_CLM_008() {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_008 : verify a split payment is successful in LOST CLAIM 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  
  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPriceForm
  var objCheckOutPaymentCashForm;//Stores the instance of CheckOutPaymentCash Form
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objCheckOutPaymentCreditCardOfflineForm;// Stores the instance of CheckOutPaymentCreditCardOfflineForm
  var objH6000IIPrinterForm;// Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Daily");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Daily Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    //Declaring and initializing Test Data object 
    objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };    
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +" ");
    
    //Navigate to the Credit Card Screen from CheckOutShowPriceForm 
    objCheckOutShowPriceForm.NavigateToCashScreen();
    if (objCheckOutShowPriceForm.lastError.name !== undefined) throw objCheckOutShowPriceForm.lastError;
    
    TestLog.Message("Step-5: Clicked Cash button in CheckOutShowPriceForm");
    
    //Initialize object for CheckOutPaymentCreditCardOfflineForm
    objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
    
    Price = aqConvert.StrToInt(aqString.Replace(eFormDetails.StayPrice,"$",""));
    
    //Navigate to CheckOutPaymentCash form and set the amount
    if(Price !== 0){
      if(Price%2 !==0)
        Price = (Price+1)/2;
      else
        Price = Price/2;
    }
    
    objCheckOutPaymentCashForm.SetPaymentKeyBoard(aqConvert.IntToStr(Price));
    if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
    
    TestLog.Message("Step-6 : Selected Amount from MoneyPanel")
    
    //Initialize object for CheckOutSelectPaymentTypeForm
    objCheckOutSelectPaymentTypeForm = CheckOutSelectPaymentTypeForm.New();
    
    //Navigate to the Credit Card Offline form and select the card type
    objCheckOutSelectPaymentTypeForm.NavigateToCreditCardScreen();
    if (objCheckOutSelectPaymentTypeForm.lastError.name !== undefined) throw objCheckOutSelectPaymentTypeForm.lastError;
    
    TestLog.Message("Step-7: Clicked Credit Card in CheckOutShowPriceForm");
    
    //Initialize object for CheckOutPaymentCreditCardOfflineForm
    objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
    //Navigate to the Credit Card Offline form and select the card type
    objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
    if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
    
    TestLog.Message("Step-8: Clicked Card in CheckOutPaymentCreditCardOfflineForm");    
    
    //Initialize object for H6000IIPrinterForm
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    
    TestLog.Message("Step-9: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
        
    //TestCase Result : To verify the checkout ticket is printed
    bTestCaseResult =  objH6000IIPrinterForm.Exists()&& SQLQueries.verifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNo); 
    sPassMessage    = "Test Passed. Checkout by LostClaim is successful by Split payment using Cash and Credit card";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim during Split Payment";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  objCheckOutShowPriceForm = null;
  objCheckOutPaymentCashForm = null;
  objCheckOutPaymentCreditCardOfflineForm  = null;
  objH6000IIPrinterForm    = null;

}//TC_LST_CLM_008



function TC_LST_CLM_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_009 : Verify that the error message message is displayed when invalid ticket number is given as input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail    = SQLQueries.userLoginDetails("LostClaimUser");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : ""
                    };
  try{
    
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    sActualErrorMessage = objTicketNumberForm.InputAndSubmitFormWithErrors(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered empty ticket number");
    
    //TestCase Result : To verify the checkout ticket is printed
    bTestCaseResult = sActualErrorMessage == "TICKET NOT FOUND OR ALREADY CHECK OUT.";
    sPassMessage    = "Test Passed. Expected error is displayed when empty ticket number is given as input";
    sFailMessage    = "Test Failed. Unexpected/No error message is displayed for empty ticket number";
    
    TestLog.Message("Error Meesage : "+sActualErrorMessage +"");
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;

}//TC_LST_CLM_009


function TC_LST_CLM_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_010 : verify a valid ticket number can be used to do successful LOST CLAIM for a Replace customer 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPrice Form
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Replace");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Replace Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    //Declaring and initializing Test Data object 
    objTestData = {
                     username  : eLostClaimUserDetail.username, 
                     password  : eLostClaimUserDetail.password,
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //-----------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //-------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered with the ticket number "+objTestData.sTicketNo);
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +" ");
    
    objNavigationPanelForm = NavigationPanelForm.New();
    
    objNavigationPanelForm.ClickEnter();
    
    //Initialize object for H6000IIPrinter Form   
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result :  To verify the checkout ticket is printed for Replace customers
    bTestCaseResult =  objH6000IIPrinterForm.Exists()&& SQLQueries.verifyLostClaimDetailsByTicketNumber("Replace",objTestData.sTicketNo);
    sPassMessage    = "Test Passed. The checkout ticket is printed for the Replace customer  ";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim for Replace Customers ";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  objCheckOutShowPriceForm = null;

}//TC_LST_CLM_010


//TC_LST_CLM_011 -- Skipped


//TC_LST_CLM_012 -- Skipped


function TC_LST_CLM_013() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_013 :Verify that the user can Check Out successfully via LOST CLAIM when Manual Ticket Entry is enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objTechnicianMenuForm; //variable to store TechnicianMenuForm
  var objCheckOutShowPriceForm;//Stores the instance of CheckOutShowPriceForm
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinterForm
  
  //Getting LostClaim user Login Details
  var eTechnicianUserDetail = SQLQueries.userLoginDetails("TechnicianMenuUser");
  var eLostClaimUserDetail  = SQLQueries.userLoginDetails("LostClaimUser");
  var eCheckInVehicleDetail = SQLQueries.getCheckInTicketDetails("Monthly");
    
  try{
  
    if (!eCheckInVehicleDetail.bResult){
      exception = { name        : "Data Exception",
                    description : "No TicketNumber(Monthly Customer Vehicle) currently found in CheckIn Status",
                    message     : "No Test Data Available." };
      throw exception ;            
    }
    
    //Declaring and initializing Test Data object 
    objTestData = {
                     sTicketNo : eCheckInVehicleDetail.sTicketNumber
                  };
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(eTechnicianUserDetail);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    
    //Navigate to Technician Menu form and click 'Enable Ticket Entry' button 
    //------------------------------------------------------------------------   
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToTechnicianMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    // Enable manual ticket entry
    objTechnicianMenuForm = TechnicianMenuForm.New();
    objTechnicianMenuForm.EnableManualTicketEntry();
    if (objTechnicianMenuForm.lastError.name !== undefined) throw objTechnicianMenuForm.lastError;
      
    TestLog.Message("Step-3:Enabled manual ticket entry");
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-4: SignOff from Technician User.");
    
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(eLostClaimUserDetail);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-5: Log In as LostClaim user.");
    
    //Initialize object for Main Dialog Form
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-6: Clicked Lost Claim button.");
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objTicketNumberForm.SetTicketNumber(objTestData.sTicketNo);
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;

    // Submit with default date and Time
    objNavigationPanelForm = NavigationPanelForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    objNavigationPanelForm.ClickEnter();
    if (objNavigationPanelForm.lastError.name !== undefined) throw objNavigationPanelForm.lastError;
    
    TestLog.Message("Step-7:Enter manual checkin Date and Time");
    
    //Initialize object for CheckOutShowPrice Form
    objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
    //Gets the Stay Price and Stay Rate Type and Clicks the Alternate Rate Screen button
    eFormDetails = objCheckOutShowPriceForm.GetDetails();
    
    TestLog.Message("StayPrice: " +eFormDetails.StayPrice +" ");
    
    objNavigationPanelForm = NavigationPanelForm.New();
    
    objNavigationPanelForm.ClickEnter();
    
    //Initialize object for H6000IIPrinter Form   
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-8: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    //TestCase Result :  To verify the checkout ticket is printed for monthly customers
    bTestCaseResult =  objH6000IIPrinterForm.Exists() && SQLQueries.verifyLostClaimDetailsByTicketNumber("Monthly",objTestData.sTicketNo);
    sPassMessage    = "Test Passed. The checkout ticket is printed for the Monthly customer when manual entry is enabled ";
    sFailMessage    = "Test Failed. Unexpected behaviour during Lost Claim for Monthly Customers ";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage); 
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;
  objTechnicianMenuForm    = null;
  objH6000IIPrinterForm    = null;
  objCheckOutShowPriceForm = null;
  

}//TC_LST_CLM_013

function TC_LST_CLM_014() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_LST_CLM_014 : Verify that the error message message is displayed when soft deleted tag number is given as input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objTicketNumberForm;//Stores the instance of Ticket Number Form
  var objUserInfoForm;//Stores the instance of User Info Form
  var objCheckInCustomerInfoForm;//Stores the instance of CheckInCustomerInfoForm
  
  //Getting LostClaim user Login Details
  var eLostClaimUserDetail    = SQLQueries.userLoginDetails("LostClaimUser");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     username   : eLostClaimUserDetail.username, 
                     password   : eLostClaimUserDetail.password,
                     sTagNumber : null
                    };
  
  var eTagNumberDetail = SQLQueries.getVehicleTagToDoMonthly();

  if(!eTagNumberDetail.bResult) 
    TestLog.Error("No Vehicle Tag Available in DB");   
  else
    objTestData.sTagNumber = eTagNumberDetail.sVehicleTag; //TestData object to check in a monthly customer vehicle
   
  try {
  
    SQLQueries.updateVehicleTagStatus(objTestData.sTagNumber,1);
    
    //Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Navigate to user info form and submit username and password
    //--------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoScreen 
    objUserInfoForm = UserInfoForm.New();
     
    //Set data in Username, Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
      
    //Navigate to Ticket Number form and submit ticket number
    //---------------------------------------------------------
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-3: Clicked Lost Claim button."); 
    
    //Initialize object for Ticket Number Form
    objTicketNumberForm = TicketNumberForm.New();
    
    objTicketNumberForm.NavigateToTagNumber();
    if (objTicketNumberForm.lastError.name !== undefined) throw objTicketNumberForm.lastError;
    
    objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
    
    //Set data in Ticket Number field and click Enter button from Navigation panel
    sActualErrorMessage = objCheckInCustomerInfoForm.InputAndSubmitFormWithErrors(objTestData.sTagNumber);
    if (objCheckInCustomerInfoForm.lastError.name !== undefined) throw objCheckInCustomerInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Ticket Number screen and entered Invalid tag number "+objTestData.sTagNumber);
    
    //TestCase Result : To verify the checkout ticket is printed
    bTestCaseResult = sActualErrorMessage == "TAG NUMBER ENTERED IS NOT VALID."; 
    sPassMessage    = "Test Passed. Expected error is displayed when soft deleted Tag number is given as input";
    sFailMessage    = "Test Failed. Unexpected/No error message is displayed for soft deleted Tag number";
    
    TestLog.Message("Error Meesage : "+sActualErrorMessage +"");
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);  
    
    SQLQueries.updateVehicleTagStatus(objTestData.sTagNumber,0);
      
  } //End try
    
  catch(exception) {
    if(exception.name == "Data Exception")
      TestLog.Warning(exception.description, Utility.formattedException(exception));
    else
      TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    Utility.closePOSProcess(); //Close the POS Application   
    Log.PopLogFolder();
  } //End finally
  
  //Disposing objects 
  objMainDialog            = null; 
  objTicketNumberForm      = null;
  objUserInfoForm          = null;

}//TC_LST_CLM_014

