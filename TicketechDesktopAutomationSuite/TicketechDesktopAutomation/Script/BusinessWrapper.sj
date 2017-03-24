//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries

//USEUNIT MainDialog
//USEUNIT UserInfoForm

//USEUNIT ConfirmActionForm
//USEUNIT CheckOutShowPriceForm
//USEUNIT CheckOutChangeRateForm
//USEUNIT CheckOutPaymentCreditCardOfflineForm
//USEUNIT CheckOutPaymentNoChargeNoPaymentReasonsForm
//USEUNIT CheckOutPaymentChargeForm
//USEUNIT CheckOutPaymentCashForm
//USEUNIT CheckInCustomerInfoForm
//USEUNIT CheckInVehicleDamageForm
//USEUNIT CheckInTicketNumberForm
//USEUNIT CheckInCustomerPaymentStatusForm
//USEUNIT CheckInCustomerVehicleForm
//USEUNIT CheckInPrepaymentForm
//USEUNIT CheckOutSelectPaymentTypeForm

//USEUNIT EmployeeEnrollmentMenuForm
//USEUNIT EmployeeEnrollmentInfoForm
//USEUNIT EmployeeEnrollmentTypeForm
//USEUNIT EmployeeCodeForm
//USEUNIT EmployeeInfoForm
//USEUNIT EmployeePunchForm

//USEUNIT H6000IIPrinterForm

//USEUNIT ManualDateInformationDateForm
//USEUNIT MonthlyPaymentsInfoAccountNumberForm
//USEUNIT MonthlyPaymentsInfoForm
//USEUNIT MonthlyPaymentsCheckForm

//USEUNIT NavigationPanelForm

//USEUNIT PrinterStatusForm
//USEUNIT PrepaymentAmountForm

//USEUNIT RushSelectionInfoForm

//USEUNIT TechnicianMenuForm
//USEUNIT TimekeeperMenuForm
//USEUNIT TicketNumberForm
//USEUNIT TicketInquiryForm
//USEUNIT TicketInquiryVehicleUpdateForm
//USEUNIT TicketInquiryResultsForm

//USEUNIT VehicleInfoForm

//----------------------------------------------------

function LaunchApp(){

  Utility.launchApp();  
}
//----------------------------------------------------
function GoToLoginPage(){

  objMainDialog = MainDialog.New();
  objMainDialog.NavigateToUserInfoScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else      
    TestLog.Message("Navigated to Login Page");
}
//----------------------------------------------------
function LoginWithValidUserDetails(objTestData){

  objUserInfoForm = UserInfoForm.New();     
  //Set data in Username and Password field
  objUserInfoForm.InputAndSubmitForm(objTestData);
  if (objUserInfoForm.lastError.name !== undefined) 
    throw objUserInfoForm.lastError;
  else      
    TestLog.Message("Logged in as "+objTestData.username);
}
//----------------------------------------------------
function LoginWithInvalidUserDetails(objTestData){

  objUserInfoForm = UserInfoForm.New();     
  //Set data in Username and Password field
  objUserInfoForm.InputAndSubmitFormWithErrors(objTestData);
  if (objUserInfoForm.lastError.name !== undefined) 
    throw objUserInfoForm.lastError;
  else      
    TestLog.Message("Logged in with Invalid Credentials");
}
//----------------------------------------------------
function GoToTimekeeperMenu(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.NavigateToTimeKeeperMenu();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to Time Keeper screen"); 

}
//----------------------------------------------------
function GoToEnrollmentMenu(){

  objTimekeeperMenuForm = TimekeeperMenuForm.New();
      
  objTimekeeperMenuForm.NavigateToEnrollmentForm();
  if (objTimekeeperMenuForm.lastError.name !== undefined) 
    throw objTimekeeperMenuForm.lastError;
  else    
    TestLog.Message("Navigated to EnrollmentMenu");     
}
//----------------------------------------------------
function GoToAddEmploeeScreen(){

  objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
  objEmpEnrollMenuForm.NavigateToAddEmployeeForm();
  if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;  
      
  TestLog.Message("Navigated to Add Employee Screen");
}
//----------------------------------------------------
function AddAnEmployeeWithValidDetails(objTestData){

  objEmpEnrollInfoForm = EmployeeEnrollmentInfoForm.New();
    
  objEmpEnrollInfoForm.InputAndSubmitForm(objTestData);
  if (objEmpEnrollInfoForm.lastError.name !== undefined) 
    throw objEmpEnrollInfoForm.lastError;  
  else    
    TestLog.Message("Added Employee with valid Details.");
}
//----------------------------------------------------
function UpdateEmployeeDetail(objTestData){
 
  objTestData.sLastName = Utility.getRandomValue("ALPHA",6);

  objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
  empCurrentData = objEmpEnrollMenuForm.NaviagteToUpdateEmployeeDataForm(objTestData.sEmpId);   
  if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;  
      
  //Navigate into EnrollmentInfo Form and updating Employee Details
  objEmpEnrollInfoForm = EmployeeEnrollmentInfoForm.New();
    
  objEmpEnrollInfoForm.UpdateAndSubmitForm(objTestData);
  if (objEmpEnrollInfoForm.lastError.name !== undefined) 
    throw objEmpEnrollInfoForm.lastError;  
  else    
    TestLog.Message("Updated Employee Detail");
}
//----------------------------------------------------
function CancelAndReturnToMain(){

  objNavigationPanelForm = NavigationPanelForm.New();
    
  objNavigationPanelForm.ClickCancel();
  
  TestLog.Message("Clicked Cancel and Returned To Main Screen.");
}
//----------------------------------------------------
function SubmitForm(){

  objNavigationPanelForm = NavigationPanelForm.New();
    
  objNavigationPanelForm.ClickEnter();
   
  TestLog.Message("Clicked Enter");
}
//----------------------------------------------------
function SetCodeAsEnrollmentType(sEmployeeId){

  objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
  objEmpEnrollMenuForm.NavigateToCorrectEnrollmentForm(sEmployeeId);
  if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;
 
  objEmpEnrollTypeForm = EmployeeEnrollmentTypeForm.New();
    
  //Navigate into Code screen 
  objEmpEnrollTypeForm.SelectCode();      
  if (objEmpEnrollTypeForm.lastError.name !== undefined) throw objEmpEnrollTypeForm.lastError;  
  
  objEmployeeCodeForm = EmployeeCodeForm.New();
      
  //Navigate into EmployeeCode Form  and submit a new employee code
  objEmployeeCodeForm.InputAndSubmitForm(sEmployeeId);//EmployeeID is set as employee code
  if (objEmployeeCodeForm.lastError.name !== undefined) 
    throw objEmployeeCodeForm.lastError;
  else    
    TestLog.Message("The employee " +sEmployeeId + " Enrollment Type Updated  to Code "+sEmployeeId);
}
//----------------------------------------------------
function GoToPunchIn(){

  objMainDialog = MainDialog.New();
  
  //Navigate into Employee info screen
  objMainDialog.NavigateToPunchInScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else 
    TestLog.Message("Navigated To Punch In Screen.");
}
//----------------------------------------------------
function GoToPrepay(){

  objMainDialog = MainDialog.New();
  
  //Navigate into Employee info screen
  objMainDialog.NavigateToPrepayScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else 
    TestLog.Message("Navigated To Prepay Screen.");
}
//----------------------------------------------------

