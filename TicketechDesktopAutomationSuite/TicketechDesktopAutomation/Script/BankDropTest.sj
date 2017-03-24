//USEUNIT BankDropInfoForm
//USEUNIT ConfirmActionForm
//USEUNIT DBUtility
//USEUNIT MainDialog
//USEUNIT SQLQueries
//USEUNIT UserInfoForm
//USEUNIT NavigationPanelForm
//USEUNIT Utility


function TC_BANKDROP_EMP_001() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_001 :Verify the bag number is added with amount when valid bag number is given. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form
  var objConfirmActionForm; //Stores the instance of ConfirmAction Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : Utility.getRandomValue("NUMERIC",10),
                      iAmount    : Utility.getRandomValue("NUMERIC",2)  
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    objBankDropInfoForm.InputBankDropDetails(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered bag number and amount");

    //Step-4: Navigate to confirm Action screen and click Yes button
    //-------------------------------------------------------------
    objConfirmActionForm = ConfirmActionForm.New();
    TestLog.Message("Step-5: Navigated to ConfirmAction Form");
     
    //Click Yes button from YesNoConfirmAction panel
    objConfirmActionForm.ConfirmYes();
    if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError;
    TestLog.Message("Step-6:Clicked Yes Button in Confirm Action screen");
    
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();    
    
    //Step-5: Navigate into BankDrop screen and check the added Bag is in the Grid
    //----------------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-7:Clicked Bank Drop button"); 
    
    //Initialize object of BankDropBagNumberForm 
    objBankDropInfoForm = BankDropInfoForm.New();
    
    // TestCase Result : To verify the Bag number is added to Bank Drop History
    bCheck1 = objBankDropInfoForm.CheckLastAddedBagInGridFirstRow(objTestData.sBagNumber);
    bCheck2 = SQLQueries.getBagNumberDetails(objTestData.sBagNumber).bResult;
    bTestCaseResult = bCheck1 && bCheck2;
    sPassMessage    = "Test Passed. The given bag number and amount is added to the Bag Drop History";
    sFailMessage    = "Test Failed. The information is not added to the Bag Drop History";
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
  objConfirmActionForm = null;
}

function TC_BANKDROP_EMP_002() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_002 :Verify the error message is displayed when the same  bag number is given as input. ( Dupliacte bag number)   
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form
  var objConfirmActionForm; //Stores the instance of ConfirmAction Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
  
  var eBankDropBagDetails = SQLQueries.getBagNumberDetails();
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : eBankDropBagDetails.sBagNo,
                      iAmount    : Utility.getRandomValue("NUMERIC",2)  
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit invalid bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    sErrorMessage = objBankDropInfoForm.InputBankDropDetailsWithErrors(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered invalid bag number and amount");
    
    // TestCase Result : To verify the Bag number is not added to Bank Drop History
    bTestCaseResult = sErrorMessage === "BAG NUMBER "+objTestData.sBagNumber+" WAS FOUND MORE THAN ONCE.";
    sPassMessage    = "Test Passed. Expected Error Message displayed for Duplicate Bag Number";
    sFailMessage    = "Test Failed. Unexpected/No Error Message displayed for Duplicate Bag Number";
    
    TestLog.Message("Error Message Diaplayed: "+sErrorMessage);
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
  objConfirmActionForm = null;
}


function TC_BANKDROP_EMP_003() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_003 :Verify the error message is displayed when bag number is given in alpha numeric or characters.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form
  var objConfirmActionForm; //Stores the instance of ConfirmAction Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : Utility.getRandomValue("ALPHANUMERIC",10),
                      iAmount    : Utility.getRandomValue("NUMERIC",2)  
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit invalid bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    sErrorMessage = objBankDropInfoForm.InputBankDropDetailsWithErrors(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered invalid bag number and amount");
    
    // TestCase Result : To verify the Bag number is not added to Bank Drop History
    bTestCaseResult = sErrorMessage === "BAG NUMBER MUST BE NUMERIC.";
    sPassMessage    = "Test Passed. Expected Error Message displayed for non numeric Bag Number";
    sFailMessage    = "Test Failed. Unexpected/No Error Message displayed for non numeric Bag Number";
    
    TestLog.Message("Error Message Diaplayed: "+sErrorMessage);
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
  objConfirmActionForm = null;
}


