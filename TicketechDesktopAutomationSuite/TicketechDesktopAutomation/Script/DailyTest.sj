//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
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
//USEUNIT ConfirmActionForm


function TC_DAILY_CHKN_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_001 : Verify CheckIn is done successfully for a daily customer vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //--------------------
  var objMainDialog; //variable to store  main dialog unit object
  var objVehicleInfoForm; //variable to store VehicleInfoForm
  var objCheckInVehicleDamageForm; //variable to store CheckInVehicleDamageForm
  var objPrinterStatusForm; //variable to store PrinterStatusForm
  
  var bDBResultPass = false; //Initilaized the DB check result as false 
  
  try {

    objTestData = {
                    sPlateNumber : Utility.getRandomValue("NUMERIC", 7),                                      
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                  }; //TestData object for Daily module
                                            
    //Launching the POS application and Initialize the MainDialog screen
    Utility.launchApp();
      
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton(); 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    //Log Message
    TestLog.Message("Step-1: Opened POS App and Clicked on Daily Button.");
      
    //create object of Vehicle info form unit
    objVehicleInfoForm = VehicleInfoForm.New();
            
    //Enter vehicle information for daily checkin      
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    //Log Message
    TestLog.Message("Step-2: Entered vehicle Plate number, select color and Make.");
      
    //Create object of CheckIn Vehicle Damage form unit
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      
    //Click No for vehicle damage confirmation
    objCheckInVehicleDamageForm.ConfirmNo();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    //Log Message
    TestLog.Message("Step-3: Clicked No button to confirm vehicle not damage");
            
    //Create object of PrinterStatus form unit
    objPrinterStatusForm = PrinterStatusForm.New();
      
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm.ClickCancel();
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
      
    //Log Message
    TestLog.Message("Step-4: Clicked Cancel button on Printer Status Window");
      
    eStayDetails = SQLQueries.getLastAddedVehicleStayDetails(objTestData.sPlateNumber);
    
    //Checks if Query yields a result
    //CheckIn vehicle will have StayDateOut as NULL; 
    //Damage if selected No, iDamageIdentification = 1  
    //Daily CheckIn StayType = 0
    if(eStayDetails.bResult && eStayDetails.sStayDateOut == null && eStayDetails.iDamageIdentification == 1 
       && eStayDetails.iStayType == 0){
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
         
    //create object of main dialog unit
    objMainDialog = MainDialog.New();      
      
    //Test Result: Verify user navigated back to Main screen and the Vehicle details/Stay details added successfully in DB
    bTestCaseResult = objMainDialog.Exists() && bDBResultPass;
    sPassMessage    = "Testcase Passed. CheckIn is done successfully for a daily customer vehicle";
    sFailMessage    = "Testcase Failed. Unexpected behaviour during daily customer vehicle CheckIn";
    
    TestLog.Message("Vehicle Details: Plate - "+eVehicleDetails.sVehiclePlate+", Color - "+eVehicleDetails.sColor +", Make - "+eVehicleDetails.sMake);
      
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objVehicleInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;

}//TC_DAILY_CHKN_001



function TC_DAILY_CHKN_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~~~~~~
  TC_DAILY_CHKN_002 : Verify CheckIn is done successfully for a SuperOverSize vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~~~~~~*/
  //Variable Declaration 
  //--------------------
  var objMainDialog; //variable to store  main dialog unit object
  var objVehicleInfoForm; //variable to store VehicleInfoForm
  var objCheckInVehicleDamageForm; //variable to store CheckInVehicleDamageForm
  var objPrinterStatusForm; //variable to store PrinterStatusForm
  
  var bDBResultPass = false; //Initilaized the DB check result as false 
  
  try {

    objTestData = {
                    sPlateNumber : Utility.getRandomValue("NUMERIC", 7),                                      
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : "SuperOversize"
                  }; //TestData object for Daily module
                                            
    //Launching the POS application and Initialize the MainDialog screen
    Utility.launchApp();
      
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton(); 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    //Log Message
    TestLog.Message("Step-1: Opened POS App and Clicked on Daily Button.");
      
    //create object of Vehicle info form unit
    objVehicleInfoForm = VehicleInfoForm.New();
            
    //Enter vehicle information for daily checkin      
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    //Log Message
    TestLog.Message("Step-2: Entered vehicle Plate number, select color and Make.");
      
    //Create object of CheckIn Vehicle Damage form unit
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      
    //Click No for vehicle damage confirmation
    objCheckInVehicleDamageForm.ConfirmNo();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    //Log Message
    TestLog.Message("Step-3: Clicked No button to confirm vehicle not damage");
            
    //Create object of PrinterStatus form unit
    objPrinterStatusForm = PrinterStatusForm.New();
      
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm.ClickCancel();
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
      
    //Log Message
    TestLog.Message("Step-4: Clicked Cancel button on Printer Status Window");
      
    eStayDetails = SQLQueries.getLastAddedVehicleStayDetails(objTestData.sPlateNumber);
    
    //Checks if Query yields a result
    //CheckIn vehicle will have StayDateOut as NULL; 
    //Damage if selected No, iDamageIdentification = 1  
    //Daily CheckIn StayType = 0
    if(eStayDetails.bResult && eStayDetails.sStayDateOut == null && eStayDetails.iDamageIdentification == 1 
       && eStayDetails.iStayType == 0){
          eVehicleDetails = SQLQueries.getVehicleDetails(eStayDetails.sVehicleGUID);
          //Checks if Query yields a result
          //Compares the color and Make given; 
          //Checks if the added vehicle size (2 for SuperOversize, 1 for OverSize, 0 for standard) 
          //Checks VehicleOverSize (true for OverSize, false for others)
          if(eVehicleDetails.bResult && eVehicleDetails.sColor == objTestData.sColor 
              && eVehicleDetails.sMake == aqString.ToUpper(objTestData.sVehicleMake) && eVehicleDetails.iVehicleSize == 2
              && eVehicleDetails.bVehicleOversized){
                  bDBResultPass = true;
          }
    }

    //create object of main dialog unit
    objMainDialog = MainDialog.New();      
      
    //Test Result: Verify user navigated back to Main screen and the Vehicle details/Stay details added successfully in DB
    bTestCaseResult = objMainDialog.Exists() && bDBResultPass;
    sPassMessage    = "Testcase Passed. CheckIn is done successfully for a daily customer's SuperOversize vehicle";
    sFailMessage    = "Testcase Failed. Unexpected behaviour during SuperOversize vehicle CheckIn";
    
    TestLog.Message("Vehicle Details: Plate - "+eVehicleDetails.sVehiclePlate+", Color - "+eVehicleDetails.sColor +", Make - "+eVehicleDetails.sMake);  
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objVehicleInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;

}//TC_DAILY_CHKN_002


function TC_DAILY_CHKN_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_003 : Verify CheckIn is done successfully for a Standard Vehicle with Damage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //--------------------
  var objMainDialog; //variable to store  main dialog unit object
  var objVehicleInfoForm; //variable to store VehicleInfoForm
  var objCheckInVehicleDamageForm; //variable to store CheckInVehicleDamageForm
  var objPrinterStatusForm; //variable to store PrinterStatusForm
  
  var bDBResultPass = false; //Initilaized the DB check result as false 
  
  try {

    objTestData = {
                    sPlateNumber : Utility.getRandomValue("ALPHANUMERIC", 7),                                      
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : "Other"
                  }; //TestData object for Daily module
                                            
    //Launching the POS application and Initialize the MainDialog screen
    Utility.launchApp();
      
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton(); 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    //Log Message
    TestLog.Message("Step-1: Opened POS App and Clicked on Daily Button.");
      
    //create object of Vehicle info form unit
    objVehicleInfoForm = VehicleInfoForm.New();
            
    //Enter vehicle information for daily checkin      
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    //Log Message
    TestLog.Message("Step-2: Entered vehicle Plate number, select color and Make.");
      
    //Create object of CheckIn Vehicle Damage form unit
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      
    //Click Yes for vehicle damage confirmation
    objCheckInVehicleDamageForm.ConfirmYes();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    //Log Message
    TestLog.Message("Step-3: Clicked Yes button to confirm vehicle damage");
            
    //Create object of PrinterStatus form unit
    objPrinterStatusForm = PrinterStatusForm.New();
      
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm.ClickCancel();
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
      
    //Log Message
    TestLog.Message("Step-4: Clicked Cancel button on Printer Status Window");
      
    eStayDetails = SQLQueries.getLastAddedVehicleStayDetails(objTestData.sPlateNumber);
    
    //Checks if Query yields a result
    //CheckIn vehicle will have StayDateOut as NULL; 
    //Damage if selected Yes, iDamageIdentification = 2  
    //Daily CheckIn StayType = 0
    if(eStayDetails.bResult && eStayDetails.sStayDateOut == null && eStayDetails.iDamageIdentification == 2 
     && eStayDetails.iStayType == 0){
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

    //create object of main dialog unit
    objMainDialog = MainDialog.New();      
      
    //Test Result: Verify user navigated back to Main screen and the Vehicle details/Stay details added successfully in DB
    bTestCaseResult = objMainDialog.Exists() && bDBResultPass;
    sPassMessage    = "Testcase Passed. CheckIn is done successfully for a daily customer's Standard vehicle";
    sFailMessage    = "Testcase Failed. Unexpected behaviour during Standard vehicle CheckIn";
    
    TestLog.Message("Vehicle Details: Plate - "+eVehicleDetails.sVehiclePlate+", Color - "+eVehicleDetails.sColor +", Make - "+eVehicleDetails.sMake);  
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objVehicleInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;

}//TC_DAILY_CHKN_003



function TC_DAILY_CHKN_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~~
  TC_DAILY_CHKN_004 : Verify CheckIn is done successfully for a Over-Size Vehicle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~~*/

  //Variable Declaration 
  //--------------------
  var objMainDialog; //variable to store  main dialog unit object
  var objVehicleInfoForm; //variable to store VehicleInfoForm
  var objCheckInVehicleDamageForm; //variable to store CheckInVehicleDamageForm
  var objPrinterStatusForm; //variable to store PrinterStatusForm
  
  var bDBResultPass = false; //Initilaized the DB check result as false 
  
  try {

    objTestData = {
                    sPlateNumber : Utility.getRandomValue("ALPHANUMERIC", 7),                                      
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : "Oversize"
                  }; //TestData object for Daily module
                                            
    //Launching the POS application and Initialize the MainDialog screen
    Utility.launchApp();
      
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton(); 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    //Log Message
    TestLog.Message("Step-1: Opened POS App and Clicked on Daily Button.");
      
    //create object of Vehicle info form unit
    objVehicleInfoForm = VehicleInfoForm.New();
            
    //Enter vehicle information for daily checkin      
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    //Log Message
    TestLog.Message("Step-2: Entered vehicle Plate number, selected color and Make.");
      
    //Create object of CheckIn Vehicle Damage form unit
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
      
    //Click Yes for vehicle damage confirmation
    objCheckInVehicleDamageForm.ConfirmYes();
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    //Log Message
    TestLog.Message("Step-3: Clicked Yes button to confirm vehicle damage");
            
    //Create object of PrinterStatus form unit
    objPrinterStatusForm = PrinterStatusForm.New();
      
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm.ClickCancel();
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
      
    //Log Message
    TestLog.Message("Step-4: Clicked Cancel button on Printer Status Window");
      
    eStayDetails = SQLQueries.getLastAddedVehicleStayDetails(objTestData.sPlateNumber);
    
    //Checks if Query yields a result
    //CheckIn vehicle will have StayDateOut as NULL; 
    //Damage if selected Yes, iDamageIdentification = 2  
    //Daily CheckIn StayType = 0
    if(eStayDetails.bResult && eStayDetails.sStayDateOut == null && eStayDetails.iDamageIdentification == 2 
       && eStayDetails.iStayType == 0){
          eVehicleDetails = SQLQueries.getVehicleDetails(eStayDetails.sVehicleGUID);
          //Checks if Query yields a result
          //Compares the color and Make given; 
          //Checks if the added vehicle size (2 for SuperOversize, 1 for OverSize, 0 for standard) 
          //Checks VehicleOverSize (true for OverSize, false for others)
          if(eVehicleDetails.bResult && eVehicleDetails.sColor == objTestData.sColor 
              && eVehicleDetails.sMake == aqString.ToUpper(objTestData.sVehicleMake) && eVehicleDetails.iVehicleSize == 1
              && eVehicleDetails.bVehicleOversized){
                  bDBResultPass = true;
          }
    }

    //create object of main dialog unit
    objMainDialog = MainDialog.New();      
      
    //Test Result: Verify user navigated back to Main screen and the Vehicle details/Stay details added successfully in DB
    bTestCaseResult = objMainDialog.Exists() && bDBResultPass;
    sPassMessage    = "Testcase Passed. CheckIn is done successfully for a daily customer's OverSize vehicle";
    sFailMessage    = "Testcase Failed. Unexpected behaviour during OverSize vehicle CheckIn";
    
    TestLog.Message("Vehicle Details: Plate - "+eVehicleDetails.sVehiclePlate+", Color - "+eVehicleDetails.sColor +", Make - "+eVehicleDetails.sMake);  
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objVehicleInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objPrinterStatusForm = null;

}//TC_DAILY_CHKN_004


function TC_DAILY_CHKN_005() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_005 : Verify clicking Cancel while doing Daily CheckIn terminates the operation 
                      and navigate back to Main Screen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //--------------------
  var objMainDialog; //variable to store  main dialog unit object
  var objVehicleInfoForm; //variable to store VehicleInfoForm
  
  var bDBResultPass = false; //Initilaized the DB check result as false 
  
  try {

    objTestData = {
                    sPlateNumber : Utility.getRandomValue("ALPHANUMERIC", 7),                                      
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                  }; //TestData object for Daily module
                                            
    //Launching the POS application and Initialize the MainDialog screen
    Utility.launchApp();
      
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton(); 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    //Log Message
    TestLog.Message("Step-1: Opened POS App and Clicked on Daily Button.");
      
    //create object of Vehicle info form unit
    objVehicleInfoForm = VehicleInfoForm.New();
            
    //Enter vehicle information for daily checkin      
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    //Log Message
    TestLog.Message("Step-2: Entered vehicle Plate number, select color and Make.");
    
    //Create Navigation Panel Form Object  
    objNavigationPanelForm = NavigationPanelForm.New();
    //Click Cancel button to cancel vehicle checkin
    objNavigationPanelForm.ClickCancel();
    
    //Log Message
    TestLog.Message("Step-3: Clicked Cancel button to cancel vehicle checkin");
    
    //create object of main dialog unit
    objMainDialog = MainDialog.New();      
      
    //Test Result: Verify user navigated back to Main screen after clicking Cancel
    bTestCaseResult = objMainDialog.Exists();
    sPassMessage    = "Testcase Passed. CheckIn is Canceled successfully";
    sFailMessage    = "Testcase Failed. Unexpected behaviour during Daily CheckIn is Cancel";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  objVehicleInfoForm = null;
      
}//TC_DAILY_CHKN_005

function TC_DAILY_CHKN_006() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_006 : CheckIn By Reservation Barcode successfully
  
  Note: Added SQL to insert a New Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog;// variable to store  main dialog unit object
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  var objReservationInfoForm;//variable to store ReservationInfoForm
  var objCheckInVehicleDamageForm;//variable to store CheckInVehicleDamageForm
  var objPrinterStatusForm;//variable to store PrinterStatusForm
  var objConfirmActionForm;//Variable to store CofirmActionForm
                 
  try {
    eReservationDetails = SQLQueries.insertAndReturnNewReservationBarcode();

    objTestData = {
                    BarCode      : eReservationDetails.sPReservationBarcode,
                    sPlateNumber : Utility.getRandomValue("ALPHANUMERIC", 7),                                      
                    sColor       : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake : Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"])
                  }; //TestData object for Daily module
                                                                    
    //Launching the POS application
    Utility.launchApp();
    
    // create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton();
    
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1:clicked on Daily Button"); 
    
    // create object of Vehicle info form unit
    objVehicleInfoForm=VehicleInfoForm.New();
      
    // Click Reservation button for daily checkin.       
    objVehicleInfoForm.clickOnReservationButton();
    
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;  
    TestLog.Message("Step-2: Clicked Reservation button");
       
    objReservationInfoForm = ReservationInfoForm.New();
    // Enter reservation barcode on getiput screen
    objReservationInfoForm.EnterBarCode(objTestData.BarCode);
    
    if (objReservationInfoForm.lastError.name !== undefined) throw objReservationInfoForm.lastError;  
    TestLog.Message("Step-3: Entered reservation barcode on Barcode screen");
    
    objConfirmActionForm = ConfirmActionForm.New();
    
    //Click No for vehicle damage confirmation.
    objConfirmActionForm.ConfirmYes();
    
    if (objConfirmActionForm.lastError.name !== undefined) throw objConfirmActionForm.lastError; 
    TestLog.Message("Step-4: Click No button to confirm vehicle not damage"); 
    
    //create object of Vehicle info form unit
    objVehicleInfoForm = VehicleInfoForm.New();
            
    //Enter vehicle information for daily checkin      
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    //Log Message
    TestLog.Message("Step-5: Entered vehicle Plate number, select color and Make.");
      
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
    
    //Click No for vehicle damage confirmation.
    objCheckInVehicleDamageForm.ConfirmNo();
    
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError; 
    TestLog.Message("Step-6: Click No button to confirm vehicle not damage");  

    objPrinterStatusForm = PrinterStatusForm.New();
    //Click on Cancel button on Printer Status window 
    objPrinterStatusForm.ClickCancel();
    
    if (objPrinterStatusForm.lastError.name !== undefined) throw objPrinterStatusForm.lastError;
    TestLog.Message("Step-7: Clicked Cancel button on Printer Status Window");
  
    sTicketNumber = SQLQueries.verifyDailyWithReservation(objTestData.BarCode);
    
    //Test Result: Verify user navigated back to Main screen after clicking Cancel
    bTestCaseResult = (sTicketNumber != null);
    sPassMessage    = "Testcase Passed. CheckIn is successful using ReservationBarcode: "+objTestData.BarCode+" and the ticketNo.: "+sTicketNumber;
    sFailMessage    = "Testcase Failed. Unexpected behaviour during Daily CheckIn through Reservation";
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);  
     
  } //End try
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally { 
    Utility.closePOSProcess();//Close the POS Application
    Log.PopLogFolder();
  } //End finally

  //Disposing objects 
  objMainDialog = null;
  objVehicleInfoForm = null;
  objCheckInVehicleDamageForm = null;
  objConfirmActionForm = null;
  objPrinterStatusForm = null;
  
}//TC_DAILY_CHKN_006


