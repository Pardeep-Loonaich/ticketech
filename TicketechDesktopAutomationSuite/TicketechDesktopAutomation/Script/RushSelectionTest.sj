//USEUNIT MainDialog
//USEUNIT RushSelectionInfoForm
//USEUNIT VehicleInfoForm
//USEUNIT CheckInVehicleDamageForm
//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT PrinterStatusForm


function TC_RUSH_SLN_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_001 : Verify the fields are displayed in Daily when all the options are enabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "YES", 
                     Color : "YES",
                     Make  : "YES",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_002 : Verify the plate field alone is displayed in Daily when other options are marked No in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "YES", 
                     Color : "NO",
                     Make  : "NO",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_003 : Verify the Color field is displayed in Daily when other options are disabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "NO", 
                     Color : "YES",
                     Make  : "NO",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_004 : Verify the Make field is displayed in Daily when other options are disabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "NO", 
                     Color : "NO",
                     Make  : "YES",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_005 : Verify the Color field is disabled in Daily when other options are marked enabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "YES", 
                     Color : "NO",
                     Make  : "YES",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_006 : Verify the Make field is disabled in Daily when other options are marked enabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "YES", 
                     Color : "YES",
                     Make  : "NO",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_007 : Verify the Plate field is disabled in Daily when other options are marked enabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "NO", 
                     Color : "YES",
                     Make  : "YES",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
       
    /*Step-5: Checks the Rush mode set field and available field are same, and also perform Data entry 
      on the corresponding fields  
    ------------------------------------------------------------------------------------------------*/          
    bRushModeUICheckResult = objVehicleInfoForm.InputVehicleDetails(objTestData);
    
    TestLog.Message("Step-4: Checks the Enabled field and set the required data to do Check-In");
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
    
    //Step-6: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-7: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
    
      
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bRushModeUICheckResult && bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}

function TC_RUSH_SLN_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_RUSH_SLN_008 : Verify that all fields are disabled in Daily when all options are marked disabled in Rush Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objRushSelectionInfoForm; //Stores the instance of RushSelectionInfoPlateForm Form
  var objCheckInVehicleDamageForm;
  var objVehicleInfoForm;
  var objPrinterStatusForm;
  var sRushMode;
  
  //Declaring and initializing Test Data object 
  var objTestData = {
                     Plate : "NO", 
                     Color : "NO",
                     Make  : "NO",
                     sPlateNumber : Utility.getRandomValue("ALPHANUMERIC",7),
                     sColor       : Utility.getRandomString(["GREEN","BLACK","RED","SILVER"]),
                     sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                    };  
  try {

    //Step-1: Launching the POS application and Initialize the MainDialog
    //-------------------------------------------------------------------
    Utility.launchApp();
    objMainDialog = MainDialog.New();

    //Step-2: Navigate into RushSelection Screen
    //------------------------------------------
    objMainDialog.NavigateToRushSelectionScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-1: Clicked Rush Selection button.");
      
    //Initialize object of RushSelectionInfoForm 
    objRushSelectionInfoForm = RushSelectionInfoForm.New();

    //Step-3: Set the Rush Selection Required Fields as per Test Data
    //---------------------------------------------------------------
    objRushSelectionInfoForm.SetRushSelectionRequiredField(objTestData);
    
    if (objRushSelectionInfoForm.lastError.name !== undefined) throw objRushSelectionInfoForm.lastError;
      
    TestLog.Message("Step-2: Navigated to RushSelectionInfo Form and clicked Yes/No to the required Fields");
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-4: In Main Form click Enable Rush Mode
    //-------------------------------------------
    if(objMainDialog.EnableRushMode()){ //EnableRushMode method return true if the mode is enabled
      TestLog.Message("Step-3: The rush mode is enabled");
      sRushMode = "Enabled";
    }
      
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    //Step-5: Click on Cancel button on Printer Status window 
    //-------------------------------------------------------
    objPrinterStatusForm = PrinterStatusForm.New();
    objPrinterStatusForm.ClickCancel();
    
    TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    
    //Initialize object of MainDialog
    objMainDialog = MainDialog.New();
      
    //Step-6: Disable Rush Mode and check in Daily that the fiels are enabled for normal mode
    //---------------------------------------------------------------------------------------
    if(objMainDialog.DisableRushMode()){
      TestLog.Message(" The rush mode is Disabled");
      sRushMode = "Disabled";
    }
    
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    
    objVehicleInfoForm = VehicleInfoForm.New();
            
    // Checks the Rush mode available fields, and enters data       
    bDisableModeUICheckResult = objVehicleInfoForm.GetVisibleFieldDetails(sRushMode);
     
    eVehicleAdded = SQLQueries.getLastAddedVehicleStayDetails();
    
    //TestCase Result : verify the Daily screen changes as per rush mode Enable and Disable, and the rush details are stored in DB
    bTestCaseResult = bDisableModeUICheckResult && eVehicleAdded.bResult;
    sPassMessage    = "TestCase Passed. Check-In done with Rush Selection";
    sFailMessage    = "TestCase Failed. Unexpected error during Rush Selection";
    
    TestLog.Message("RushHourDetails: Plate - "+objTestData.Plate+", Color - "+objTestData.Color+", Make - "+objTestData.Make);
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
  objRushSelectionInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objVehicleInfoForm = null;
  objPrinterStatusForm = null;
}