function TC_BANKDROP_EMP_004() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_004 :Verify an error message is displayed when empty bag is given as input. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser"); 
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : "" 
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit invalid bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    sErrorMessage = objBankDropInfoForm.InputBankDropDetailsWithErrors(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered empty bag number");
    
    // TestCase Result : To verify the Bag number is not added to Bank Drop History
    bTestCaseResult = sErrorMessage === "BAG NUMBER NOT ENTERED.";
    sPassMessage    = "Test Passed. Expected Error Message displayed when empty Bag Number is given";
    sFailMessage    = "Test Failed. Unexpected/No Error Message displayed for empty/blank Bag Number";
    
    TestLog.Message("Error Message Diaplayed: "+sErrorMessage);
    
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
  objMainDialog = null;
  objUserInfoForm = null;
}

function TC_BANKDROP_EMP_005() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_005 :Verify the error message is displayed when the valid bag number and empty amount is given as input   
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
  
  var eBankDropBagDetails = SQLQueries.getBagNumberDetails();
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : eBankDropBagDetails.sBagNo,
                      iAmount    : "" 
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit invalid bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    sErrorMessage = objBankDropInfoForm.InputBankDropDetailsWithErrors(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered valid bag number and empty/blank amount");
    
    // TestCase Result : To verify the Bag number is not added to Bank Drop History
    bTestCaseResult = sErrorMessage === "AMOUNT ENTERED NOT VALID.";
    sPassMessage    = "Test Passed. Expected Error Message displayed when empty/blank amount is given.";
    sFailMessage    = "Test Failed. Unexpected/No Error Message displayed for when amount field is left empty.";
    
    TestLog.Message("Error Message Diaplayed: "+sErrorMessage);
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
}

function TC_BANKDROP_EMP_006() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_BANKDROP_EMP_006 : Verify bank drop module by giving the bag number is greater than 10 digits  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of UserInfo Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form
  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
   
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : Utility.getRandomValue("NUMERIC",12)  //random 12 didgit bag number
                    };
  
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit invalid bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    sBagNumberAllowedInField = objBankDropInfoForm.InputBankDropDetails(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and tried to enter Bag# "+objTestData.sBagNumber);   
    
    // TestCase Result : To verify the Bag number is not added to Bank Drop History
    bTestCaseResult = (objTestData.sBagNumber != sBagNumberAllowedInField && sBagNumberAllowedInField.length === 10) ;
    sPassMessage    = "Test Passed. Only 10 digit was allowed to enter in Bag# field";
    sFailMessage    = "Test Failed. Allowed to enter Bag# more than 10 digit";
    
    TestLog.Message("Entered Bag# "+sBagNumberAllowedInField+ "\; Max digit allowed in bag# field: "+sBagNumberAllowedInField.length);
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
}

