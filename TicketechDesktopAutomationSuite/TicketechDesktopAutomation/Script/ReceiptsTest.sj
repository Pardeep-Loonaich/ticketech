//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT ReprintReceiptsTicketNumberForm
//USEUNIT ReprintReceiptsOtherIncomesMonthliesForm
//USEUNIT H6000IIPrinterForm
//USEUNIT DBUtility
//USEUNIT SQLQueries
  

function TC_RCPT_TKT_001() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_001: Verify that the default Ticket number Receipt can be printed through ENTER button
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
     //Step-1: Launching the POS application and Initialize the MainDialog
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Print Default available Ticket by clicking Enter
    //--------------------------------------------------------
    bResultFlag = objReprintReceiptsTicketNumberForm.PrintByEnter();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2:Clicked Enter button"); 
    
    if (bResultFlag === 1){
      //Initialize object of H6000IIPrinterForm 
      objH6000IIPrinterForm = H6000IIPrinterForm.New();
      TestLog.Message("Step-3: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
      bTestCaseResult = objH6000IIPrinterForm.Exists();      
    }
    else {
      bTestCaseResult = false;
    }
   
    // TestCase Result : To verify whether the receipt is printed or not
    sPassMessage    = "Test Passed. The receipt is printed successfully for the default Available StayTicket via Enter";
    sFailMessage    = "Test Failed. Unexpected error during Print Receipt due to Invalid Ticket Number";
    
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
  objReprintReceiptsTicketNumberForm=null;
  objH6000IIPrinterForm=null;
}

function TC_RCPT_TKT_002() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_002 :Verify the receipt is printed via 'Print Receipts' button for the default available TicketNumber
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objH6000IIPrinterForm;//Stores the instance of H6000IIPrinter Form
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
     
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //----------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click Print Receipt button with default ticket number in Ticket# field
    //------------------------------------------------------------------------------
    bResultFlag = objReprintReceiptsTicketNumberForm.PrintByPrintReceipt();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2:Clicked Print Receipts button"); 
   
    if (bResultFlag === 1){
      //Initialize object of H6000IIPrinterForm 
      objH6000IIPrinterForm = H6000IIPrinterForm.New();
      TestLog.Message("Step-3: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
      bTestCaseResult = objH6000IIPrinterForm.Exists();      
    }
    else {
      bTestCaseResult = false;
    }
   
    // TestCase Result : To verify whether the receipt is printed or not
    sPassMessage    = "Test Passed. The receipt is printed successfully for the default Available StayTicket via Print Receipt";
    sFailMessage    = "Test Failed. Unexpected error during Print Receipt due to Invalid Ticket Number";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objH6000IIPrinterForm = null;
}

function TC_RCPT_TKT_003() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_003: Verify the receipt is getting auto printed for any valid Ticket Number with 6 digits
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration
  //--------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objH6000IIPrinterForm; //Stores the instance of H6000IIPrinter Form
  
  var bTestCaseResult; //Boolean variable to store the TestCase result
  
  objTestData = { sTicketNumber : SQLQueries.getTicketNumber("Daily") }; //TestData object for ticket number
  
  try {
                   
    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Set ticket number in Ticket# field 
    //------------------------------------------
    objReprintReceiptsTicketNumberForm.InputTicketNumberAndSubmit(objTestData.sTicketNumber);
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Submitted ticket number: " +objTestData.sTicketNumber); 
   
    //Initialize object of H6000IIPrinterForm 
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-3: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    // TestCase Result : To verify whether the receipt is being printed for valid ticket number
    bTestCaseResult = objH6000IIPrinterForm.Exists();
    sPassMessage    = "Test Passed. The receipt is printed for Ticket Number :"+objTestData.sTicketNumber;
    sFailMessage    = "Test Failed. Unexpected error during Print Receipt";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objH6000IIPrinterForm = null;
}