function TC_DAILY_CHKN_007() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_007 : CheckIn By Invalid Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
   
    objTestData = {Barcode : Utility.getRandomValue("ALPHANUMERIC",9) }; //TestData object for Daily module
                                                              
    //Launching the POS application
    Utility.launchApp();
    
    // create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton();
    
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1:clicked on Daily Button"); 
    
    // create object of Vehicle info form unit
    objVehicleInfoForm=VehicleInfoForm.New();
      
    // Click Reservation button for daily checkin.       
    objVehicleInfoForm.clickOnReservationButton();
    
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;  
    TestLog.Message("Step-2: Clicked Reservation button");
       
    objReservationInfoForm = ReservationInfoForm.New();
    // Enter reservation barcode on BARCODE screen
    actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.Barcode);;
    
    if (objReservationInfoForm.lastError.name !== undefined) throw objReservationInfoForm.lastError;  
    TestLog.Message("Step-3: Entered INVALID reservation barcode on Barcode screen");

    //Test Result: Verify employee can see 'RESERVATION CANNOT BE VALIDATED.' error message.
    bTestCaseResult = actualErrorMessage === expectedErrorMessage;
    sPassMessage    = "Testcase Passed. Expected Error Message displayed for invalid Reservation Barcode";
    sFailMessage    = "Testcase Failed. Unexpected/No Error message displayed for invalid Reservation Barcode";
    
    TestLog.Message("Error Message Displayed: "+actualErrorMessage);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  
}//TC_DAILY_CHKN_007