function GoToPunchOut(){

  objMainDialog = MainDialog.New();
  
  //Navigate into Employee info screen
  objMainDialog.NavigateToPunchOutScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else 
    TestLog.Message("Navigated To Punch Out Screen.");
}
//----------------------------------------------------
function GoToMonthly(){
  objMainDialog= MainDialog.New();
      
  //Navigate into Customer info screen and submit valid vehicle tag
  objMainDialog.NavigateToMonthlyScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else    
   TestLog.Message("Navigated To Monthly Screen");

}
//----------------------------------------------------
function GoToLostClaim(){
    objMainDialog = MainDialog.New();
    
    objMainDialog.NavigateToLostClaim();
    if (objMainDialog.lastError.name !== undefined) 
      throw objMainDialog.lastError;
    else 
      TestLog.Message("Navigated To Lost Claim Screen."); 

}
//----------------------------------------------------
function SubmitValidEmployeeId(sEmployeeId){
  objEmployeeInfoForm = EmployeeInfoForm.New();
      
  //Set data in Employee ID field
  objEmployeeInfoForm.InputAndSubmitForm(sEmployeeId);
  if (objEmployeeInfoForm.lastError.name !== undefined) 
    throw objEmployeeInfoForm.lastError;
  else  
    TestLog.Message("Submitted valid Employee id "+sEmployeeId);
}
//----------------------------------------------------
function SubmitInvalidEmployeeIdAndVerifyErrorMessage(sEmployeeId){

  objEmployeeInfoForm = EmployeeInfoForm.New();
      
  //Set data in Employee ID field and click Enter button from Navigation panel
  sErrorMessage = objEmployeeInfoForm.InputAndSubmitFormWithErrors(sEmployeeId);
  if (objEmployeeInfoForm.lastError.name !== undefined) 
    throw objEmployeeInfoForm.lastError;
  else 
    TestLog.Pass("Expected Error Message Displayed. Message: \""+sErrorMessage+"\"");
}
//----------------------------------------------------
function SubmitValidEmployeeCode(sEmployeeCode){
  objEmployeeCodeForm = EmployeeCodeForm.New();
      
  //Set data in Employee Code field
  objEmployeeCodeForm.InputAndSubmitForm(sEmployeeCode);
  if (objEmployeeCodeForm.lastError.name !== undefined) 
    throw objEmployeeCodeForm.lastError;
  else  
    TestLog.Message("Submitted valid Employee Code");
}
//----------------------------------------------------
function VerifyPunchInSuccessful(sEmployeeId){
  eEmpPunchInDetails =  SQLQueries.getPunchInOutEmployee(sEmployeeId);
     
  if(eEmpPunchInDetails.bPunchInOutStatus == 1)
    TestLog.Pass("Employee PunchIn Successful");
  else {
    exception = { name        : "DB Verification",
                  description : "PunchIn of Employee "+sEmployeeId+" not Successful",
                  message     : "PunchIn Not Successful." };
    throw exception ;            
    }
}
//----------------------------------------------------
function VerifyPunchOutSuccessful(sEmployeeId){
  eEmpPunchOutDetails =  SQLQueries.getPunchInOutEmployee(sEmployeeId);
     
  if(eEmpPunchOutDetails.bPunchInOutStatus == 0)
    TestLog.Pass("Employee PunchOut Successful");
  else {
    exception = { name        : "DB Verification",
                  description : "PunchOut of Employee "+sEmployeeId+" not Successful",
                  message     : "PunchOut Not Successful." };
    throw exception ;            
    }
}
//----------------------------------------------------
function VerifyAddNewEmployeeSuccessful(sEmployeeId){

  if(SQLQueries.getEmployeeDetails(sEmployeeId).bResult)
    TestLog.Pass("Employee "+sEmployeeId+" added Successful");
  else {
    exception = { name        : "DB Verification",
                  description : "Add Employee "+sEmployeeId+" not Successful",
                  message     : "Add Employee Not Successful." };
    throw exception ;            
    }
}
//----------------------------------------------------
function VerifyDeleteEmployeeSuccessful(sEmployeeId){

  if(SQLQueries.getEmployeeDetails(sEmployeeId).bEmployeeDeleted)
    TestLog.Pass("Employee "+sEmployeeId+" Deleted Successful");
  else {
    exception = { name        : "DB Verification",
                  description : "Delete Employee "+sEmployeeId+" not Successful",
                  message     : "Delete Employee Not Successful." };
    throw exception ;            
    }
}
//----------------------------------------------------
function VerifyUpdateEmployeeSuccessful(objTestData){

  if(SQLQueries.getEmployeeDetails(objTestData.sEmpId).sLastName == objTestData.sLastName)
    TestLog.Pass("Employee "+objTestData.sEmpId+" Update Successful");
  else {
    exception = { name        : "DB Verification",
                  description : "Update Employee "+objTestData.sEmpId+" not Successful",
                  message     : "Update Employee Not Successful." };
    throw exception ;            
    }
}
//----------------------------------------------------
function VerifyChangeEnrollmentTypeSuccessful(sEmployeeId){

  if(aqString.Find(SQLQueries.getEmployeeDetails(objTestData.sEmpId).sTemplateImage,"<TemplateType>Password</TemplateType>"))
    TestLog.Pass("Employee "+sEmployeeId+" Change lEnrollmentType Successful");
  else {
    exception = { name        : "DB Verification",
                  description : "Update Employee "+sEmployeeId+" not Successful",
                  message     : "Update Employee Not Successful." };
    throw exception ;            
    }
}
//----------------------------------------------------
function VerifyMonthlyPaymentDetails(objTestData){

  if(SQLQueries.getIncomeDetails(objTestData.sAccountNo).bResult && SQLQueries.getPaymentDetails(objTestData))
    TestLog.Pass("Monthly Payments done successfully for Customer Account "+objTestData.sAccountNo);
  else {
    exception = { name        : "DB Verification",
                  description : "Monthly Payments Not Successful for Customer Account "+objTestData.sAccountNo,
                  message     : "Monthly Payments Not Successful." };
    throw exception ;            
    }
}

