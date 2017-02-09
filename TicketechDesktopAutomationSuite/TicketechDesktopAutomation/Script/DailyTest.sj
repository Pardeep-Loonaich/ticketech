//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT EmployeeInfoForm
//USEUNIT VehicleInfoForm
//USEUNIT CheckInVehicleDamageForm
//USEUNIT PrinterStatusForm
//USEUNIT NavigationPanelForm
//USEUNIT DBUtility


function TC_DAILY_CHKN_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_001 : Check In a Vehicle successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/
  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_001";
    DataPool.New(); //Creating a New Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
    
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {

      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      
      objTestData = {
                      VehicleColor : DataPool.Item("VehicleColor"),
                      VehiclePlateNumber: Utility.getRandomValue("NUMERIC", 7),                                      
                      VehicleMake: DataPool.Item("Make")
                    }; //TestData object for Daily module
                               
                                  
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      TestLog.Message("Step-1:clicking on Daily Button..");
      objMainDialog.clickOnDailyButton();
      // create object of Vehicle info form unit
      objVehicleInfoForm=VehicleInfoForm.New();
            
      // Enter vehicle information for daily checkin.       
      TestLog.Message("Step-2: enter vehicle Plate number, select color and Make.");
      objVehicleInfoForm.provideVehicleDetails(objTestData.VehiclePlateNumber,objTestData.VehicleColor,objTestData.VehicleMake);
      
      //Click No for vehicle damage confirmation.
      TestLog.Message("Step-3: Click No button to confirm vehicle not damage");
      objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      objCheckInVehicleDamageForm.ConfirmNo();
      
      //Click on Cancel button on Printer Status window 
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      // Verify user navigated back to Main screen
      Utility.assertResult(objMainDialog.Exists(),"vehicle check in Successfully","somthing wrong with vehicle check in. Its Failed !!");      
     
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  
  //Disposing objects 
  home = null;
  DataPool.Close(); 
  

}//TC_DAILY_CHKN_001



function TC_DAILY_CHKN_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_002 : Check In SuperOverSize Vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_002";
    DataPool.New(); //Creating a New Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
    
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {

      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      
      objTestData = {
                      VehicleColor : DataPool.Item("VehicleColor"),
                      VehiclePlateNumber: Utility.getRandomValue("NUMERIC", 7),                                      
                      VehicleMake: DataPool.Item("Make")
                    }; //TestData object for Daily module
                                           
                            
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      TestLog.Message("Step-1:clicking on Daily Button..");
      objMainDialog.clickOnDailyButton();
      
      // create object of Vehicle info form unit
      objVehicleInfoForm=VehicleInfoForm.New();
            
      // Enter vehicle information for daily checkin.       
      TestLog.Message("Step-2: enter vehicle Plate number, select color and Make.");
      objVehicleInfoForm.provideVehicleDetails(objTestData.VehiclePlateNumber,objTestData.VehicleColor,objTestData.VehicleMake);
      
      //Click No for vehicle damage confirmation.
      TestLog.Message("Step-3: Click No button to confirm vehicle not damage");
      objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      objCheckInVehicleDamageForm.ConfirmNo();
      
      //Click on Cancel button on Printer Status window 
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      // Verify user navigated back to Main screen
      Utility.assertResult(objMainDialog.Exists(),"super over sizevehicle check in Successfully","somthing went wrong with vehicle check in. Its Failed !!");      
     
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  
  //Disposing objects 
  home = null;
  DataPool.Close(); 
  

}//TC_DAILY_CHKN_002


function TC_DAILY_CHKN_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_003 : Check In Standard Vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_003";
    DataPool.New(); //Creating a New Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
    
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {

      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      
      objTestData = {
                      VehicleColor : DataPool.Item("VehicleColor"),
                      VehiclePlateNumber: Utility.getRandomValue("NUMERIC", 7),                                      
                      VehicleMake: DataPool.Item("Make")
                    }; //TestData object for Daily module
                                           
                            
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      TestLog.Message("Step-1:clicking on Daily Button..");
      objMainDialog.clickOnDailyButton();
      
      // create object of Vehicle info form unit
      objVehicleInfoForm=VehicleInfoForm.New();
            
      // Enter vehicle information for daily checkin.       
      TestLog.Message("Step-2: enter vehicle Plate number, select color and Make.");
      objVehicleInfoForm.provideVehicleDetails(objTestData.VehiclePlateNumber,objTestData.VehicleColor,objTestData.VehicleMake);
      
      //Click No for vehicle damage confirmation.
      TestLog.Message("Step-3: Click No button to confirm vehicle not damage");
      objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      objCheckInVehicleDamageForm.ConfirmNo();
      
      //Click on Cancel button on Printer Status window 
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      // Verify user navigated back to Main screen
      Utility.assertResult(objMainDialog.Exists(),"vehicle check in Successfully","somthing went wrong with vehicle check in. Its Failed !!");      
     
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  
  //Disposing objects 
  home = null;
  DataPool.Close(); 
  

}//TC_DAILY_CHKN_003