function TC_RCPT_TKT_004() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_RCPT_TKT_004 :Verify an error message is displayed when invalid ticket number is given 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  
  var sExpectedErrorMessage ="RECEIPT NOT AVAILABLE."//Stores the actual error message
  var sActualErrorMessage;//Stores the expected error message
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
      objTestData = {sTicketNumber : Utility.getRandomValue("NUMERIC",6)};//Test Data for Ticket Number
  
     //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Set ticket number in Ticket# field .
    //-------------------------------------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.InputTicketNumberAndSubmitWithErrors(objTestData.sTicketNumber);
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2:Entered an invalid ticket number"); 
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage)
    sPassMessage    = "Test Passed. Expected error message is displayed for invalid ticket number";
    sFailMessage    = "Test Failed. Unexpected error is displayed  ";
    
    TestLog.Message("Error Message Displayed: "+sActualErrorMessage); 
    
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
  objReprintReceiptsTicketNumberForm = null;
}

function TC_RCPT_TKT_005() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_005: Validate Sort All Receipts in Grid By Tag/Desc Column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objReprintReceiptsOtherIncomesMonthliesForm; //Stores the instance of ReprintReceiptsOtherIncomesMonthliesForm
    
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click All Receipts Button 
    //---------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.SelectAllReceipts();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Clicked All Receipts Button"); 
    
    //Step-4: Click Tag/Desc Column Header to sort the Grid 
    //-----------------------------------------------------
    objReprintReceiptsOtherIncomesMonthliesForm = ReprintReceiptsOtherIncomesMonthliesForm.New();
        
    // TestCase Result : To verify whether the Click Tag/Desc Column Header to sort the Grid is done
    bTestCaseResult = (objReprintReceiptsOtherIncomesMonthliesForm.SortReprintReciptsGridByColumn("TagDesc"));
    sPassMessage    = "Test Passed. Sorted All Receipts in Grid By Tag/Desc Column";
    sFailMessage    = "Test Failed. Not Sorted Grid By Tag/Desc Column";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objReprintReceiptsOtherIncomesMonthliesForm = null;
}

function TC_RCPT_TKT_006() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_006: Validate Sort All Receipts in Grid By Date Column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objReprintReceiptsOtherIncomesMonthliesForm; //Stores the instance of ReprintReceiptsOtherIncomesMonthliesForm
    
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click All Receipts Button 
    //---------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.SelectAllReceipts();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Clicked All Receipts Button"); 
    
    //Step-4: Click Date Column Header to sort the Grid 
    //-----------------------------------------------------
    //Initialize object of ReprintReceiptsOtherIncomesMonthliesForm
    objReprintReceiptsOtherIncomesMonthliesForm = ReprintReceiptsOtherIncomesMonthliesForm.New();
        
    // TestCase Result : To verify whether the Click Date Column Header to sort the Grid is done
    bTestCaseResult = (objReprintReceiptsOtherIncomesMonthliesForm.SortReprintReciptsGridByColumn("Date"));
    sPassMessage    = "Test Passed. Sorted All Receipts in Grid By Date Column";
    sFailMessage    = "Test Failed. Not Sorted Grid By Date Column";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objReprintReceiptsOtherIncomesMonthliesForm = null;
}

function TC_RCPT_TKT_007() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_007: Validate Sort All Receipts in Grid By Amount Column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objReprintReceiptsOtherIncomesMonthliesForm; //Stores the instance of ReprintReceiptsOtherIncomesMonthliesForm
    
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click All Receipts Button 
    //---------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.SelectAllReceipts();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Clicked All Receipts Button"); 
    
    //Step-4: Click Amount Column Header to sort the Grid 
    //-----------------------------------------------------
    //Initialize object of ReprintReceiptsOtherIncomesMonthliesForm
    objReprintReceiptsOtherIncomesMonthliesForm = ReprintReceiptsOtherIncomesMonthliesForm.New();
        
    // TestCase Result : To verify whether the Click Amount Column Header to sort the Grid is done
    bTestCaseResult = (objReprintReceiptsOtherIncomesMonthliesForm.SortReprintReciptsGridByColumn("Amount"));
    sPassMessage    = "Test Passed. Sorted All Receipts in Grid By Amount Column";
    sFailMessage    = "Test Failed. Not Sorted Grid By Amount Column";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objReprintReceiptsOtherIncomesMonthliesForm = null;
}