//----------------------------------------------------
function VerifyMonthlyCheckInDetails(objTestData){

  eVehicleDetails = SQLQueries.getLastAddedMonthlyDetails(objTestData.sVehicleTag);
    
  objTestData.sTicketNumber = eVehicleDetails.sTicketNumber;
  
  if(eVehicleDetails.bResult)
    TestLog.Pass("Monthly CheckIn done successfully for VehicleTag "+eVehicleDetails.sVehicleTag+" Stay Ticket is "+objTestData.sTicketNumber);
  else {
    exception = { name        : "DB Verification",
                  description : "Monthly CheckIn Not Successful for VehicleTag "+objTestData.sVehicleTag,
                  message     : "Monthly CheckIn Not Successful." };
    throw exception ;            
  }
  
}
//----------------------------------------------------
function VerifyReplaceCheckInDetails(objTestData){

  eVehicleDetails = SQLQueries.getLastAddedReplaceDetails(objTestData.sVehicleTag);
    
  objTestData.sTicketNumber = eVehicleDetails.sTicketNumber;
  
  if(eVehicleDetails.bResult)
    TestLog.Pass("Replace  CheckIn done successfully for VehicleTag "+eVehicleDetails.sVehicleTag+" Stay Ticket is "+objTestData.sTicketNumber);

  else {
    exception = { name        : "DB Verification",
                  description : "Replace CheckIn Not Successful for VehicleTag "+objTestData.sVehicleTag,
                  message     : "Replace CheckIn Not Successful." };
    throw exception ;            
  }
  
}
//----------------------------------------------------
function VerifyLostClaimDetailsByTagNumber(objTestData){

  if(SQLQueries.verifyLostClaimResultByTagNumber(objTestData))
    TestLog.Pass("LostClaim done successfully for VehicleTag "+objTestData.sVehicleTag);
  else {
    exception = { name        : "DB Verification",
                  description : "LostClaim Not Successful for VehicleTag "+objTestData.sVehicleTag,
                  message     : "LostClaim Not Successful." };
    throw exception ;            
  }
  
}

//----------------------------------------------------

