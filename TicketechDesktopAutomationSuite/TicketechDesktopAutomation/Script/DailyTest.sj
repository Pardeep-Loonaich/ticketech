//USEUNIT Utility
//USEUNIT MainDialog
//USEUNIT EmployeeInfoForm
//USEUNIT VehicleInfoForm
//USEUNIT CheckInVehicleDamageForm
//USEUNIT PrinterStatusForm
//USEUNIT NavigationPanelForm
//USEUNIT ReservationInfoForm
//USEUNIT DBUtility
//USEUNIT UserInfoForm
//USEUNIT TechnicianMenuForm
//USEUNIT CheckInTicketNumberForm
//USEUNIT ManualDateInformationDateForm


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

function TC_DAILY_CHKN_006() {// Employee not able to do New Reservations,
  // so commenting the TC as discussed with Marco on call- Pardeep 10/2/17 
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_006 : CheckIn By Reservation Barcode successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objReservationInfoForm;//variable to store ReservationInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm       
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_006";
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
    
//  while (!DataPool.EOF) {
//    
//    try {
//
//      TestDataIdx++;       
//      TestLog.AddTestDataInfo(TestDataIdx, DataPool.Columns, DataPool.Item); // Printing given testdata info to Log
//      
//      objTestData = {
//                      BarCode : DataPool.Item("BarCode")
//                      }; //TestData object for Daily module
//                                           
//                            
//      //Step-1: Launching the POS application and Initialize the home screen
//      //--------------------------------------------------------------------
//      Utility.launchApp();
//      // create object of main dialog unit
//      objMainDialog = MainDialog.New();          
//      
//      TestLog.Message("Step-1:clicking on Daily Button..");
//      objMainDialog.clickOnDailyButton();
//      
//      // create object of Vehicle info form unit
//      objVehicleInfoForm=VehicleInfoForm.New();
//            
//      // Click Reservation button for daily checkin.       
//      TestLog.Message("Step-2: Click Reservation button");
//      objVehicleInfoForm.clickOnReservationButton();
//      
//      // Enter reservation barcode on getiput screen
//      TestLog.Message("Step-3: Enter reservation barcode on getiput screen");
//      objReservationInfoForm = ReservationInfoForm.New();
//      objReservationInfoForm.EnterBarCode(BarCode);
//      
//      //Click No for vehicle damage confirmation.
//      TestLog.Message("Step-4: Click No button to confirm vehicle not damage");
//      objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
//      objCheckInVehicleDamageForm.ConfirmNo();
//      
//      //Click on Cancel button on Printer Status window 
//      TestLog.Message("Step-5: Click Cancel button on Printer Status Window");
//      objPrinterStatusForm = PrinterStatusForm.New();
//      objPrinterStatusForm.ClickCancel();
//      
//      // Verify user navigated back to Main screen
//      Utility.assertResult(objMainDialog.Exists(),"vehicle check in Successfully","somthing went wrong with over size vehicle check in. Its Failed !!");      
//     
//    } //End try
//        
//    catch(exception) {
//      TestLog.Error(exception.description, Utility.formattedException(exception));
//    } //End catch
//    
//    finally {
//      //Close the POS Application
//      Utility.closePOSProcess();  
//      DataPool.NextItem(); //Moving to next given testdata
//      Log.PopLogFolder();
//    } //End finally
//    
//  } // while EOF
  
  
  //Disposing objects 
  home = null;
  DataPool.Close(); 
  
}//TC_DAILY_CHKN_006

function TC_DAILY_CHKN_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_007 : CheckIn By Invalid Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objReservationInfoForm;//variable to store ReservationInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm   
       var expectedErrorMessage = "RESERVATION CANNOT BE VALIDATED."; //Stores the expected error message    
       var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_007";
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
                      Code : DataPool.Item("BarCode")
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
            
      // Click Reservation button for daily checkin.       
      TestLog.Message("Step-2: Click Reservation button");
      objVehicleInfoForm.clickOnReservationButton();
      
      // Enter invalid reservation barcode on getiput screen
      TestLog.Message("Step-3: Enter reservation barcode on getiput screen");
      objReservationInfoForm = ReservationInfoForm.New();
      actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.Code);
      
      
      // Verify employee can see 'RESERVATION CANNOT BE VALIDATED.' error message.
      Utility.assertResult(actualErrorMessage === expectedErrorMessage, "User can see error message for invalid reservation","Expected Error message not exist on screen");      
     
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
  
}//TC_DAILY_CHKN_007