function TC_DAILY_CHKN_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_004 : Check In Over-Size Vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_004";
    DataPool.New(); //Creating a New Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
    
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {

      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      
      objTestData = {
                      VehicleColor : DataPool.Item("VehicleColor"),
                      VehiclePlateNumber: Utility.getRandomValue("NUMERIC", 7),                                      
                      VehicleMake: DataPool.Item("Make")
                    }; //TestData object for Daily module
                                           
                            
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      TestLog.Message("Step-1:clicking on Daily Button..");
      objMainDialog.clickOnDailyButton();
      
      // create object of Vehicle info form unit
      objVehicleInfoForm=VehicleInfoForm.New();
            
      // Enter vehicle information for daily checkin.       
      TestLog.Message("Step-2: enter vehicle Plate number, select color and Make.");
      objVehicleInfoForm.provideVehicleDetails(objTestData.VehiclePlateNumber,objTestData.VehicleColor,objTestData.VehicleMake);
      
      //Click No for vehicle damage confirmation.
      TestLog.Message("Step-3: Click No button to confirm vehicle not damage");
      objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      objCheckInVehicleDamageForm.ConfirmNo();
      
      //Click on Cancel button on Printer Status window 
      TestLog.Message("Step-4: Click Cancel button on Printer Status Window");
      objPrinterStatusForm = PrinterStatusForm.New();
      objPrinterStatusForm.ClickCancel();
      // Verify user navigated back to Main screen
      Utility.assertResult(objMainDialog.Exists(),"vehicle check in Successfully","somthing went wrong with over size vehicle check in. Its Failed !!");      
     
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  
  //Disposing objects 
  home = null;
  DataPool.Close(); 
  

}//TC_DAILY_CHKN_004




function TC_DAILY_CHKN_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_005 : Cancel Check In a vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_005";
    DataPool.New(); //Creating a New Data Connection
  
    //Verify if test data exists in the test data sheet
    if (DataPool.EOF) {
      TestLog.Warning("No TestData found.");
      DataPool.Close();
      return;
    }
    
  } //End try
  
  catch (exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
    DataPool.Close();
    return;
  } //End catch
    
  while (!DataPool.EOF) {
    
    try {

      TestDataIdx++;       
      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
      
      objTestData = {
                      VehicleColor : DataPool.Item("VehicleColor"),
                      VehiclePlateNumber: Utility.getRandomValue("NUMERIC", 7),                                      
                      VehicleMake: DataPool.Item("Make")
                    }; //TestData object for Daily module
                                           
                            
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      TestLog.Message("Step-1:clicking on Daily Button..");
      objMainDialog.clickOnDailyButton();
      
      // create object of Vehicle info form unit
      objVehicleInfoForm=VehicleInfoForm.New();
            
      // Enter vehicle information for daily checkin.       
      TestLog.Message("Step-2: enter vehicle Plate number, select color and Make.");
      objVehicleInfoForm.provideVehicleDetails(objTestData.VehiclePlateNumber,objTestData.VehicleColor,objTestData.VehicleMake);
      
      //Click Cancel button to cancel vehicle checkin
      TestLog.Message("Step-3: Click Cancel button to cancel vehicle checkin");
      objNavigationPanelForm = NavigationPanelForm.New();
      objNavigationPanelForm.ClickCancel();
      
      // Verify user navigated back to Main screen
      Utility.assertResult(objMainDialog.Exists(),"vehicle check in Successfully","somthing went wrong with over size vehicle check in. Its Failed !!");      
     
    } //End try
        
    catch(exception) {
      TestLog.Error(exception.description, Utility.formattedException(exception));
    } //End catch
    
    finally {
      //Close the POS Application
      Utility.closePOSProcess();  
      DataPool.NextItem(); //Moving to next given testdata
      Log.PopLogFolder();
    } //End finally
    
  } // while EOF
  
  
  //Disposing objects 
  home = null;
  DataPool.Close(); 
  

}//TC_DAILY_CHKN_005