//----------------------------------------------------
function VerifyRushModeDailyCheckInDetails(objTestData){

  eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();

  if(eVehicleAdded.bResult){
    objTestData.sTicketNumber = eVehicleAdded.sStayTicket;
    TestLog.Pass("Daily CheckIn done successfully when Rush Mode is enabled with Ticket No. " +objTestData.sTicketNumber);
  }
  else {
    exception = { name        : "DB Verification",
                  description : "Daily CheckIn Not Successful for the enabled fields ",
                  message     : "Daily CheckIn  Not Successful." };
    throw exception ;            
  }
  
}

//----------------------------------------------------
function VerifyLostClaimDetailsByTicketNumber(sCustType,sTicketNo){

  if(SQLQueries.verifyLostClaimDetailsByTicketNumber(sCustType,sTicketNo))
    TestLog.Pass("LostClaim done successfully for TicketNumber "+sTicketNo);
  else {
    exception = { name        : "DB Verification",
                  description : "LostClaim Not Successful for TicketNumber "+sTicketNo,
                  message     : "LostClaim Not Successful." };
    throw exception ;            
  }
  
}

//----------------------------------------------------

function VerifyDailyCheckInDetails(objTestData){

  eStayDetails = SQLQueries.getLastAddedVehicleStayDetails(objTestData.sPlateNumber);
  bDBResultPass = false;  
  
  //Checks if Query yields a result
  //CheckIn vehicle will have StayDateOut as NULL;  
  //Daily CheckIn StayType = 0
  if(eStayDetails.bResult && eStayDetails.sStayDateOut == null && eStayDetails.iDamageIdentification == 1
     && eStayDetails.iStayType == 0){
        objTestData.sTicketNumber = eStayDetails.sStayTicket
        eVehicleDetails = SQLQueries.getVehicleDetails(eStayDetails.sVehicleGUID);
        //Checks if Query yields a result
        //Compares the color and Make given; 
        //Checks if the added vehicle size (2 for SuperOversize, 1 for OverSize, 0 for standard) 
        //Checks VehicleOverSize (true for OverSize, false for others)
        if(eVehicleDetails.bResult && eVehicleDetails.sColor == objTestData.sColor 
            && eVehicleDetails.sMake == aqString.ToUpper(objTestData.sVehicleMake) && eVehicleDetails.iVehicleSize == 0
            && !eVehicleDetails.bVehicleOversized){
                bDBResultPass = true;
        }
  } 
  
  if(bDBResultPass){
    TestLog.Message("Vehicle Details: Plate - "+objTestData.sPlateNumber+", Color - "+objTestData.sColor +", Make - "+objTestData.sVehicleMake);
    TestLog.Pass("CheckIn is done successfully for a daily customer with TicketNo: "+ objTestData.sTicketNumber);
  }
  else {
    exception = { name        : "DB Verification",
                  description : "Daily CheckIn not Successful",
                  message     : "Daily CheckIn Not Successful." };
    throw exception ;            
  }  
}
//----------------------------------------------------

function VerifyDailyWithPrepayment(objTestData){

  objTestData.sTicketNumber = SQLQueries.verifyDailyWithPrepayment(objTestData);

  if(objTestData.sTicketNumber !== null && objTestData.sTicketNumber !== undefined)
    TestLog.Pass("Daily with Prepayment done successfully for TicketNumber "+objTestData.sTicketNumber);
  else {
    exception = { name        : "DB Verification",
                  description : "Daily with Prepayment Not Successful",
                  message     : "Daily with Prepayment Not Successful." };
    throw exception ;            
  }
}
//----------------------------------------------------

function NewEmployeeDataGenerator(){

  var objTestData = {sEmpId : null, sFirstName : null, sLastName : null, iSSNum : null, sBirthDate: null, sExpectedMsg : null};

  objTestData.sEmpId     = Utility.getRandomValue("ALPHA",1)+Utility.getRandomValue("NUMERIC",6);
  objTestData.sFirstName = Utility.getRandomValue("ALPHA",6);
  objTestData.sLastName  = Utility.getRandomString(["THOMPSON","CRAIG","PARKER","OSBORNE",Utility.getRandomValue("ALPHA",6)]);
  objTestData.iSSNum     = Utility.getRandomValue("NUMERIC",9);
  
  sMonth = Utility.randomIntFromInterval(1,12).toString();
  if(sMonth.length === 1){sMonth = aqString.Insert(sMonth,"0",0)};
  sDate = Utility.randomIntFromInterval(1,12).toString();
  if(sDate.length === 1){sDate = aqString.Insert(sDate,"0",0)};
  objTestData.sBirthDate = sMonth+sDate+Utility.randomIntFromInterval(1950,2000);
    
  return objTestData;
}
//----------------------------------------------------
function MonthlyPaymentDataGenerator(){

  var eCustAccountDetails = SQLQueries.getVehicleTagToDoMonthly();

  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,sVehicleTag  : eCustAccountDetails.sVehicleTag
                      ,sTicketNumber: null
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "Check"
                      ,sTaxType     : "FullTax"
                      ,sBankName    : Utility.getRandomValue("ALPHA",5)
                      ,iCheckNumber : Utility.getRandomValue("NUMERIC",7)
                      ,sColor       : null
                      ,sVehicleMake : null
                      ,sPlateNumber : null
                      
                    }; 
  
  return objTestData;

}
//----------------------------------------------------
function ReplaceDataGenerator(){
  
  var eCustAccountDetails = SQLQueries.getVehicleTagToDoMonthly();
      
  var  objTestData = {  sVehicleTag  : eCustAccountDetails.sVehicleTag
                       ,sPlateNumber : Utility.getRandomValue("NUMERIC", 7)                                     
                       ,sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER","YELLOW","BLUE","GOLD","WHITE"])
                       ,sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo","Other"])
                       ,sTicketNumber: null                                       
                     };
                      
  return objTestData;
}