function TC_DAILY_CHKN_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_008 : CheckIn By Empty Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objReservationInfoForm;//variable to store ReservationInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm   
       var expectedErrorMessage = "RESERVATION CANNOT BE VALIDATED."; //Stores the expected error message    
       var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_008";
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
                      Code : DataPool.Item("BarCode")
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
            
      // Click Reservation button for daily checkin.       
      TestLog.Message("Step-2: Click Reservation button");
      objVehicleInfoForm.clickOnReservationButton();
      
      // Leave blank reservation barcode on getiput screen
      TestLog.Message("Step-3: Enter reservation barcode on getiput screen");
      objReservationInfoForm = ReservationInfoForm.New();
      actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.Code);
      
      
      // Verify employee can see 'RESERVATION CANNOT BE VALIDATED.' error message.
      Utility.assertResult(actualErrorMessage === expectedErrorMessage, "User can see error message for blank reservation barcode","Expected Error message not exist on screen");      
     
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
  
}//TC_DAILY_CHKN_008


function TC_DAILY_CHKN_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_009 : CheckIn By Already Used Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objReservationInfoForm;//variable to store ReservationInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm   
       var expectedErrorMessage = "RESERVATION ALREADY USED."; //Stores the expected error message    
       var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_009";
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
                      Code : DataPool.Item("BarCode")
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
            
      // Click Reservation button for daily checkin.       
      TestLog.Message("Step-2: Click Reservation button");
      objVehicleInfoForm.clickOnReservationButton();
      
      // Leave blank reservation barcode on getiput screen
      TestLog.Message("Step-3: Enter reservation barcode on getiput screen");
      objReservationInfoForm = ReservationInfoForm.New();
      actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.Code);
      
      
      // Verify employee can see 'RESERVATION ALREADY USED.' error message.
      Utility.assertResult(actualErrorMessage === expectedErrorMessage, "User can see error message for used reservation barcode","Expected Error message not exist on screen");      
     
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
  
}//TC_DAILY_CHKN_009

function TC_DAILY_CHKN_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_010 : Cancel Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objReservationInfoForm;//variable to store ReservationInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm   
       var expectedErrorMessage = "RESERVATION ALREADY USED."; //Stores the expected error message    
       var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_010";
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
                      Code : DataPool.Item("BarCode")
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
            
      // Click Reservation button for daily checkin.       
      TestLog.Message("Step-2: Click Reservation button");
      objVehicleInfoForm.clickOnReservationButton();
      
      // Enter reservation barcode on getiput screen, don't click enter button
      TestLog.Message("Step-3: Enter reservation barcode on getiput screen");
      objReservationInfoForm = ReservationInfoForm.New();
      actualErrorMessage = objReservationInfoForm.FillBarCode(objTestData.Code);
      
     //Click Cancel button to cancel vehicle reservation checkin
      TestLog.Message("Step-4: Click Cancel button to cancel vehicle reservation checkin");
      objNavigationPanelForm = NavigationPanelForm.New();
      objNavigationPanelForm.ClickCancel();
      
      // Verify user navigated back to Main screen
      Utility.assertResult(objMainDialog.Exists(),"vehicle CheckIn Cancel Successfully","Somthing went wrong with reservation cancellation.");      
     
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
  
}//TC_DAILY_CHKN_010


function TC_DAILY_CHKN_011() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_011 : Create manual Entry successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm           
       var objTechnicianMenuForm; //variable to store TechnicianMenuForm
       var objCheckInTicketNumberForm; //variable to store CheckInTicketNumberForm
       var objManualDateInformationDateForm; //variable to store ManualDateInformationDateForm
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_011";
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
      
      objTestData = { UserName: DataPool.Item("UserName"),
                      Password: DataPool.Item("Password"),
                      VehicleColor: DataPool.Item("vColor"),
                      VehicleMake: DataPool.Item("vMake"),
                      TicketNumber: ("9"+Utility.getRandomValue("NUMERIC", 5)),
                      VehiclePlateNumber: Utility.getRandomValue("NUMERIC", 7)                     
                      }; //TestData object for Daily module                                         
    var CheckInDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"); 
                                                  
      //Step-1: Launching the POS application and Initialize the home screen
      TestLog.Message("Step-1: Launching the POS application and Initialize the home screen");
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      //Step-2: Navigate into user info screen and submit username and password
      TestLog.Message("Step-2: Clicked Log In button.");
      objMainDialog.NavigateToUserInfoScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
      //Initialize object of UserInfoForm       
      TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.UserName); 
      //Set data in Username and Password field and click Enter button from Navigation panel
      objUserInfo = UserInfoForm.New();
      objUserInfo.InputAndSubmitForm(objTestData.UserName,objTestData.Password);
      if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
           
      TestLog.Message("Step-4:clicking on Technician Menu Button..");
      objMainDialog = MainDialog.New();
      objMainDialog.NavigateToTechnicianMenu();
      
      // Enable manual ticket entry
      TestLog.Message("Step-5:Enable manual ticket entry");
      objTechnicianMenuForm = TechnicianMenuForm.New();
      objTechnicianMenuForm.EnableManualTicketEntry();
      
      // Click Daily button
      TestLog.Message("Step-6:clicking on Daily Button..");
      objMainDialog = MainDialog.New();
      Delay(1000);
      objMainDialog.clickOnDailyButton();
      
      // Enter manual ticket number
      TestLog.Message("Step-7:Enter manual ticket number");
      objCheckInTicketNumberForm = CheckInTicketNumberForm.New();
      objCheckInTicketNumberForm.SetTicketNumber(objTestData.TicketNumber);
      
      // Enter manual checkin Date and Time
      TestLog.Message("Step-8:Enter manual checkin Date and Time");
      objManualDateInformationDateForm = ManualDateInformationDateForm.New();
      objManualDateInformationDateForm.EnterCheckInDate(CheckInDate);
      objManualDateInformationDateForm.EnterCheckInTime(null);
                 
      // Enter vehicle information for daily checkin.       
      TestLog.Message("Step-9: enter vehicle Plate number, select color and Make.");
      objVehicleInfoForm=VehicleInfoForm.New();
      objVehicleInfoForm.provideVehicleDetails(objTestData.VehiclePlateNumber,objTestData.VehicleColor,objTestData.VehicleMake);
      
      //Click No for vehicle damage confirmation.
      TestLog.Message("Step-10: Click No button to confirm vehicle not damage");
      objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      objCheckInVehicleDamageForm.ConfirmNo();                  
     
      // Verify ticket number exists on transaction screen 
      Utility.assertResult(objMainDialog.VerifyTicketNumber(objTestData.TicketNumber),"vehicle CheckIn Successfully","Somthing went wrong with vehicle checkin.");      
     
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
  
}//TC_DAILY_CHKN_011


