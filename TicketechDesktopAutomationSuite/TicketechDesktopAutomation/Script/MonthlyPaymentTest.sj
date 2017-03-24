//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT MainDialog
//USEUNIT MonthlyPaymentsInfoAccountNumberForm
//USEUNIT MonthlyPaymentsInfoForm
//USEUNIT MonthlyPaymentsCheckForm
//USEUNIT CheckOutPaymentCashForm
//USEUNIT CheckOutPaymentCreditCardOfflineForm
//USEUNIT CheckInCustomerPaymentStatusForm
//USEUNIT H6000IIPrinterForm


function TC_MONTH_PAY_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_001 : Verify the payment is recorded when the monthly Payment is done via CHECK for a monthly customer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objMonthlyPaymentCheckForm; //Stores the instance of MonthlyPayement Check Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
 
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "Check"
                      ,sTaxType     : "FullTax"
                      ,sBankName    : Utility.getRandomValue("ALPHA",5)
                      ,iCheckNumber : Utility.getRandomValue("NUMERIC",7)
                    }; 
  
  var eIncomeDetails;//stores the Income Details after Test case execution
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of MonthlyPaymentCheck Form
    objMonthlyPaymentCheckForm = MonthlyPaymentsCheckForm.New();
      
    //Step-4: Set Check details in each field of monthly payment Check form
    //------------------------------------------------------------------
    objMonthlyPaymentCheckForm.InputCheckDetails(objTestData);
    if (objMonthlyPaymentCheckForm.lastError.name !== undefined) throw objMonthlyPaymentCheckForm.lastError;
      
    TestLog.Message("Step-4: Navigated to MonthlyPaymentsCheck Form and submitted Check details");
    
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    objH6000IIPrinterForm.Exists();
    
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window"); 
    
    eIncomeResult = SQLQueries.getIncomeDetails(objTestData.sAccountNo);
    
    //TestCase Result : To verify that the Income and Payment details recorded after Monthly Payments
    bTestCaseResult = (eIncomeResult.bResult && SQLQueries.getPaymentDetails(objTestData)); 
    sPassMessage    = "TestCase Passed. The monthly Payment done via CHECK for the monthly customer "+ objTestData.sAccountNo;
    sFailMessage    = "TestCase Failed. The monthly Payment had unexpected behaviour";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objMonthlyPaymentCheckForm = null;
  objH6000IIPrinterForm = null;  
                    
}

function TC_MONTH_PAY_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_002 : Verify the payment is recorded when the monthly Payment is done via CASH for a monthly customer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCashForm; //Stores the instance of CheckOutPayement Cash Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
 
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "Cash"
                      ,sTaxType     : "FullTax"
                    }; 
  
  var eIncomeDetails;//stores the Income Details after Test case execution
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
    //Step-4: Set Cash details in CheckOutPaymentCash form
    //----------------------------------------------------
    objCheckOutPaymentCashForm.SetPaymentKeyBoard(objTestData.iPayAmount);
    if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCash Form and Submitted Pay Amount");
    
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    objH6000IIPrinterForm.Exists()
      
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    eIncomeResult = SQLQueries.getIncomeDetails(objTestData.sAccountNo);
    
    //TestCase Result : To verify that the Income and Payment details recorded after Monthly Payments
    bTestCaseResult = (eIncomeResult.bResult && SQLQueries.getPaymentDetails(objTestData)); 
    sPassMessage    = "TestCase Passed. The monthly Payment done via CASH for the monthly customer "+ objTestData.sAccountNo;
    sFailMessage    = "TestCase Failed. The monthly Payment had unexpected behaviour";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCashForm = null;
  objH6000IIPrinterForm = null;                      
}


function TC_MONTH_PAY_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_003 : Verify the payment is recorded when the monthly Payment is done via CREDITCARD for a monthly customer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCreditCardOfflineForm; //Stores the instance of CheckOutPayement CreditCardOffline Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
  
  //var aCreditCards = [{"Visa":1}, {"MasterCard":2}, {"Discover":3}, {"Diners":4}, {"American Express":5}];
 
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "CreditCard"
                      ,sTaxType     : "FullTax"
                      ,iCardIndex   : Utility.randomIntFromInterval(1,6)
                    }; 
  
  var eIncomeDetails;//stores the Income Details after Test case execution
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
      
    //Step-4: Select Card type in CheckOutPaymentCreditCardOffline form
    //-----------------------------------------------------------------
    objCheckOutPaymentCreditCardOfflineForm.SelectCard(objTestData.iCardIndex);
    if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCreditCardOffline Form and Selected Card Type");
    
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    objH6000IIPrinterForm.Exists()
      
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    eIncomeResult = SQLQueries.getIncomeDetails(objTestData.sAccountNo);
    
    //TestCase Result :  To verify that the Income and Payment details recorded after Monthly Payments
    bTestCaseResult = (eIncomeResult.bResult && SQLQueries.getPaymentDetails(objTestData)); 
    sPassMessage    = "TestCase Passed. The monthly Payment done via CREDIT CARD for the monthly customer "+ objTestData.sAccountNo;
    sFailMessage    = "TestCase Failed. The monthly Payment had unexpected behaviour";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCreditCardOfflineForm = null;
  objH6000IIPrinterForm = null;                      
}