//----------------------------------------------------
function DailyDataGenerator(){    

  var objTestData = {
                      Plate : Utility.getRandomString(["YES","NO"]) //required during RushMode 
                     ,Color : Utility.getRandomString(["YES","NO"]) //required during RushMode
                     ,Make  : Utility.getRandomString(["YES","NO"]) //required during RushMode
                     ,sPlateNumber : Utility.getRandomValue("NUMERIC", 7)                                      
                     ,sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER","YELLOW","BLUE","GOLD","WHITE"])
                     ,sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Jeep","Volvo","Other"])
                     ,sTicketNumber: null
                     ,sPrepayAmount: Utility.randomIntFromInterval(18,30)
                    }; //TestData object for Daily module               
  
  return objTestData;

}
//----------------------------------------------------
function LoginAsTimekeeperUser(){
  //Getting Timekeeper user Login details
  LoginWithValidUserDetails(SQLQueries.userLoginDetails("TimekeeperWithEnrollMenu"));
  
}
//----------------------------------------------------
function LoginAsTechnicianUser(){

  LoginWithValidUserDetails(SQLQueries.userLoginDetails("TechnicianMenuUser"));
  
}
//----------------------------------------------------

function LoginAsLostClaimUser(){

  LoginWithValidUserDetails(SQLQueries.userLoginDetails("LostClaimUser"));
}
//----------------------------------------------------
function DeleteEmployeeEnrollment(sEmployeeId){

  objEmpEnrollMenuForm = EmployeeEnrollmentMenuForm.New();
    
  //Click Delete Enrollemnt button after selecting the required employee
  objEmpEnrollMenuForm.NavigateToDeleteEnrollmentForm(sEmployeeId);
  if (objEmpEnrollMenuForm.lastError.name !== undefined) throw objEmpEnrollMenuForm.lastError;
      
  //Navigate into Confirm Action screen and confirm yes to delete the record
  objConfirmActionForm = ConfirmActionForm.New();
  objConfirmActionForm.ConfirmYes();
  if (objConfirmActionForm.lastError.name !== undefined) 
    throw objConfirmActionForm.lastError;
  else     
    TestLog.Message("Deleted Employee "+sEmployeeId);  

}
//----------------------------------------------------
function GoToMonthlyPayment(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.NavigateToMonthlyPaymentScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to Monthly Payment screen"); 

}
//----------------------------------------------------

//----------------------------------------------------
function GoToCorrectPayment(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.NavigateToCorrectPaymentScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to Correct Payment screen"); 

}
//----------------------------------------------------
function SubmitValidAccountNo(objTestData){

  objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
  //Set account no in Account Number field
  objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
  if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) 
    throw objMonthlyPaymentInfoAccountNumberForm.lastError;
  else  
    TestLog.Message("Submitted valid Account Number "+objTestData.sAccountNo);
}
//----------------------------------------------------
function SetPaymentDetailsInMonthlyPaymentForm(objTestData){

  //Initialize object of MonthlyPaymentInfo Form
  objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
  //Set Pay details in each field of monthly payment info form
  objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
  if (objMonthlyPaymentInfoForm.lastError.name !== undefined) 
    throw objMonthlyPaymentInfoForm.lastError;
  else      
    TestLog.Message("Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");

}
//----------------------------------------------------
function EnterCheckDetailsAndSubmit(objTestData){

  //Initialize object of MonthlyPaymentCheck Form
  objMonthlyPaymentCheckForm = MonthlyPaymentsCheckForm.New();
      
  //Step-4: Set Check details in each field of monthly payment Check form
  //------------------------------------------------------------------
  objMonthlyPaymentCheckForm.InputCheckDetails(objTestData);
  if (objMonthlyPaymentCheckForm.lastError.name !== undefined) 
    throw objMonthlyPaymentCheckForm.lastError;
  else    
    TestLog.Message("Navigated to MonthlyPaymentsCheck Form and submitted Check details");

}
//----------------------------------------------------
function CancelH6000IIPrinter(){

  objH6000IIPrinterForm = H6000IIPrinterForm.New();
  objH6000IIPrinterForm.ClickCancel()
      
  TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window and Clicked Cancel");
}
//----------------------------------------------------
function CancelBocaPrinter(){
  //Click Cancel button on Printer Status window 
  objPrinterStatusForm = PrinterStatusForm.New();
  objPrinterStatusForm.ClickCancel();
  
  TestLog.Message("Clicked Cancel button on Printer Status Window");
}
//----------------------------------------------------
function ClickTagNumberButton(){
  //Initialize object for Ticket Number Form
  objTicketNumberForm = TicketNumberForm.New();
    
  objTicketNumberForm.NavigateToTagNumber();
  if (objTicketNumberForm.lastError.name !== undefined) 
    throw objTicketNumberForm.lastError;
  else
    TestLog.Message("Clicked TagNumber button"); 
}
//----------------------------------------------------
function SubmitValidTagNumber(sVehicleTag){

  //Initialize object of CheckInCustomerInfoForm 
  objCheckInCustomerInfoForm = CheckInCustomerInfoForm.New();
      
  //Set data in Employee ID field and click Enter button from Navigation panel
  objCheckInCustomerInfoForm.InputAndSubmitForm(sVehicleTag);
  if (objCheckInCustomerInfoForm.lastError.name !== undefined) 
    throw objCheckInCustomerInfoForm.lastError;
  else   
    TestLog.Message("Navigated to CheckInCustomerInfo Form and submitted the Tag Number : " +sVehicleTag);

}