function TC_DAILY_CHKN_008() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----~~~~~~~~
  TC_DAILY_CHKN_008 : CheckIn by the Reservation Barcode not used but expired
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog;// variable to store  main dialog unit object
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  var objReservationInfoForm;//variable to store ReservationInfoForm  
  var expectedErrorMessage = "CHECKIN DATE OUTSIDE RESERVATION WINDOW."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
    eReservationDetails = SQLQueries.insertAndReturnNewReservationBarcode("expired");

    objTestData = { BarCode : eReservationDetails.sPReservationBarcode }; //TestData object for Daily module
                                                                    
    //Launching the POS application
    Utility.launchApp();
    
    // create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton();
    
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1:clicked on Daily Button"); 
    
    // create object of Vehicle info form unit
    objVehicleInfoForm=VehicleInfoForm.New();
      
    // Click Reservation button for daily checkin.       
    objVehicleInfoForm.clickOnReservationButton();
    
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;  
    TestLog.Message("Step-2: Clicked Reservation button");
       
    objReservationInfoForm = ReservationInfoForm.New();
    // Enter reservation barcode on getiput screen
    actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.BarCode);
      
    //Test Result: Verify employee can see 'CHECKIN DATE OUTSIDE RESERVATION WINDOW.' error message.
    bTestCaseResult = actualErrorMessage === expectedErrorMessage;
    sPassMessage    = "Testcase Passed. Expected Error Message displayed for EXPIRED Reservation Barcode";
    sFailMessage    = "Testcase Failed. Unexpected/No Error message displayed for EXPIRED Reservation Barcode";
    
    TestLog.Message("Error Message Displayed: "+actualErrorMessage);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
   
}//TC_DAILY_CHKN_008


