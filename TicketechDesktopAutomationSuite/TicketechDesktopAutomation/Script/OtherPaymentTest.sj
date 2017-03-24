//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT OtherIncomeInfoCodeForm
//USEUNIT OtherIncomeInfoAmountForm
//USEUNIT CheckOutPaymentCashForm
//USEUNIT H6000IIPrinterForm
//USEUNIT OtherIncomePaymentChargeForm
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT CheckOutPaymentCreditCardOfflineForm


function TC_OTH_PAY_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_001 :Verify that the proper error message is displayed when the Income field is kept empty
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog= MainDialog.New();
      
      //Step-2: Navigate into other Income screen and click Other payments button
      //--------------------------------------------------------------------
      objMainDialog.NavigateToOtherPaymentScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Other Payment button.");
      
      //Initialize object of OtherIncomeInfoCodeForm 
      objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
      //Step-3: Click  other income button from OtherIncomeCode Panel.
      //-------------------------------------------------------------
      sActualErrorMessage = objOtherIncomeInfoCodeForm.SubmitForm();
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      //TestCase Result : To verify that the employee's Timecard Report is available
      bTestCaseResult = sActualErrorMessage == "OTHER INCOME IS NOT VALID.";
      sPassMessage    = "Test Passed. Expected Error Message is displayed when Income field is left empty";
      sFailMessage    = "Test Failed. Unexpected/No error message is displayed";
    
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
  objOtherIncomeInfoCodeForm=null;
}  