//----------------------------------------------------
function SubmitValidTicketNumber(sTicketNumber){
  //Initialize object for Ticket Number Form
  objTicketNumberForm = TicketNumberForm.New();
    
  //Set data in Ticket Number field and click Enter button from Navigation panel
  objTicketNumberForm.SetTicketNumber(sTicketNumber);
  if (objTicketNumberForm.lastError.name !== undefined) 
    throw objTicketNumberForm.lastError;
  else    
    TestLog.Message("Navigated to Ticket Number screen and entered ticket number "+sTicketNumber);
}
//----------------------------------------------------
function SelectVehicleDamageAsNo(){
  //Initialize object of CheckInVehicleDamageForm 
  objCheckInVehicleDamageForm= CheckInVehicleDamageForm.New();
      
  //Click No for vehicle damage confirmation.
  objCheckInVehicleDamageForm.ConfirmNo();
  if (objCheckInVehicleDamageForm.lastError.name !== undefined) 
    throw objCheckInVehicleDamageForm.lastError;
  else   
    TestLog.Message("Clicked No button to confirm vehicle not damage");

}
//----------------------------------------------------
function GoToReplace(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.NavigateToReplaceScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to Replace screen"); 

}

//----------------------------------------------------
function GoToDaily(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.clickOnDailyButton();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to Daily screen"); 

}

//----------------------------------------------------
function GoToTicketInquiry(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.NavigateToTicketInquiryScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to TicketInquiryScreen screen"); 

}

//----------------------------------------------------
function GoToRushSelection(){

  objMainDialog = MainDialog.New();
    
  objMainDialog.NavigateToRushSelectionScreen();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Navigated to Rush Selection screen"); 

}
//----------------------------------------------------
function ClickOtherToAddAlternateVehicle(){

  //click Other vehicle to checkin
  objCheckInCustomerVehicleForm = CheckInCustomerVehicleForm.New();
    
  objCheckInCustomerVehicleForm.SelectOtherVehicle();
  if (objCheckInCustomerVehicleForm.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else  
    TestLog.Message("Clicked Others to Add a new alternate Vehicle");
}


//----------------------------------------------------
function ClickFindByTicketButton(){

  //click Other vehicle to checkin
  objTicketInquiryForm = TicketInquiryForm.New();
    
  objTicketInquiryForm.ClickFindByTicket();
  if (objTicketInquiryForm.lastError.name !== undefined) 
    throw objTicketInquiryForm.lastError;
  else  
    TestLog.Message("Clicked Find by Ticket button");
}

//----------------------------------------------------
function ClickFindByVehicleButton(){

  //click Other vehicle to checkin
  objTicketInquiryForm = TicketInquiryForm.New();
    
  objTicketInquiryForm.ClickFindByVehicle();
  if (objTicketInquiryForm.lastError.name !== undefined) 
    throw objTicketInquiryForm.lastError;
  else  
    TestLog.Message("Clicked Find by Vehicle button");
}

//----------------------------------------------------
function ClickEnableRushMode(){
  
  objMainDialog = MainDialog.New();
  
  if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
    TestLog.Message("The rush mode is enabled");
    sRushMode = "Enabled";
  }
}     

//----------------------------------------------------
function ClickPrepayButton(){
  
  objVehicleInfoForm = VehicleInfoForm.New();
  
  if(objVehicleInfoForm.clickOnPrepayButton()){ //EnableRushMode method return true if the mode is enabled
    TestLog.Message("The Prepay button is clicked");
  }
}     

//----------------------------------------------------
function ClickDisableRushMode(){
  
  objMainDialog = MainDialog.New();
  
  if(objMainDialog.DisableRushMode()){ //EnableRushMode method return true if the mode is enabled
    TestLog.Message("The rush mode is disabled");
    sRushMode = "Disabled";
  }
}     
//----------------------------------------------------
function SubmitValidVehicleDetails(objTestData){

  objVehicleInfoForm = VehicleInfoForm.New();
            
  //Enter vehicle information for daily checkin      
  objVehicleInfoForm.provideVehicleDetails(objTestData);
  if (objVehicleInfoForm.lastError.name !== undefined) 
    throw objVehicleInfoForm.lastError;
  else
    TestLog.Message("Entered New vehicle's Plate number, Color and Make");
}
//----------------------------------------------------
function SubmitValidVehicleDetailsInTicketInquiry(objTestData){

  objTicketInquiryVehicleUpdateForm = TicketInquiryVehicleUpdateForm.New();
            
  //Enter vehicle information for daily checkin      
  objTicketInquiryVehicleUpdateForm.provideVehicleDetails(objTestData);
  if(objTicketInquiryVehicleUpdateForm.lastError.name !== undefined) 
    throw objTicketInquiryVehicleUpdateForm.lastError; 
  else
    TestLog.Message("Entered vehicle's Plate number, Color and Make to Inquire");
}
//----------------------------------------------------