function TC_DAILY_CHKN_009() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_009 : CheckIn By Already Used Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog;// variable to store  main dialog unit object
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  var objReservationInfoForm;//variable to store ReservationInfoForm
  
  var expectedErrorMessage = "RESERVATION ALREADY USED."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed       
  
  try {
      
    objTestData = { BarCode : SQLQueries.getReservationBarcode("Used")}; //TestData object for Daily module
                                           
    //Launching the POS application
    Utility.launchApp();
    
    // create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton();
    
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1:clicked on Daily Button"); 
    
    // create object of Vehicle info form unit
    objVehicleInfoForm=VehicleInfoForm.New();
      
    // Click Reservation button for daily checkin.       
    objVehicleInfoForm.clickOnReservationButton();
    
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;  
    TestLog.Message("Step-2: Clicked Reservation button");
       
    objReservationInfoForm = ReservationInfoForm.New();
    // Enter reservation barcode on getiput screen
    actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.BarCode);
      
    //Test Result: Verify employee can see 'RESERVATION ALREADY USED.' error message.
    bTestCaseResult = actualErrorMessage === expectedErrorMessage;
    sPassMessage    = "Testcase Passed. Expected Error Message displayed for already used Reservation Barcode";
    sFailMessage    = "Testcase Failed. Unexpected/No Error message displayed for already used Reservation Barcode";
    
    TestLog.Message("Error Message Displayed: "+actualErrorMessage);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  
}//TC_DAILY_CHKN_009