function TC_RCPT_TKT_008() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_008: Validate Sort All Receipts in Grid By Type Column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objReprintReceiptsOtherIncomesMonthliesForm; //Stores the instance of ReprintReceiptsOtherIncomesMonthliesForm
    
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click All Receipts Button 
    //---------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.SelectAllReceipts();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Clicked All Receipts Button"); 
    
    //Step-4: Click Type Column Header to sort the Grid 
    //-----------------------------------------------------
    //Initialize object of ReprintReceiptsOtherIncomesMonthliesForm
    objReprintReceiptsOtherIncomesMonthliesForm = ReprintReceiptsOtherIncomesMonthliesForm.New();
        
    // TestCase Result : To verify whether the Click Type Column Header to sort the Grid is done
    bTestCaseResult = (objReprintReceiptsOtherIncomesMonthliesForm.SortReprintReciptsGridByColumn("Type"));
    sPassMessage    = "Test Passed. Sorted All Receipts in Grid By Type Column";
    sFailMessage    = "Test Failed. Not Sorted Grid By Type Column";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objReprintReceiptsOtherIncomesMonthliesForm = null;
}

function TC_RCPT_TKT_009() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_009: Validate Generate Reprint Receipt - By clicking on any random row in the Grid
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objReprintReceiptsOtherIncomesMonthliesForm; //Stores the instance of ReprintReceiptsOtherIncomesMonthliesForm
    
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click All Receipts Button 
    //---------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.SelectAllReceipts();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Clicked All Receipts Button"); 
    
    //Step-4: Click any random row in the grid to Reprint Receipt
    //-----------------------------------------------------------
    //Initialize object of ReprintReceiptsOtherIncomesMonthliesForm
    objReprintReceiptsOtherIncomesMonthliesForm = ReprintReceiptsOtherIncomesMonthliesForm.New();
    
    objReprintReceiptsOtherIncomesMonthliesForm.PrintAnyReciptInGrid();
    if (objReprintReceiptsOtherIncomesMonthliesForm.lastError.name !== undefined) 
      throw objReprintReceiptsOtherIncomesMonthliesForm.lastError;
      
    TestLog.Message("Step-3: Clicked a random row in the grid to Reprint Receipt"); 
    
    //Initialize object of H6000IIPrinterForm 
    objH6000IIPrinterForm = H6000IIPrinterForm.New();
      
    TestLog.Message("Step-4: Verified "+objH6000IIPrinterForm.windowTitle+" Window");
    
    // TestCase Result : To verify whether the Print receipt is being printed
    bTestCaseResult = objH6000IIPrinterForm.Exists();
    sPassMessage    = "Test Passed. Generated Reprint Receipt for a random row in the Grid";
    sFailMessage    = "Test Failed. Reprint Receipt was not performed";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objReprintReceiptsOtherIncomesMonthliesForm = null;
}

function TC_RCPT_TKT_010() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_010: Validate navigating through the rows by Cursor Panel in the screen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  var objReprintReceiptsOtherIncomesMonthliesForm; //Stores the instance of ReprintReceiptsOtherIncomesMonthliesForm
    
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
  
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Click All Receipts Button 
    //---------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.SelectAllReceipts();
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2: Clicked All Receipts Button"); 
    
    //Step-4: Click any random row in the grid to Reprint Receipt
    //-----------------------------------------------------------
    //Initialize object of ReprintReceiptsOtherIncomesMonthliesForm
    objReprintReceiptsOtherIncomesMonthliesForm = ReprintReceiptsOtherIncomesMonthliesForm.New();
    
    aRowIndex = objReprintReceiptsOtherIncomesMonthliesForm.NavigateByCursors();
    if (objReprintReceiptsOtherIncomesMonthliesForm.lastError.name !== undefined) 
      throw objReprintReceiptsOtherIncomesMonthliesForm.lastError;
    if(aRowIndex[0] > 1) 
      TestLog.Message("Step-3: Navigated through the rows: " +(aRowIndex[1]+1)+ ", " +(aRowIndex[2]+1)+ ", " +(aRowIndex[3]+1)+ ", " +(aRowIndex[4]+1)); 
    
    // TestCase Result : To verify whether Navigation through Cursor is available
    bTestCaseResult = (aRowIndex[1] != 0);
    sPassMessage    = "Test Passed. Navigated through the rows by Cursor Panel";
    sFailMessage    = "Test Failed. Unexpected behaviour while doing navigation via cursor panel ";
    
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
  objReprintReceiptsTicketNumberForm = null;
  objReprintReceiptsOtherIncomesMonthliesForm = null;
}