function SetDataInRushModeEnabledField(objTestData){

  // Checks the Rush mode set field and available field are same, and also perform Data entry 
  // on the corresponding fields  
  
  objVehicleInfoForm = VehicleInfoForm.New();
  if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
  bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
  
    if(bRushModeUICheckResult)
    TestLog.Message("The fields are set as per the required data successfully");
  else {
    exception = { name        : "UI Exception",
                  description : "Fields are not set as per the required data ",
                  message     : "UI Verification Not Successful." };
    throw exception ;            
    }
}

//----------------------------------------------------
function SetRequiredFieldsDuringRushSelection(objTestData){

  objRushSelectionInfoForm = RushSelectionInfoForm.New();

  // Set the Rush Selection Required Fields as per Test Data
  objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
  if (objRushSelectionInfoForm.lastError.name !== undefined) 
    throw objRushSelectionInfoForm.lastError;
  else  
    TestLog.Message("Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
}
//----------------------------------------------------

function PayUsingCreditCard(){

  //Initialize object for CheckOutShowPrice Form
  objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
  eFormCurrDetails = objCheckOutShowPriceForm.GetDetails();
    
  TestLog.Message("StayPrice: " +eFormCurrDetails.StayPrice +"; StayRateType: " +eFormCurrDetails.StayRateType);
      
  //Navigate to the Credit Card Screen from CheckOutShowPriceForm 
  objCheckOutShowPriceForm.NavigateToCreditCardScreen();
  if (objCheckOutShowPriceForm.lastError.name !== undefined) 
    throw objCheckOutShowPriceForm.lastError;
  else  
    TestLog.Message("Clicked Credit Card as Payment Type in CheckOutForm");
    
  //Initialize object for CheckOutPaymentCreditCardOfflineForm
  objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
  //Navigate to the Credit Card Offline form and select the card type
  objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
  if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) 
    throw objCheckOutPaymentCreditCardOfflineForm.lastError;
  else  
    TestLog.Message("Paid with Credit Card");
}
//----------------------------------------------------



function PrepayUsingCreditCard(){

  //Initialize object for CheckOutShowPrice Form
  objCheckInPrepaymentForm = CheckInPrepaymentForm.New();
      
  //Navigate to the Credit Card Screen from CheckInPaymentForm 
  objCheckInPrepaymentForm.NavigateToCreditCardScreen();
  if (objCheckInPrepaymentForm.lastError.name !== undefined) 
    throw objCheckInPrepaymentForm.lastError;
  else  
    TestLog.Message("Clicked Credit Card as Payment Type in CheckIn PaymentForm");
    
  //Initialize object for CheckOutPaymentCreditCardOfflineForm
  objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
  //Navigate to the Credit Card Offline form and select the card type
  objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
  if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) 
    throw objCheckOutPaymentCreditCardOfflineForm.lastError;
  else  
    TestLog.Message("Paid with Credit Card");
}
//----------------------------------------------------

function PayUsingCharge(){

  //Initialize object for CheckOutShowPrice Form
  objCheckOutShowPriceForm = CheckOutShowPriceForm.New();
    
  eFormCurrDetails = objCheckOutShowPriceForm.GetDetails();
    
  TestLog.Message("StayPrice: " +eFormCurrDetails.StayPrice +"; StayRateType: " +eFormCurrDetails.StayRateType);
      
  //Navigate to the CheckOutCharge Screen by clicking the Charge button
  objCheckOutShowPriceForm.NavigateToChargeScreen();
  if (objCheckOutShowPriceForm.lastError.name !== undefined) 
    throw objCheckOutShowPriceForm.lastError;
  else  
    TestLog.Message("Clicked Credit Card as Payment Type in CheckOutForm");
    
  sAccountNo = SQLQueries.getMonthlyCustomerAccountDetails().sAccountNo;
  Delay(1000);
    
  //Initialize object for CheckOutPaymentChargeForm
  objCheckOutPaymentChargeForm = CheckOutPaymentChargeForm.New();
    
  //Navigate to the Charge form and give valid account number
  objCheckOutPaymentChargeForm.SetAccountNumber(sAccountNo);
  if (objCheckOutPaymentChargeForm.lastError.name !== undefined) 
    throw objCheckOutPaymentChargeForm.lastError;
  else  
    TestLog.Message("Paid as Charge with Account number "+sAccountNo );
}
//----------------------------------------------------