function TC_DAILY_CHKN_010() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_010 : CheckIn with a Cancelled Reservation Barcode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

//Variable Declaration 
  //---------------------
  var objMainDialog;// variable to store  main dialog unit object
  var objVehicleInfoForm;//variable to store VehicleInfoForm
  var objReservationInfoForm;//variable to store ReservationInfoForm
  
  var expectedErrorMessage = "RESERVATION HAS BEEN CANCELLED."; //Stores the expected error message    
  var actualErrorMessage; //Stores the error message to be dispalyed
    
  bUpdateFlag = false;
  
  sBarcode = SQLQueries.getReservationBarcode("Cancelled"); 
  
  if(sBarcode === null){
    SQLQueries.updateReservationBarcodeStatus(1);
    sBarcode = SQLQueries.getReservationBarcode("Cancelled"); 
    bUpdateFlag = true;
  }
        
  
  try {
      
    objTestData = { BarCode : sBarcode }; //TestData object for Daily module
                                           
    //Launching the POS application
    Utility.launchApp();
    
    // create object of main dialog unit
    objMainDialog = MainDialog.New();          
      
    objMainDialog.clickOnDailyButton();
    
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
    TestLog.Message("Step-1:clicked on Daily Button"); 
    
    // create object of Vehicle info form unit
    objVehicleInfoForm=VehicleInfoForm.New();
      
    // Click Reservation button for daily checkin.       
    objVehicleInfoForm.clickOnReservationButton();
    
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;  
    TestLog.Message("Step-2: Clicked Reservation button");
       
    objReservationInfoForm = ReservationInfoForm.New();
    // Enter reservation barcode on getiput screen
    actualErrorMessage = objReservationInfoForm.EnterBarCodeWithError(objTestData.BarCode);
      
    //Test Result: Verify employee can see 'RESERVATION HAS BEEN CANCELLED.' error message.
    bTestCaseResult = actualErrorMessage === expectedErrorMessage;
    sPassMessage    = "Testcase Passed. Expected Error Message displayed for CANCELLED Reservation Barcode";
    sFailMessage    = "Testcase Failed. Unexpected/No Error message displayed for CANCELLED Reservation Barcode";
    
    if(bUpdateFlag)
      SQLQueries.updateReservationBarcodeStatus(0,objTestData.BarCode);
    
    TestLog.Message("Error Message Displayed: "+actualErrorMessage);
    
    //Assert Result
    Utility.assertResult(bTestCaseResult,sPassMessage,sFailMessage);      
     
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
  
}//TC_DAILY_CHKN_010