function TC_MONTH_PAY_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_004 : Verify the payment is recorded when the monthly Payment is done by choosing Tax Type as Exemption
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCashForm; //Stores the instance of CheckOutPayement Cash Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
 
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "Cash"
                      ,sTaxType     : "Exemption"
                    }; 
  
  var eIncomeDetails;//stores the Income Details after Test case execution
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
    //Step-4: Set Pay details in CheckOutPaymentCash form
    //---------------------------------------------------
    objCheckOutPaymentCashForm.SetPaymentKeyBoard(objTestData.iPayAmount);
    if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCash Form and Submitted Pay amount");
    
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    objH6000IIPrinterForm.Exists()
      
    TestLog.Message("Step-5: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    eIncomeResult = SQLQueries.getIncomeDetails(objTestData.sAccountNo);
    
    //TestCase Result :  To verify that the Income and Payment details recorded after Monthly Payments
    bTestCaseResult = (eIncomeResult.bResult && SQLQueries.getPaymentDetails(objTestData)); 
    sPassMessage    = "TestCase Passed. The monthly Payment done by choosing Tax Type as Exemption for the monthly customer "+ objTestData.sAccountNo;
    sFailMessage    = "TestCase Failed. The monthly Payment had unexpected behaviour";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCashForm = null;
  objH6000IIPrinterForm = null;                      
}

function TC_MONTH_PAY_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_005 : Verify a proper error message is getting displayed if the entered customer account number is invalid.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckInCustomerPaymentStatusForm; // Stores the instance of CheckInCustomerPaymentStatus Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Declaring and initializing Test Data object 
  var objTestData = { 
                      sAccountNo       : Utility.getRandomValue("ALPHANUMERIC",5),
                      sExpectedMessage : "CUSTOMER DOES NOT EXIST."
                    }; 
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit invalid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted Invalid Account number.");
    
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objCheckInCustomerPaymentStatusForm = CheckInCustomerPaymentStatusForm.New();
      
    //Step-3: Get Error Message from CheckInCustomerPaymentStatusForm
    //---------------------------------------------------------------
    eStatusDetails = objCheckInCustomerPaymentStatusForm.GetFormInfo();
    if (objCheckInCustomerPaymentStatusForm.lastError.name !== undefined) throw objCheckInCustomerPaymentStatusForm.lastError;
      
    TestLog.Message("Step-3: Navigated to PaymentStatus Form and Got Error Info.");
       
    //TestCase Result : To verify that expected Message is diaplayed for an Invalid Customer Account
    bCheck1 = (aqString.Find(eStatusDetails.sAccountNumber,objTestData.sAccountNo)!= -1);
    bCheck2 = (aqString.ToUpper(eStatusDetails.sScreenMessage.OleValue) === objTestData.sExpectedMessage);
    bTestCaseResult = (bCheck1 && bCheck2); 
    sPassMessage    = "TestCase Passed. Expected Error Message displayed for Invalid Customer Account";
    sFailMessage    = "TestCase Failed. UnExpected/No error message displayed for Invalid Customer Account";
    
    TestLog.Message("Error Message displayed: " +eStatusDetails.sScreenMessage.OleValue+ " for invalid Account No. "+ objTestData.sAccountNo);
    
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
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckInCustomerPaymentStatusForm = null;                    
}

function TC_MONTH_PAY_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_006 : Verify a proper error message is getting displayed if the credit card type is not given.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCreditCardOfflineForm; //Stores the instance of CheckOutPayement CreditCardOffline Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
   
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "CreditCard"
                      ,sTaxType     : "FullTax"
                    };  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
      
    //Step-4: Get Error Message from CheckOutPaymentCreditCardOfflineForm
    //-------------------------------------------------------------------
    sActualMessage = objCheckOutPaymentCreditCardOfflineForm.SubmitForm();
    if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCreditCardOffline Form and submitted without selecting Credit card type");

    //TestCase Result : To verify that expected Message is diaplayed for not slecting credit card type
    bTestCaseResult = (sActualMessage.Equals("CREDIT CARD NOT ENTERED.")); 
    sPassMessage    = "TestCase Passed. Expected Error Message displayed for submitting the Payment without selecting CreditCard Type";
    sFailMessage    = "TestCase Failed. UnExpected/No Error Message displayed for submitting the Payment without selecting CreditCard Type";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCreditCardOfflineForm = null;
                    
}