function PayUsingCreditCardOption(){

  //Initialize object for CheckOutShowPrice Form
  objCheckOutSelectPaymentTypeForm = CheckOutSelectPaymentTypeForm.New();
      
  //Navigate to the CheckOutCharge Screen by clicking the Charge button
  objCheckOutSelectPaymentTypeForm.NavigateToCreditCardScreen();
  if (objCheckOutSelectPaymentTypeForm.lastError.name !== undefined) 
    throw objCheckOutSelectPaymentTypeForm.lastError;
  else  
    TestLog.Message("Clicked Credit Card as Payment Type in CheckOutForm");

      //Initialize object for CheckOutPaymentCreditCardOfflineForm
  objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
  //Navigate to the Credit Card Offline form and select the card type
  objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
  if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) 
    throw objCheckOutPaymentCreditCardOfflineForm.lastError;
  else  
    TestLog.Message("Paid with Credit Card");
    
}
//----------------------------------------------------
function EnableManualTicketEntry(){
    
  // Enable manual ticket entry
  objTechnicianMenuForm = TechnicianMenuForm.New();
  objTechnicianMenuForm.EnableManualTicketEntry();
  if (objTechnicianMenuForm.lastError.name !== undefined) 
    throw objTechnicianMenuForm.lastError;
  else    
    TestLog.Pass("Enabled manual ticket entry successfully");

}
//----------------------------------------------------
function GoToTechnicianMenu(){

  objMainDialog = MainDialog.New();
  objMainDialog.NavigateToTechnicianMenu();
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else   
    TestLog.Message("Clicked on Technician Menu Button");

}
//----------------------------------------------------
function SetManualTicketNumber(objTestData){

  objTestData.sTicketNumber = "9"+Utility.getRandomValue("NUMERIC", 5);

  // Enter manual ticket number
  objCheckInTicketNumberForm = CheckInTicketNumberForm.New();
  objCheckInTicketNumberForm.SetTicketNumber(objTestData.sTicketNumber);
  if (objCheckInTicketNumberForm.lastError.name !== undefined) 
    throw objCheckInTicketNumberForm.lastError; 
  else   
    TestLog.Message("Enter manual ticket number"); 
    
}
//----------------------------------------------------
function SetPrepayAmount(objTestData){

  // Enter manual ticket number
  objPrepaymentAmountForm = PrepaymentAmountForm.New();
  objPrepaymentAmountForm.InputPrepayDetails(objTestData);
  if (objPrepaymentAmountForm.lastError.name !== undefined) 
    throw objPrepaymentAmountForm.lastError; 
  else   
    TestLog.Message("Prepay amount of "+objTestData.sPrepayAmount+" set successfully");     
}
//----------------------------------------------------
function SetManualDateTime(){

  CheckInDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"); 
          
  // Enter manual checkin Date and Time
  objManualDateInformationDateForm = ManualDateInformationDateForm.New();
  objManualDateInformationDateForm.EnterCheckInDate(CheckInDate);
  objManualDateInformationDateForm.EnterCheckInTime();
  
  if (objManualDateInformationDateForm.lastError.name !== undefined) 
    throw objManualDateInformationDateForm.lastError;
  else
    TestLog.Message("Enter manual checkin Date and Time");
}
//----------------------------------------------------

function VerifyTicketDetails(objTestData){
     
  // Verify diaplayed Ticketno and tagNo matches
  objTicketInquiryForm = TicketInquiryForm.New();
  eVehicleDetails = objTicketInquiryForm.VerifyTicketInfo(objTestData);
  
  if(eVehicleDetails.bResult){
    objTestData.sColor       = eVehicleData.sColor;
    objTestData.sVehicleMake = eVehicleData.sVehicleMake;
    objTestData.sPlateNumber = eVehicleData.sPlateNumber;
    TestLog.Pass("Ticket Details Verified and are correct");
  }
  else
    TestLog.Error("Ticket Details Verified and are Incorrect");
    
  if (objTicketInquiryForm.lastError.name !== undefined) throw objTicketInquiryForm.lastError;

}
//----------------------------------------------------

function VerifyTicketDetailsByVehicleDetails(objTestData){

  try{
    objTicketInquiryResultsForm = TicketInquiryResultsForm.New();
  
    if(objTicketInquiryResultsForm.Exists()){
      eVehicleDetails = objTicketInquiryResultsForm.IsTicketAvailable(objTestData.sTicketNumber);
      if(eVehicleDetails.bDataAvailable){
        objTestData.sColor       == eVehicleData.sColor;
        objTestData.sVehicleMake == eVehicleData.sVehicleMake;
        objTestData.sPlateNumber == eVehicleData.sPlateNumber;
        objTestData.sTicketNumber== eVehicleData.sTicketNumber;
        TestLog.Pass("Ticket Details AvailableIn the Grid and are correct");
      }
      else
        TestLog.Error("Ticket Details Verified and are Incorrect");
    }
    else{
      VerifyTicketDetails(objTestData)
    }
  }
  catch(exception){
    VerifyTicketDetails(objTestData);
  }
}

//----------------------------------------------------
function EnableCreditCardOfflineMode(){

  objMainDialog = MainDialog.New();
  bResult = objMainDialog.ClickCreditCardOfflineButton();
 
  if (objMainDialog.lastError.name !== undefined) 
    throw objMainDialog.lastError;
  else {
    if(bResult)
      TestLog.Message("CreditCard Offline Enabled");
    else
      TestLog.Message("CreditCard Offline Already Enabled");
  }
}