function TC_RCPT_TKT_011() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_RCPT_TKT_011 :Verify an error message is displayed when empty ticket number is given and Enter is pressed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  
  var sExpectedErrorMessage ="RECEIPT NOT AVAILABLE."//Stores the actual error message
  var sActualErrorMessage;//Stores the expected error message
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
      objTestData = {sTicketNumber : " "};//Test Data for Ticket Number
  
     //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Set empty ticket number in Ticket# field .
    //-------------------------------------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.InputTicketNumberAndSubmitWithErrors(objTestData.sTicketNumber);
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2:Entered an empty ticket number"); 
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage)
    sPassMessage    = "Test Passed. Expected error message is displayed for empty ticket number via Enter";
    sFailMessage    = "Test Failed. Unexpected/No error is displayed for empty ticket number via Enter";
    
    TestLog.Message("Error Message Displayed: "+sActualErrorMessage); 
    
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
  objReprintReceiptsTicketNumberForm = null;
}


function TC_RCPT_TKT_012() {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_RCPT_TKT_012 :Verify an error message is displayed when empty ticket number is given and 'Print Receipt' is pressed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  
  var sExpectedErrorMessage ="RECEIPT NOT AVAILABLE."//Stores the actual error message
  var sActualErrorMessage;//Stores the expected error message
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
      objTestData = {sTicketNumber : " "};//Test Data for Ticket Number
  
     //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Set empty ticket number in Ticket# field .
    //-------------------------------------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.PrintByPrintReceipt(objTestData.sTicketNumber);
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2:Entered an empty ticket number"); 
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage)
    sPassMessage    = "Test Passed. Expected error message is displayed for empty ticket number via Print Receipt";
    sFailMessage    = "Test Failed. Unexpected/No error message is displayed for empty ticket number via Print Receipt";
    
    TestLog.Message("Error Message Displayed: "+sActualErrorMessage); 
    
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
  objReprintReceiptsTicketNumberForm = null;
}


function TC_RCPT_TKT_013() {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RCPT_TKT_013 :Verify an error message is displayed when a valid ticket number of a non daily customer is given
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objReprintReceiptsTicketNumberForm; //Stores the instance of ReprintReceiptsTicketNumber Form
  
  var sExpectedErrorMessage ="RECEIPT NOT AVAILABLE."//Stores the actual error message
  var sActualErrorMessage;//Stores the expected error message
  
  var bTestCaseResult;//Boolean variable to store the TestCase result
  
  try {
      objTestData = {sTicketNumber : SQLQueries.getTicketNumber("Monthly") };//Test Data for Ticket Number
  
     //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
      
    //Step-2: Navigate into Ticket Number screen by clicking Receipts button
    //------------------------------------------------------------------------
    objMainDialog.NavigateToReceiptsScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Receipts button.");
      
    //Initialize object of ReprintReceiptsTicketNumberForm
    objReprintReceiptsTicketNumberForm = ReprintReceiptsTicketNumberForm.New();
      
    //Step-3: Set empty ticket number in Ticket# field .
    //-------------------------------------------------------------
    sActualErrorMessage = objReprintReceiptsTicketNumberForm.PrintByPrintReceipt(objTestData.sTicketNumber);
    if (objReprintReceiptsTicketNumberForm.lastError.name !== undefined) throw objReprintReceiptsTicketNumberForm.lastError;
      
    TestLog.Message("Step-2:Entered an empty ticket number"); 
    
    // TestCase Result : To verify whether the expected error message is displayed
    bTestCaseResult = (sActualErrorMessage === sExpectedErrorMessage)
    sPassMessage    = "Test Passed. Expected error message is displayed for a valid ticket number of a non daily customer";
    sFailMessage    = "Test Failed. Unexpected/No error message is displayed for a valid ticket number of a non daily customer";
    
    TestLog.Message("Error Message Displayed: "+sActualErrorMessage); 
    
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
  objReprintReceiptsTicketNumberForm = null;
}