function TC_DAILY_CHKN_011() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_011 : Create manual Entry successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
  var bDBResultPass = false;
  
  eLoginUserDetails = SQLQueries.userLoginDetails("TechnicianMenuUser")
  
  try {
  
    objTestData = { username: eLoginUserDetails.username,
                    password: eLoginUserDetails.password,
                    sColor  : SQLQueries.getRandomVehicleColor().sColor,
                    sVehicleMake: Utility.getRandomString(["Benz","Ford","Audi","Kia","Volks","Volvo"]),
                    TicketNumber: ("9"+Utility.getRandomValue("NUMERIC", 5)),
                    sPlateNumber: Utility.getRandomValue("NUMERIC", 7)                     
                    }; //TestData object for Daily module  
                                                             
    var CheckInDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"); 
                                                  
    //Launching the POS application
    Utility.launchApp();
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
    TestLog.Message("Step-1:Launched the POS application and Initialized the MainDialog screen");
      
    //Navigate into user info screen and submit username and password
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-2: Clicked Log In button.");          
 
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(objTestData);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
      
    TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.UserName);
           
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToTechnicianMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-4: Clicked on Technician Menu Button");
      
    // Enable manual ticket entry
    objTechnicianMenuForm = TechnicianMenuForm.New();
    objTechnicianMenuForm.EnableManualTicketEntry();
    if (objTechnicianMenuForm.lastError.name !== undefined) throw objTechnicianMenuForm.lastError;
      
    TestLog.Message("Step-5:Enable manual ticket entry");
      
    // Click Daily button
    objMainDialog = MainDialog.New();
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
           
    TestLog.Message("Step-6:clicking on Daily Button..");
            
    // Enter manual ticket number
    objCheckInTicketNumberForm = CheckInTicketNumberForm.New();
    objCheckInTicketNumberForm.SetTicketNumber(objTestData.TicketNumber);
    if (objCheckInTicketNumberForm.lastError.name !== undefined) throw objCheckInTicketNumberForm.lastError; 
      
    TestLog.Message("Step-7:Enter manual ticket number"); 
          
    // Enter manual checkin Date and Time
    objManualDateInformationDateForm = ManualDateInformationDateForm.New();
    objManualDateInformationDateForm.EnterCheckInDate(CheckInDate);
    objManualDateInformationDateForm.EnterCheckInTime();
    if (objManualDateInformationDateForm.lastError.name !== undefined) throw objManualDateInformationDateForm.lastError;
      
    TestLog.Message("Step-8:Enter manual checkin Date and Time");
                 
    // Enter vehicle information for daily checkin.       
    objVehicleInfoForm = VehicleInfoForm.New();
    objVehicleInfoForm.provideVehicleDetails(objTestData);
    if (objVehicleInfoForm.lastError.name !== undefined) throw objVehicleInfoForm.lastError;
      
    TestLog.Message("Step-9: enter vehicle Plate number, select color and Make.");
             
    //Click No for vehicle damage confirmation.
    objCheckInVehicleDamageForm = CheckInVehicleDamageForm.New();
    objCheckInVehicleDamageForm.ConfirmNo();                  
    if (objCheckInVehicleDamageForm.lastError.name !== undefined) throw objCheckInVehicleDamageForm.lastError;
      
    TestLog.Message("Step-10: Click No button to confirm vehicle not damage");
    
    eStayDetails = SQLQueries.getLastAddedVehicleStayDetails(objTestData.sPlateNumber);
    
    //Checks if Query yields a result
    //CheckIn vehicle will have StayDateOut as NULL; 
    //Damage if selected No, iDamageIdentification = 1  
    //Daily CheckIn StayType = 0
    if(eStayDetails.bResult && eStayDetails.sStayDateOut == null && eStayDetails.iDamageIdentification == 1 
       && eStayDetails.iStayType == 0){
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
      
    objMainDialog = MainDialog.New();
        
    // Verify ticket number exists on transaction screen 
    Utility.assertResult(objMainDialog.VerifyTicketNumber(objTestData.TicketNumber) || bDBResultPass
                         ,"Vehicle CheckIn Successful during Manual Ticket Entry"
                         ,"Unexpected behaviour during vehicle checkin.");      
     
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
  var actualErrorMessage; //Stores the error message to be dispalyed
  
  eLoginUserDetails = SQLQueries.userLoginDetails("TechnicianMenuUser")       
  
  try {
    objTestData = { 
                    username: eLoginUserDetails.username,
                    password: eLoginUserDetails.password,
                    TicketNumber: ("0"+Utility.getRandomValue("NUMERIC", 5))                    
                  }; //TestData object for Daily module  
                                                             
    var CheckInDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"); 
                                                  
    //Launching the POS application
    Utility.launchApp();
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
    TestLog.Message("Step-1:Launched the POS application and Initialized the MainDialog screen");
      
    //Navigate into user info screen and submit username and password
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-2: Clicked Log In button.");          
 
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(objTestData);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
      
    TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.UserName);
           
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToTechnicianMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-4: Clicked on Technician Menu Button");
      
    // Enable manual ticket entry
    objTechnicianMenuForm = TechnicianMenuForm.New();
    objTechnicianMenuForm.EnableManualTicketEntry();
    if (objTechnicianMenuForm.lastError.name !== undefined) throw objTechnicianMenuForm.lastError;
      
    TestLog.Message("Step-5:Enable manual ticket entry");
      
    // Click Daily button
    objMainDialog = MainDialog.New();
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
           
    TestLog.Message("Step-6:clicking on Daily Button..");
            
    // Enter manual ticket number
    objCheckInTicketNumberForm = CheckInTicketNumberForm.New();         
    objCheckInTicketNumberForm.SetTicketNumber(objTestData.TicketNumber);
    if (objCheckInTicketNumberForm.lastError.name !== undefined) throw objCheckInTicketNumberForm.lastError; 
           
    TestLog.Message("Step-7:Entered Invalid Ticket Number");
      
    objMainDialog = MainDialog.New();  
    actualErrorMessage = objMainDialog.GetFormInfo().Message; 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    
    TestLog.Message("Error essage displayed: "+ actualErrorMessage );     
      
    // Verify error message exists on menu screen 
    Utility.assertResult(actualErrorMessage === "TICKET NUMBER "+objTestData.TicketNumber+" NOT FOUND."
                         ,"Expected Error message displayed for invalid ticket number during Manual ticket entry"
                         ,"Unexpected/No error message exists for invlaid ticket number during Manual ticket entry"
                        ); 
             
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
  
}//TC_DAILY_CHKN_012