//TC_MONTH_PAY_007 -- Skipped
//TC_MONTH_PAY_008 -- Skipped
//TC_MONTH_PAY_009 -- Skipped


function TC_MONTH_PAY_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_010 : Verify that after clicking the cancel button the screen returns to home screen and 
                     no transaction takes palce.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCreditCardOfflineForm; //Stores the instance of CheckOutPayement CreditCardOffline Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
   
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.getRandomValue("NUMERIC",2)
                      ,sPayType     : "CreditCard"
                      ,sTaxType     : "FullTax"
                    };  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
      
    //Step-4: Naviagate to CheckOutPaymentCreditCardOfflineForm and click Cancel
    //--------------------------------------------------------------------------
    sActualMessage = objCheckOutPaymentCreditCardOfflineForm.CancelForm();
    if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCreditCardOffline Form and Clicked Cancel");
    
    objMainDialog = MainDialog.New();

    //TestCase Result : To verify that MainScreen is diaplayed if cancel button is clicked
    bTestCaseResult = (objMainDialog.GetFormInfo().Title === "MAIN MENU"); 
    sPassMessage    = "TestCase Passed. Clicking Cancel terminates the transaction and returns to Main Screen";
    sFailMessage    = "TestCase Failed. Unexpected Behaviour during transaction termination, by clicking Cancel button";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCreditCardOfflineForm = null;                   
}

function TC_MONTH_PAY_011() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_011 : Verify the error mesage by giving an account number whose tag is deleted under the 'monthly customer' category.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckInCustomerPaymentStatusForm; // Stores the instance of CheckInCustomerPaymentStatus Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Get a random customer and update their respective account to soft delete
  //Declaring and initializing Test Data object 
  var objTestData = { 
                      sAccountNo       : SQLQueries.getMonthlyCustomerAccountDetails().sAccountNo,
                      sExpectedMessage : "CUSTOMER DOES NOT EXIST."
                    }; 
  //Update the Customer account to soft delete
  SQLQueries.updateCustomerAccountStatus(objTestData.sAccountNo,0);
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit deleted CutomerAccount
    //-------------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted Invalid Account number.");
    
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objCheckInCustomerPaymentStatusForm = CheckInCustomerPaymentStatusForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    eStatusDetails = objCheckInCustomerPaymentStatusForm.GetFormInfo();
    if (objCheckInCustomerPaymentStatusForm.lastError.name !== undefined) throw objCheckInCustomerPaymentStatusForm.lastError;
      
    TestLog.Message("Step-3: Navigated to PaymentStatus Form and Got Error Info.");
       
    //TestCase Result : To verify that expected Message is diaplayed for soft deleted Customer Account
    bCheck1 = (aqString.Find(eStatusDetails.sAccountNumber,objTestData.sAccountNo)!= -1);
    bCheck2 = (aqString.ToUpper(eStatusDetails.sScreenMessage.OleValue) === objTestData.sExpectedMessage);
    bTestCaseResult = (bCheck1 && bCheck2); 
    sPassMessage    = "TestCase Passed. Expected Error Message displayed for Soft Deleted Customer Account";
    sFailMessage    = "TestCase Failed. UnExpected/No error message displayed for Soft Deleted Customer Account";
    
    TestLog.Message("Error Message displayed: " +eStatusDetails.sScreenMessage.OleValue+ " for invalid Account No. "+ objTestData.sAccountNo);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult, sPassMessage, sFailMessage);
    //Update status back     
    SQLQueries.updateCustomerAccountStatus(objTestData.sAccountNo,1);                                        
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
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckInCustomerPaymentStatusForm = null;                    
}