function TC_OTH_PAY_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_002 :Verify that the other payments made by choosing the mode of payment as CASH is successful
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var objOtherIncomeInfoAmountForm;//Stores the instance of OtherIncomeInfoAmount Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var objCheckOutPaymentCashForm;//Stores the instance of CheckOutPaymentCash Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form 
  
  try {
    
      objTestData = {
                     Description: Utility.getRandomValue("ALPHA", 3),
                     iPayAmount : Utility.randomIntFromInterval(1,99),
                     sPayType   : "Cash" 
                    }; //TestData object for other payments
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog= MainDialog.New();
      
      //Step-2: Navigate into other Income screen and click Other payments button
      //--------------------------------------------------------------------
      objMainDialog.NavigateToOtherPaymentScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Other Payment button.");
      
      //Initialize object of OtherIncomeInfoCodeForm 
      objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
      //Step-3: Click  other income button from OtherIncomeCode Panel.
      //-------------------------------------------------------------
      objOtherIncomeInfoCodeForm.ClickOtherIncome();
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-2: Clicked Other Income button");
      
      //Set description and click Enter button from Navigation panel
      objOtherIncomeInfoCodeForm.ProvideDescription(objTestData.Description);
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-3: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");   
      
      //Initialize object of OtherIncomeInfoAmountForm 
      objOtherIncomeInfoAmountForm = OtherIncomeInfoAmountForm.New();
      
      //Step-4: Set amount for Amount field and click Cash button for Payment Type field
      //----------------------------------------------------------------------------------
      objOtherIncomeInfoAmountForm.InputPayDetails(objTestData);
      if (objOtherIncomeInfoAmountForm.lastError.name !== undefined) throw objOtherIncomeInfoAmountForm.lastError;
      
      TestLog.Message("Step-4: Navigated to objOtherIncomeInfoAmountForm and entered amount.");
        
      //Step-4: Select Cash from OtherIncomeSelectPaymentPanel
      //------------------------------------------------------
      TestLog.Message("Step-5: Clicked Cash button"); 
      
      //Initialize object of CheckOutPaymentCashForm 
      objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
      //Step-5: Select the amount to be paid from Money Panel
      //--------------------------------------------------------
      objCheckOutPaymentCashForm.SetPaymentbyButton(objTestData.iPayAmount);
      if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
      TestLog.Message("Step-6: Navigated to objCheckOutPaymentCashForm and paid amount.");
      
      //Initialize object of H6000IIPrinterForm 
      objH6000IIPrinterForm = H6000IIPrinterForm.New();

      TestLog.Message("Verified "+objH6000IIPrinterForm.windowTitle+" Window");
      
      TestLog.Message("Step-7: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
      //TestCase Result : To verify that the employee's Timecard Report is available
      bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
      sPassMessage    = "Test Passed. The customer's payment through cash mode is succesful";
      sFailMessage    = "Test Failed. The customer's payment through cash mode is unsuccesful";
    
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
  objOtherIncomeInfoCodeForm=null;
  objOtherIncomeInfoAmountForm=null;
  objCheckOutPaymentCashForm=null;
  objH6000IIPrinterForm = null;
}  

function TC_OTH_PAY_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_003 :Verify that the other payments made by choosing the mode of payment as CASH is failed if user try to enter an amount less than the Payable amount
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

 //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var objOtherIncomeInfoAmountForm;//Stores the instance of OtherIncomeInfoAmount Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var objCheckOutPaymentCashForm;//Stores the instance of CheckOutPaymentCash Form
  var sActualErrorMessage;//Stores the error message to be displayed 
  var sExpectedErrorMessage = "PAYMENTS ERROR."//Stores the expected message
  
  try {
    
      objTestData = {
                     Description: Utility.getRandomValue("ALPHA", 3),
                     iPayAmount : Utility.getRandomValue("NUMERIC",2),
                     sPayType   : "Cash" 
                    }; //TestData object for other payments
      Log.Message(objTestData.Description);
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog= MainDialog.New();
      
      //Step-2: Navigate into other Income screen and click Other payments button
      //--------------------------------------------------------------------
      objMainDialog.NavigateToOtherPaymentScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Other Payment button.");
      
      //Initialize object of OtherIncomeInfoCodeForm 
      objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
      //Step-3: Click  other income button from OtherIncomeCode Panel.
      //-------------------------------------------------------------
      objOtherIncomeInfoCodeForm.ClickOtherIncome();
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-2: Clicked Other Income button");
      
      //Set description and click Enter button from Navigation panel
      objOtherIncomeInfoCodeForm.ProvideDescription(objTestData.Description);
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-3: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");   
      
      //Initialize object of OtherIncomeInfoAmountForm 
      objOtherIncomeInfoAmountForm = OtherIncomeInfoAmountForm.New();
      
      //Step-4: Enter amount under Amount field and click Cash button for Payment Type field
      //----------------------------------------------------------------------------------
      objOtherIncomeInfoAmountForm.InputPayDetails(objTestData);
      if (objOtherIncomeInfoAmountForm.lastError.name !== undefined) throw objOtherIncomeInfoAmountForm.lastError;
      
      TestLog.Message("Step-4: Navigated to objOtherIncomeInfoAmountForm and entered amount.");
        
      //Step-4: Select Cash from OtherIncomeSelectPaymentPanel
      //------------------------------------------------------
      TestLog.Message("Step-5: Clicked Cash button"); 
      
      //Initialize object of CheckOutPaymentCashForm 
      objCheckOutPaymentCashForm = CheckOutPaymentCashForm.New();
      
      //Step-5: Select the amount to be paid from Money Panel
      //--------------------------------------------------------
      objCheckOutPaymentCashForm.SelectLesserAmount();
      if (objCheckOutPaymentCashForm.lastError.name !== undefined) throw objCheckOutPaymentCashForm.lastError;
      
      TestLog.Message("Step-6: Navigated to objCheckOutPaymentCashForm and paid lesser amount.");
      
      //Initialize object of OtherIncomeInfoCodeForm 
      objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      sActualErrorMessage= objOtherIncomeInfoCodeForm.GetFormInfo().sFooterMessage;
      TestLog.Message(sActualErrorMessage);
      
      //TestCase Result : To verify that the proper error message is displayed
      bTestCaseResult =  (sActualErrorMessage === sExpectedErrorMessage)
      sPassMessage    = "Test Passed. The error message is displayed as expected when user tries to enter amount less than the Payable amount";
      sFailMessage    = "Test Failed. Unexpected Error Message is displayed";
    
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
  objOtherIncomeInfoCodeForm=null;
  objOtherIncomeInfoAmountForm=null;
  objCheckOutPaymentCashForm=null; 
}

function TC_OTH_PAY_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_004 :Verify that the other payments made by choosing the mode of payment as CARD is successful
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var objOtherIncomeInfoAmountForm;//Stores the instance of OtherIncomeInfoAmount Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var objCheckOutPaymentCreditCardOfflineForm;//Stores the instance of CheckOutPaymentCreditCardOfflineForm
  
  try {
    
      objTestData = {
                     Description: Utility.getRandomValue("ALPHA", 3),
                     iPayAmount : Utility.getRandomValue("NUMERIC",2),
                     sPayType   : "CreditCard" 
                      }; //TestData object for other payments
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog= MainDialog.New();
      
      //Step-2: Navigate into other Income screen and click Other payments button
      //--------------------------------------------------------------------
      objMainDialog.NavigateToOtherPaymentScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Other Payment button.");
      
      //Initialize object of OtherIncomeInfoCodeForm 
      objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
      //Step-3: Click  other income button from OtherIncomeCode Panel.
      //-------------------------------------------------------------
      objOtherIncomeInfoCodeForm.ClickOtherIncome();
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-2: Clicked Other Income button");
      
      //Set description and click Enter button from Navigation panel
      objOtherIncomeInfoCodeForm.ProvideDescription(objTestData.Description);
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-3: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");   
      
      //Initialize object of OtherIncomeInfoAmountForm 
      objOtherIncomeInfoAmountForm = OtherIncomeInfoAmountForm.New();
      
      //Step-4: Set amount for Amount field and click Cash button for Payment Type field
      //----------------------------------------------------------------------------------
      objOtherIncomeInfoAmountForm.InputPayDetails(objTestData);
      if (objOtherIncomeInfoAmountForm.lastError.name !== undefined) throw objOtherIncomeInfoAmountForm.lastError;
      
      TestLog.Message("Step-4: Navigated to objOtherIncomeInfoAmountForm and entered amount.");
        
      //Step-4: Select Cash from OtherIncomeSelectPaymentPanel
      //------------------------------------------------------
      TestLog.Message("Step-5: Clicked Credit Card button"); 
      
      //Initialize object for CheckOutPaymentCreditCardOfflineForm
      objCheckOutPaymentCreditCardOfflineForm = CheckOutPaymentCreditCardOfflineForm.New();
    
      //Navigate to the Credit Card Offline form and select the card type
      objCheckOutPaymentCreditCardOfflineForm.SelectCard(Utility.randomIntFromInterval(1,6));
      if (objCheckOutPaymentCreditCardOfflineForm.lastError.name !== undefined) throw objCheckOutPaymentCreditCardOfflineForm.lastError;
    
      TestLog.Message("Step-6: Clicked Card in CheckOutPaymentCreditCardOfflineForm");
      
      //Initialize object of H6000IIPrinterForm 
      objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
      TestLog.Message("Step-7: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
      
      //TestCase Result : To verify that the employee's Timecard Report is available
      bTestCaseResult = (objH6000IIPrinterForm.Exists()); 
      sPassMessage    = "Test Passed. The customer's payment through Credit Card is succesful";
      sFailMessage    = "Test Failed. Unexpected behaviour during credit card payment";
    
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
  objOtherIncomeInfoCodeForm=null;
  objOtherIncomeInfoAmountForm=null;
  objCheckOutPaymentCreditCardOfflineForm = null;
}  


function TC_OTH_PAY_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_005 :Verify that the other payments made by choosing the mode of payment as CHARGE is successful
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

 //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var objOtherIncomeInfoAmountForm;//Stores the instance of OtherIncomeInfoAmount Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  var objOtherIncomePaymentChargeForm;//Stores the instance of CheckOutPaymentCash Form
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinter Form
  
  try {

   objTestData = {
                   sDescription: Utility.getRandomValue("ALPHA", 3),
                   iPayAmount  : Utility.getRandomValue("NUMERIC",2),
                   sAccountNo  : SQLQueries.getMonthlyCustomerAccountDetails().sAccountNo,
                   sPayType    : "Charge" 
                   }; //TestData object for other payments
                   
     
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into other Income screen and click Other payments button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToOtherPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Other Payment button.");
      
    //Initialize object of OtherIncomeInfoCodeForm 
    objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
    //Step-3: Click  other income button from OtherIncomeCode Panel.
    //-------------------------------------------------------------
    objOtherIncomeInfoCodeForm.ClickOtherIncome();
    if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
    TestLog.Message("Step-2: Clicked Other Income button");
      
    //Set description and click Enter button from Navigation panel
    objOtherIncomeInfoCodeForm.ProvideDescription(objTestData.sDescription);
    if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");   
      
    //Initialize object of OtherIncomeInfoAmountForm 
    objOtherIncomeInfoAmountForm = OtherIncomeInfoAmountForm.New();
      
    //Step-4: Set amount for Amount field and click Charge button for Payment Type field
    //----------------------------------------------------------------------------------
    objOtherIncomeInfoAmountForm.InputPayDetails(objTestData);
    if (objOtherIncomeInfoAmountForm.lastError.name !== undefined) throw objOtherIncomeInfoAmountForm.lastError;
      
    TestLog.Message("Step-4: Navigated to objOtherIncomeInfoAmountForm and entered amount.");
        
    //Step-4: Select Cash from OtherIncomeSelectPaymentPanel
    //------------------------------------------------------
    TestLog.Message("Step-5: Clicked Charge button"); 
      
    //Initialize object of CheckOutPaymentCashForm 
    objOtherIncomePaymentChargeForm = OtherIncomePaymentChargeForm.New();
      
    //Step-5: Select the amount to be paid from Money Panel
    //--------------------------------------------------------
    objOtherIncomePaymentChargeForm.InputAndSubmitForm(objTestData.sAccountNo);
    if (objOtherIncomePaymentChargeForm.lastError.name !== undefined) throw objOtherIncomePaymentChargeForm.lastError;
      
    TestLog.Message("Step-6: Navigated to objOtherIncomePaymentChargeForm and valid account number is given.");
      
    //Initialize object of H6000IIPrinterForm 
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-7: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = objH6000IIPrinterForm.Exists();
    sPassMessage    = "Test Passed. The customer's payment through charge is successful";
    sFailMessage    = "Test Failed. The customer's payment through charge is unsuccessful";
    
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
  objOtherIncomeInfoCodeForm=null;
  objOtherIncomeInfoAmountForm=null;
  objCheckOutPaymentCashForm=null;
  objH6000IIPrinterForm=null;
}

function TC_OTH_PAY_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_006 :Verify that the proper error message is displayed when the Description field is kept empty
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
     
      //Step-1: Launching the POS application and Initialize the objMainDialog screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      objMainDialog= MainDialog.New();
      
      //Step-2: Navigate into other Income screen and click Other payments button
      //--------------------------------------------------------------------
      objMainDialog.NavigateToOtherPaymentScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
      TestLog.Message("Step-1: Clicked Other Payment button.");
      
      //Initialize object of OtherIncomeInfoCodeForm 
      objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
      //Step-3: Click  other income button from OtherIncomeCode Panel.
      //-------------------------------------------------------------
      objOtherIncomeInfoCodeForm.ClickOtherIncome();
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
      TestLog.Message("Step-2: Clicked Other Income button");
      
      //Set description and click Enter button from Navigation panel
      sActualErrorMessage = objOtherIncomeInfoCodeForm.SubmitForm();
      if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;

      //TestCase Result : To verify that the employee's Timecard Report is available
      bTestCaseResult = sActualErrorMessage == "DESCRIPTION CANNOT BE EMPTY."; 
      sPassMessage    = "Test Passed. Expected Error Message is displayed when Description field is left empty";
      sFailMessage    = "Test Failed. Unexpected/No error message is displayed";
      
      TestLog.Message("Error Meesage : "+sActualErrorMessage +"");
    
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
  objOtherIncomeInfoCodeForm=null;
}

function TC_OTH_PAY_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_007 :Verify that the proper error message is displayed when the Amount field is kept empty
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

 //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var objOtherIncomeInfoAmountForm;//Stores the instance of OtherIncomeInfoAmount Form
  var bTestCaseResult;//Boolean variable to store the TestCase result

  try {

   objTestData = {
                   sDescription: Utility.getRandomValue("ALPHA", 3),
                   iPayAmount  : "0"
                   }; //TestData object for other payments
     
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into other Income screen and click Other payments button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToOtherPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Other Payment button.");
      
    //Initialize object of OtherIncomeInfoCodeForm 
    objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
    //Step-3: Click  other income button from OtherIncomeCode Panel.
    //-------------------------------------------------------------
    objOtherIncomeInfoCodeForm.ClickOtherIncome();
    if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
    TestLog.Message("Step-2: Clicked Other Income button");
      
    //Set description and click Enter button from Navigation panel
    objOtherIncomeInfoCodeForm.ProvideDescription(objTestData.sDescription);
    if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");   
      
    //Initialize object of OtherIncomeInfoAmountForm 
    objOtherIncomeInfoAmountForm = OtherIncomeInfoAmountForm.New();
    
      
    //Step-4: Set amount for Amount field and click Charge button for Payment Type field
    //----------------------------------------------------------------------------------
    sActualErrorMessage  = objOtherIncomeInfoAmountForm.InputPayDetailsWithErrors(objTestData);
    if (objOtherIncomeInfoAmountForm.lastError.name !== undefined) throw objOtherIncomeInfoAmountForm.lastError;
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = sActualErrorMessage == "OTHER INCOME AMOUNT NOT ENTERED.";
    sPassMessage    = "Test Passed. Expected error message is displayed when Income field is left blank";
    sFailMessage    = "Test Failed. Unexpected/No error message is dispalyed";
    
    TestLog.Message("Error Meesage : "+sActualErrorMessage +"");
    
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
  objOtherIncomeInfoCodeForm=null;
  objOtherIncomeInfoAmountForm=null;
}

function TC_OTH_PAY_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_OTH_PAY_008 :Verify that the proper error message is displayed when the Pay type is not selected
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

 //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objOtherIncomeInfoCodeForm; //Stores the instance of OtherIncomeInfoCode Form
  var objOtherIncomeInfoAmountForm;//Stores the instance of OtherIncomeInfoAmount Form
  var bTestCaseResult;//Boolean variable to store the TestCase result

  try {

   objTestData = {
                   sDescription: Utility.getRandomValue("ALPHA", 3),
                   iPayAmount  : Utility.randomIntFromInterval(1,99),
                   sPayType    : ""
                   }; //TestData object for other payments
     
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into other Income screen and click Other payments button
    //--------------------------------------------------------------------
    objMainDialog.NavigateToOtherPaymentScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Other Payment button.");
      
    //Initialize object of OtherIncomeInfoCodeForm 
    objOtherIncomeInfoCodeForm = OtherIncomeInfoCodeForm.New();
      
    //Step-3: Click  other income button from OtherIncomeCode Panel.
    //-------------------------------------------------------------
    objOtherIncomeInfoCodeForm.ClickOtherIncome();
    if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
    TestLog.Message("Step-2: Clicked Other Income button");
      
    //Set description and click Enter button from Navigation panel
    objOtherIncomeInfoCodeForm.ProvideDescription(objTestData.sDescription);
    if (objOtherIncomeInfoCodeForm.lastError.name !== undefined) throw objOtherIncomeInfoCodeForm.lastError;
      
    TestLog.Message("Step-3: Navigated to objOtherIncomeInfoCodeForm Form and submitted Description.");   
      
    //Initialize object of OtherIncomeInfoAmountForm 
    objOtherIncomeInfoAmountForm = OtherIncomeInfoAmountForm.New();
    
      
    //Step-4: Set amount for Amount field and click Charge button for Payment Type field
    //----------------------------------------------------------------------------------
    sActualErrorMessage  = objOtherIncomeInfoAmountForm.InputPayDetailsWithErrors(objTestData);
    if (objOtherIncomeInfoAmountForm.lastError.name !== undefined) throw objOtherIncomeInfoAmountForm.lastError;
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = sActualErrorMessage == "PAYMENT TYPE NOT ENTERED.";
    sPassMessage    = "Test Passed. Expected error message is displayed when Payment is Not selected";
    sFailMessage    = "Test Failed. Unexpected/No error message is dispalyed";
    
    TestLog.Message("Error Meesage : "+sActualErrorMessage +"");
    
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
  objOtherIncomeInfoCodeForm=null;
  objOtherIncomeInfoAmountForm=null;
}