function TC_BANKDROP_EMP_007() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_007 :Verify the bag number and amount is not added to the Bank Drop History 'NO' button is clicked. 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form
  var objConfirmActionForm; //Stores the instance of ConfirmAction Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : Utility.getRandomValue("NUMERIC",10),
                      iAmount    : Utility.getRandomValue("NUMERIC",2)  
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    objBankDropInfoForm.InputBankDropDetails(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered bag number and amount");

    //Step-4: Navigate to confirm Action screen and click No button
    //-------------------------------------------------------------
    objConfirmActionForm = ConfirmActionForm.New();
    TestLog.Message("Step-5: Navigated to ConfirmAction Form");
     
    //Click No button from YesNoConfirmAction panel
    objConfirmActionForm.ConfirmNo();
    if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError;
    TestLog.Message("Step-6:Clicked No Button in Confirm Action screen");
    
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();    
    
    //Step-5: Navigate into BankDrop screen and check the added Bag is in the Grid
    //----------------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-7:Clicked Bank Drop button"); 
    
    //Initialize object of BankDropBagNumberForm 
    objBankDropInfoForm = BankDropInfoForm.New();
    
    // TestCase Result : To verify the Bag number is not added to Bank Drop History
    bTestCaseResult = !(objBankDropInfoForm.CheckLastAddedBagInGridFirstRow(objTestData.sBagNumber));
    sPassMessage    = "Test Passed. The given bag number and amount is not added to the Bag Drop History";
    sFailMessage    = "Test Failed. Unexpected Behaviour during Bank drop";
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
  objConfirmActionForm = null;
}

function TC_BANKDROP_EMP_008() {

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   TC_BANKDROP_EMP_008: Verify that the BankDrop operation is terminated and return to Home Screen if CANCEL button is clicked   
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of Employee Info Form
  var objBankDropInfoForm;//Stores the instance of BankDropBagNumber Form
  var objNavigationPanelForm; //Stores the instance of NavigationPanel Form

  
  //Getting Timekeeper user Login details
  var eBankDropUserDetail = SQLQueries.userLoginDetails("BankDropUser");
   
  //Declaring and initializing Test Data object 
  var objTestData = {
                      username   : eBankDropUserDetail.username, 
                      password   : eBankDropUserDetail.password,
                      sBagNumber : Utility.getRandomValue("NUMERIC",8),
                      iAmount    : Utility.getRandomValue("NUMERIC",2)  
                    };
  try {
    
    //Step-1: Launching the POS application and Initialize the objMainDialog screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog= MainDialog.New();
    
    //Step-2: Navigate into user info screen and submit username and password
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    objUserInfoForm = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfoForm.InputAndSubmitForm(objTestData);
    if (objUserInfoForm.lastError.name !== undefined) throw objUserInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username); 
           
    //Initializing MainDialog after user Login        
    objMainDialog = MainDialog.New();
      
    //Step-3: Navigate into BankDrop screen and submit invalid bag number and amount
    //-----------------------------------------------------------------------
    objMainDialog.NavigateToBankDropScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    TestLog.Message("Step-3:Clicked Bank Drop button"); 
      
    //Initialize object of BankDropInfoForm 
    objBankDropInfoForm = BankDropInfoForm.New(); 
    
    //Set data in Bag and Amount field
    sErrorMessage = objBankDropInfoForm.InputBankDropDetails(objTestData);
    if (objBankDropInfoForm.lastError.name !== undefined) throw objBankDropInfoForm.lastError;
      
    TestLog.Message("Step-4: Navigated to Bank Drops screen and entered valid bag number and amount");
    
    objNavigationPanelForm = NavigationPanelForm.New();
    objNavigationPanelForm.ClickCancel();
    if (objNavigationPanelForm.lastError.name !== undefined) throw objNavigationPanelForm.lastError;
    
    TestLog.Message("Step-5: Clicked Cancel button in Navigation Panel");
    
    objMainDialog = MainDialog.New();
    sTitle = objMainDialog.GetFormInfo().Title;
    
    // TestCase Result : To verify the screen returns to Main Menu(Home Screen) after clicking Cancel
    bTestCaseResult = sTitle === "MAIN MENU";
    sPassMessage    = "Test Passed. The BankDrop operation is terminated and returned to "+sTitle+" once CANCEL button is clicked";
    sFailMessage    = "Test Failed. Unexpected/ Behaviour During Cancel operation in BankDrop";
    
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
  objMainDialog = null;
  objUserInfoForm = null;
  objBankDropInfoForm = null;
  objNavigationPanelForm = null;
}