function TC_DAILY_CHKN_012() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_012 : Create manual Entry with Invalid Ticket number
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
       var objMainDialog;// variable to store  main dialog unit object
       var objVehicleInfoForm;//variable to store VehicleInfoForm
       var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
       var objPrinterStatusForm;//variable to store PrinterStatusForm
       var objNavigationPanelForm;//Variable to store NavigationPanelForm           
       var objTechnicianMenuForm; //variable to store TechnicianMenuForm
       var objCheckInTicketNumberForm; //variable to store CheckInTicketNumberForm
       var objManualDateInformationDateForm; //variable to store ManualDateInformationDateForm
       var expectedErrorMessage; //Stores the expected error message    
       var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
  
    //Connecting to testdata file & reading the given data
    TestDataIdx = 0;
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "Daily.xls";
    DataPool.SheetName = "TC_DAILY_CHKN_012";
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
      
      objTestData = { UserName: DataPool.Item("UserName"),
                      Password: DataPool.Item("Password"),                      
                      TicketNumber: ("0"+Utility.getRandomValue("NUMERIC", 5))                     
                      }; //TestData object for Daily module                                          
                                                  
      //Step-1: Launching the POS application and Initialize the home screen
      TestLog.Message("Step-1: Launching the POS application and Initialize the home screen");
      Utility.launchApp();
      // create object of main dialog unit
      objMainDialog = MainDialog.New();          
      
      //Step-2: Navigate into user info screen and submit username and password
      TestLog.Message("Step-2: Clicked Log In button.");
      objMainDialog.NavigateToUserInfoScreen();
      if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;      
      
      //Initialize object of UserInfoForm       
      TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.UserName); 
      //Set data in Username and Password field and click Enter button from Navigation panel
      objUserInfo = UserInfoForm.New();
      objUserInfo.InputAndSubmitForm(objTestData.UserName,objTestData.Password);
      if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
           
      TestLog.Message("Step-4:clicking on Technician Menu Button..");
      objMainDialog = MainDialog.New();
      objMainDialog.NavigateToTechnicianMenu();
      
      // Enable manual ticket entry
      TestLog.Message("Step-5:Enable manual ticket entry");
      objTechnicianMenuForm = TechnicianMenuForm.New();
      objTechnicianMenuForm.EnableManualTicketEntry();
      
      // Click Daily button
      TestLog.Message("Step-6:clicking on Daily Button..");
      objMainDialog = MainDialog.New();
      Delay(1000);
      objMainDialog.clickOnDailyButton();
      
      // Manualy enter invalid ticket number
      TestLog.Message("Step-7:Enter manual ticket number");
      objCheckInTicketNumberForm = CheckInTicketNumberForm.New();
      objCheckInTicketNumberForm.SetTicketNumber(objTestData.TicketNumber);
      
      objMainDialog = MainDialog.New();  
      actualErrorMessage = objMainDialog.GetFormInfo().Message;         
      expectedErrorMessage = "TICKET NUMBER "+objTestData.TicketNumber+" NOT FOUND.";
      
      // Verify error message exists on menu screen 
      Utility.assertResult(actualErrorMessage === expectedErrorMessage,"Error message exists for invalid ticket number","No error message exists for invlaid ticket number.");      
     
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
  
}//TC_DAILY_CHKN_012