function TC_MONTH_PAY_012() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_012 : Verify that Split Payment is possible for a Monthly Payment Transaction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCashForm; //Stores the instance of CheckOutPayement Cash Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
 
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,iPayAmount   : Utility.randomIntFromInterval(51,99)
                      ,sPayType     : "Cash"
                      ,sTaxType     : "FullTax"
                      ,iSplitAmount : Utility.randomIntFromInterval(15,35)
                    }; 
  
  var eIncomeDetails;//stores the Income Details after Test case execution
  
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
    //Step-4: Set Pay Detail in Pay field of CheckOutPaymentCashForm (Split Payment 1)
    //--------------------------------------------------------------------------------
    objCheckOutPaymentCashForm.SetPaymentKeyBoard(objTestData.iPayAmount - objTestData.iSplitAmount);
    if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCash Form and submitted Amount to Pay");
    
    //Step-5: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-5: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
    //Step-6: Set Set Pay Detail in Pay field of CheckOutPaymentCashForm (Split Payment 2)
    //------------------------------------------------------------------------------------
    objCheckOutPaymentCashForm.SetPaymentKeyBoard(objTestData.iSplitAmount);
    if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
    TestLog.Message("Step-6: Navigated to CheckOutPaymentCash Form and submitted Amount to Pay");
    
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
    objH6000IIPrinterForm.Exists()
      
    TestLog.Message("Step-7: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    eIncomeResult = SQLQueries.getIncomeDetails(objTestData.sAccountNo);
    
    //TestCase Result : To verify that the Income and Payment details recorded after Monthly Payments
    bTestCaseResult = (eIncomeResult.bResult && SQLQueries.getPaymentDetails(objTestData)); 
    sPassMessage    = "TestCase Passed. The monthly Payment done with Split Payment method for the monthly customer "+ objTestData.sAccountNo;
    sFailMessage    = "TestCase Failed. The monthly Payment had unexpected behaviour during Split Payment";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCashForm = null;
  objH6000IIPrinterForm = null;                      
}

function TC_MONTH_PAY_013() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_MONTH_PAY_013 : Verify that if the Pay amount is given empty, user gets an error message.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objMonthlyPaymentsInfoForm; //Stores the instance of Monthly Payments Info Form
  var objMonthlyPaymentsInfoAccountNumberForm; //Stores the instance of MonthlyPaymentsInfo AccountNoForm
  var objCheckOutPaymentCashForm; //Stores the instance of CheckOutPayement Cash Form

  var bTestCaseResult; //Boolean variable to store TestCase result
  
  //Getting MonthlyCustomerAccount Details that are available in MonthlyCustomers Table
  var eCustAccountDetails = SQLQueries.getMonthlyCustomerAccountDetails();
 
  //Declaring and initializing Test Data object 
  var objTestData = {  sAccountNo   : eCustAccountDetails.sAccountNo
                      ,sPayType     : "Cash"
                      ,sTaxType     : "FullTax"
                      ,iPayAmount   : Utility.randomIntFromInterval(51,99)
                    }; 
  try {                    
     
    //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();
      
    //Step-2: Navigate into MonthlyPaymentInfoAccountNumberForm and submit valid CutomerAccount
    //-----------------------------------------------------------------------------------------
    objMainDialog.NavigateToMonthlyPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Monthly Payment button.");
      
    //Initialize object of MonthlyPaymentInfoAccountNumberForm 
    objMonthlyPaymentInfoAccountNumberForm = MonthlyPaymentsInfoAccountNumberForm.New();
      
    //Set data in Account number field and click Enter button from Navigation panel
    objMonthlyPaymentInfoAccountNumberForm.InputAndSubmitForm(objTestData);
    if (objMonthlyPaymentInfoAccountNumberForm.lastError.name !== undefined) throw objMonthlyPaymentInfoAccountNumberForm.lastError;
      
    TestLog.Message("Step-2: Navigated to MonthlyPaymentsAccountNumber Form and submitted valid Account number.");
      
    //Initialize object of MonthlyPaymentInfo Form
    objMonthlyPaymentInfoForm = MonthlyPaymentsInfoForm.New();
      
    //Step-3: Set Pay details in each field of monthly payment info form
    //------------------------------------------------------------------
    objMonthlyPaymentInfoForm.InputPayDetails(objTestData);
    if (objMonthlyPaymentInfoForm.lastError.name !== undefined) throw objMonthlyPaymentInfoForm.lastError;
      
    TestLog.Message("Step-3: Navigated to MonthlyPaymentsInfo Form and submitted valid Pay details");
    
    //Initialize object of CheckOutPaymentCash Form
    objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
    //Step-4: Submit form without entering Cash detail
    //------------------------------------------------
    sActualErrorMessage = objCheckOutPaymentCashForm.SubmitForm();
    if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
    TestLog.Message("Step-4: Navigated to CheckOutPaymentCash Form and Submitted Empty Pay Amount");
    
    //TestCase Result : To verify that the error message for empty cash is displayed as expected
    bTestCaseResult = (sActualErrorMessage.Equals("PAY ENTERED NOT VALID")); 
    sPassMessage    = "TestCase Passed. Expected Error message displayed for empty cash entered in Payment Cash Form";
    sFailMessage    = "TestCase Failed. Unexpected/No Error message displayed for empty cash entered in Payment Cash Form";
    
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
  objMonthlyPaymentsInfoForm = null; 
  objMonthlyPaymentsInfoAccountNumberForm = null;
  objCheckOutPaymentCashForm = null;                     
}
