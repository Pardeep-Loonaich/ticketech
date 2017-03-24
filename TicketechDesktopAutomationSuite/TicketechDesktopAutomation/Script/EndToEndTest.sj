//USEUNIT Utility
//USEUNIT BusinessWrapper


function TC_EMP_DETAILS_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_EMP_DETAILS_001: Verify that the employee details can be modified and the 
                      employee can carry out the punch in/out tasks successfully.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  var objTestData = NewEmployeeDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Login
    GoToLoginPage(); 
    LoginAsTimekeeperUser();
    
    //Step-1: Add a new Employee
    GoToTimekeeperMenu();       
    GoToEnrollmentMenu();
    GoToAddEmploeeScreen();
    AddAnEmployeeWithValidDetails(objTestData);
    CancelAndReturnToMain();
    VerifyAddNewEmployeeSuccessful(objTestData.sEmpId);
    
    //Step-2: Set Employee Code for the newly added User
    GoToTimekeeperMenu();       
    GoToEnrollmentMenu();
    SetCodeAsEnrollmentType(objTestData.sEmpId); //EmployeeId is set as EmployeeCode
    CancelAndReturnToMain();
     
    //Step-3: Do PunchIn with the newly added User
    GoToPunchIn();
    SubmitValidEmployeeId(objTestData.sEmpId);
    SubmitValidEmployeeCode(objTestData.sEmpId);
    SubmitForm();
    VerifyPunchInSuccessful(objTestData.sEmpId);
    
    //Step-4: Do PunchOut with the above User
    GoToPunchOut();
    SubmitValidEmployeeId(objTestData.sEmpId);
    SubmitValidEmployeeCode(objTestData.sEmpId); 
    SubmitForm();
    VerifyPunchOutSuccessful(objTestData.sEmpId);
    
    //Step-5: Correct Employee Details
    GoToTimekeeperMenu();       
    GoToEnrollmentMenu();
    UpdateEmployeeDetail(objTestData);
    CancelAndReturnToMain();
    VerifyUpdateEmployeeSuccessful(objTestData);
    
    //Step-6: Do PunchIn after Update
    GoToPunchIn();
    SubmitValidEmployeeId(objTestData.sEmpId);
    SubmitValidEmployeeCode(objTestData.sEmpId);
    SubmitForm();
    VerifyPunchInSuccessful(objTestData.sEmpId);
    
    //Step-7: Do PunchOut after Update
    GoToPunchOut();
    SubmitValidEmployeeId(objTestData.sEmpId);
    SubmitValidEmployeeCode(objTestData.sEmpId); 
    SubmitForm();
    VerifyPunchOutSuccessful(objTestData.sEmpId);
    
    //Step-8: Delete The added Employee
    GoToTimekeeperMenu();       
    GoToEnrollmentMenu();
    DeleteEmployeeEnrollment(objTestData.sEmpId);
    CancelAndReturnToMain();
    VerifyDeleteEmployeeSuccessful(objTestData.sEmpId);
    
    //Step-9: Try to Do PunchIn after Delete
    GoToPunchIn();
    SubmitInvalidEmployeeIdAndVerifyErrorMessage(objTestData.sEmpId);
    CancelAndReturnToMain();
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
        
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}

function TC_MNTHLY_CUS_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MNTHLY_CUS_001: Verify that the process of Check In and Check Out happens successfully for a monthly customer after doing monthly payments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  var objTestData = MonthlyPaymentDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Step-1: Do Monthly Payments for a Valid Customer
    GoToMonthlyPayment();       
    SubmitValidAccountNo(objTestData);
    SetPaymentDetailsInMonthlyPaymentForm(objTestData);
    EnterCheckDetailsAndSubmit(objTestData);
    CancelH6000IIPrinter();
    VerifyMonthlyPaymentDetails(objTestData);
    
    //Step-2: Do Monthly CheckIn
    GoToMonthly();
    SubmitValidTagNumber(objTestData.sVehicleTag);
    SelectVehicleDamageAsNo();
    CancelBocaPrinter();
    VerifyMonthlyCheckInDetails(objTestData);
    
    //Step-3: Do CheckOut in LostClaim
    GoToLoginPage();
    LoginAsLostClaimUser();
    GoToLostClaim();
    ClickTagNumberButton();
    SubmitValidTagNumber(objTestData.sVehicleTag);
    SubmitForm();
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTagNumber(objTestData);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
     
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}