function TC_DAILY_CHKN_013() {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_DAILY_CHKN_013 : Create manual Entry with Already Checked out Ticket number
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
  var actualErrorMessage; //Stores the error message to be dispalyed
  
  eLoginUserDetails = SQLQueries.userLoginDetails("TechnicianMenuUser")       
  
  try {
    objTestData = { 
                    username: eLoginUserDetails.username,
                    password: eLoginUserDetails.password,
                    TicketNumber: SQLQueries.getCheckOutTicketDetails("Daily").sTicketNumber                   
                  }; //TestData object for Daily module  
                                                             
    var CheckInDate = aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m%d20%y"); 
                                                  
    //Launching the POS application
    Utility.launchApp();
    //create object of main dialog unit
    objMainDialog = MainDialog.New();          
    TestLog.Message("Step-1:Launched the POS application and Initialized the MainDialog screen");
      
    //Navigate into user info screen and submit username and password
    objMainDialog.NavigateToUserInfoScreen();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-2: Clicked Log In button.");          
 
    //Set data in Username and Password field and click Enter button from Navigation panel
    objUserInfo = UserInfoForm.New();
    objUserInfo.InputAndSubmitForm(objTestData);
    if (objUserInfo.lastError.name !== undefined) throw objUserInfo.lastError;
      
    TestLog.Message("Step-3: Navigated to User Info screen and Logged in as "+objTestData.UserName);
           
    objMainDialog = MainDialog.New();
    objMainDialog.NavigateToTechnicianMenu();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError;
      
    TestLog.Message("Step-4: Clicked on Technician Menu Button");
      
    // Enable manual ticket entry
    objTechnicianMenuForm = TechnicianMenuForm.New();
    objTechnicianMenuForm.EnableManualTicketEntry();
    if (objTechnicianMenuForm.lastError.name !== undefined) throw objTechnicianMenuForm.lastError;
      
    TestLog.Message("Step-5:Enable manual ticket entry");
      
    // Click Daily button
    objMainDialog = MainDialog.New();
    objMainDialog.clickOnDailyButton();
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
           
    TestLog.Message("Step-6:clicking on Daily Button..");
            
    // Enter manual ticket number
    objCheckInTicketNumberForm = CheckInTicketNumberForm.New();         
    objCheckInTicketNumberForm.SetTicketNumber(objTestData.TicketNumber);
    if (objCheckInTicketNumberForm.lastError.name !== undefined) throw objCheckInTicketNumberForm.lastError; 
           
    TestLog.Message("Step-7:Entered Invalid Ticket Number");
      
    objMainDialog = MainDialog.New();  
    actualErrorMessage = objMainDialog.GetFormInfo().Message; 
    if (objMainDialog.lastError.name !== undefined) throw objMainDialog.lastError; 
    
    TestLog.Message("Error essage displayed: "+ actualErrorMessage );     
      
    // Verify error message exists on menu screen 
    Utility.assertResult(actualErrorMessage === "TICKET "+objTestData.TicketNumber+" ALREADY CHECKED OUT."
        ,"Expected Error message displayed for already checked out ticket number during Manual ticket entry"
        ,"Unexpected/No error message exists for already checked out ticket number during Manual ticket entry"); 
             
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
  
}//TC_DAILY_CHKN_013