function TC_MNTHLY_CUS_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MNTHLY_CUS_003: Verify that the process of Check In and Check Out happens successfully for an alternate vehicle of a monthly customer after adding the alternate vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  var objTestData = ReplaceDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Step-1: Add a Replace Vehicle and do checkIn
    GoToReplace();       
    SubmitValidTagNumber(objTestData.sVehicleTag);
    ClickOtherToAddAlternateVehicle();
    SubmitValidVehicleDetails(objTestData);
    SelectVehicleDamageAsNo();
    CancelBocaPrinter();
    VerifyReplaceCheckInDetails(objTestData)  
    
    //Step-2: Do CheckOut in LostClaim
    GoToLoginPage();
    LoginAsLostClaimUser();
    GoToLostClaim();
    ClickTagNumberButton();
    SubmitValidTagNumber(objTestData.sVehicleTag);
    SubmitForm();
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTagNumber(objTestData);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
     
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}

function TC_DAILY_CUS_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CUS_001: Verify that the process of Check In and Check Out happens successfully for a daily customer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  var objTestData = DailyDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Step-1: Do Daily CheckIn
    GoToDaily();       
    SubmitValidVehicleDetails(objTestData);
    SelectVehicleDamageAsNo();
    CancelBocaPrinter();
    VerifyDailyCheckInDetails(objTestData);
        
    //Step-2: Do CheckOut in LostClaim
    GoToLoginPage();
    LoginAsLostClaimUser();
    GoToLostClaim();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    PayUsingCharge();
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNumber);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
     
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}

function TC_DAILY_CUS_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CUS_002: Verify that the process of Check In and Check Out happens successfully for a daily customer when Rush Mode is Enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  var objTestData = DailyDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Step-1: Set Required Fields In Rush selection and Enable Rush Mode
    GoToRushSelection();
    SetRequiredFieldsDuringRushSelection(objTestData);
    ClickEnableRushMode();
    
    //Step-2: Do Rush Daily CheckIn
    GoToDaily();
    
    if(!(objTestData.Plate === "NO" && objTestData.Color === "NO" && objTestData.Make === "NO")){     
      SetDataInRushModeEnabledField(objTestData);
    }
    CancelBocaPrinter();
    VerifyRushModeDailyCheckInDetails(objTestData);
        
    //Step-3: Do CheckOut in LostClaim
    GoToLoginPage();
    LoginAsLostClaimUser();
    GoToLostClaim();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    PayUsingCreditCard();
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNumber);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.");
     
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}


function TC_DAILY_CUS_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CUS_003: Verify that the process of Check In and Check Out happens successfully for a daily customer when Manual Entry is Enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  var objTestData = DailyDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Login
    GoToLoginPage(); 
    LoginAsTechnicianUser();
    
    //Step-1: Enable Manual Entry
    GoToTechnicianMenu();
    EnableManualTicketEntry();
    
    //Step-1: Do Daily CheckIn
    GoToDaily(); 
    SetManualTicketNumber(objTestData); 
    SetManualDateTime();    
    SubmitValidVehicleDetails(objTestData);
    SelectVehicleDamageAsNo();
    VerifyDailyCheckInDetails(objTestData);
        
    //Step-2: Do CheckOut in LostClaim
    GoToLostClaim();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    SubmitForm(); 
    PayUsingCharge();
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNumber);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
     
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}

function TC_CORRECT_PAY_001(){
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_CORRECT_PAY_001: Verify the Daily CheckIn and CheckOut is successful with Correct payments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   
  var objTestData = DailyDataGenerator(); 
                                         
  try {  
         
    //Launching the POS application
    LaunchApp();
    
    //Login
    GoToLoginPage(); 
    LoginAsTimekeeperUser();
    
    //Step-1: Set PrePay Amount in PrePayment
    GoToPrepay();
    SetPrepayAmount(objTestData);
    
    //Step-2: Do Daily CheckIn with Prepay
    GoToDaily();   
    ClickPrepayButton();    
    SubmitValidVehicleDetails(objTestData);
    SelectVehicleDamageAsNo();
    PrepayUsingCreditCard();
    CancelBocaPrinter();
    CancelH6000IIPrinter();
    VerifyDailyWithPrepayment(objTestData);
     
    //Step-3: Do Correct Payments
    GoToCorrectPayment();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    PayUsingCreditCardOption();
    CancelH6000IIPrinter();

    //Step-4: Do CheckOut in LostClaim
    GoToLostClaim();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    SubmitForm(); 
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNumber);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
   
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}

function TC_PREPAY_001(){
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PRE_PAY_001: Verify the Prepayments if set successfull reflected in Daily if Prepay option is chosen during CheckIn/CheckOut
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   
  var objTestData = DailyDataGenerator(); 
                                         
  try {         
    //Launching the POS application
    LaunchApp();
    
    //Login as TechnicianUser and set credit card offline
    GoToLoginPage(); 
    LoginAsTechnicianUser(); 
    EnableCreditCardOfflineMode();
    
    //Step-1: Set PrePay Amount in PrePayment
    GoToPrepay();
    SetPrepayAmount(objTestData);
    
    //Step-2: Do Daily CheckIn with PrePayment
    GoToDaily();   
    ClickPrepayButton();    
    SubmitValidVehicleDetails(objTestData);
    SelectVehicleDamageAsNo();
    PrepayUsingCreditCard();
    CancelBocaPrinter();
    CancelH6000IIPrinter();
    VerifyDailyWithPrepayment(objTestData);
     
    //Step-3: Do CheckOut in LostClaim
    GoToLostClaim();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    SubmitForm(); 
    CancelH6000IIPrinter();
    VerifyLostClaimDetailsByTicketNumber("Daily",objTestData.sTicketNumber);
    
    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
   
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}

function TC_TICKET_INQ_001(){
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_PRE_PAY_001: Verify the vehicle information is displayed correctly in accordance with the input.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   
  var objTestData = MonthlyPaymentDataGenerator();
      
  try {                                            
       
    //Launching the POS application
    LaunchApp();
    
    //Step-2: Do Monthly CheckIn
    GoToMonthly();
    SubmitValidTagNumber(objTestData.sVehicleTag);
    SelectVehicleDamageAsNo();
    CancelBocaPrinter();
    VerifyMonthlyCheckInDetails(objTestData);
    
    //Step-3: Do Ticket Inquiry 
    GoToTicketInquiry();       
    ClickFindByTicketButton();
    SubmitValidTicketNumber(objTestData.sTicketNumber);
    VerifyTicketDetails(objTestData);
    
    //Step-4: Do Vehicle Enquiry
    ClickFindByVehicleButton();
    SubmitValidVehicleDetailsInTicketInquiry(objTestData);
    VerifyTicketDetailsByVehicleDetails(objTestData);

    //This Result message will be Shown only if the above flow is success, 
    //if anything fails in middle it will throw the error and stops Execution
    TestLog.Pass("Business Flow Test Passed.") ;
   
  } //End try 

  catch(exception) {
  TestLog.Error(exception.description, Utility.formattedException(exception));
  TestLog.Fail("Business Flow Test Failed. See Error Message for Failure.")
  } //End catch
    
  finally {  
  Utility.closePOSProcess(); //Close the POS Application      
  Log.PopLogFolder();
  } //End finally
}