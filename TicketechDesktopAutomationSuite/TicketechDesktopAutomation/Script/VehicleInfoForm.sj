//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT UserIdentificationScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT VehicleInfoScreen
//USEUNIT ColorPanel
//USEUNIT MakesPanel
//USEUNIT DealsOptionsPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:vehicleInfoForm
  
  Description: it contains all method of vehicle info screen
  
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/
//variable deceleration 
var objVehicleInfoScrn;
var objColorPanel;
var objMakesPanel;
var objNavigationPanel;

function vehicleInfoForm() { 

/*------------------------------------------------------------------------- 
  Method: VehicleInfoForm() 
  
  Description: This method will the Instantiate the VehicleInfoForm Wrapper
-------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgVehicleInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehicle*", 3000); 
  
  this.objVehicleInfoScrn = VehicleInfoScreen.New();
  
  this.throwError = false; 
    
} //VehicleInfoForm

vehicleInfoForm.prototype.Refresh = function () {  

/*-----------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the VehicleInfoForm Wrapper   
-----------------------------------------------------------------------------*/  
  try {

    this.dlgVehicleInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehicle*", 3000); 
  
    this.objVehicleInfoScrn = VehicleInfoScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

vehicleInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the vehicle info form.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgVehicleInfo.Exists;  //Return whether VehicleInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


 vehicleInfoForm.prototype.provideVehicleDetails = function (eVehicleDetails)   {  

/*-------------------------------------------------------------------------
  Method      : provideVehicleDetails()
  
  Description : This method will enter vehicle plate number, color and make    
-------------------------------------------------------------------------*/ 
try
{ 
 //Enter Plate No.
  objVehicleInfoScrn= VehicleInfoScreen.New();
  
  
  objVehicleInfoScrn.EnterPlateNumber(eVehicleDetails.sPlateNumber);
  
  if(eVehicleDetails.sPlateNumber.length < 7){
    objNavigationPanel = NavigationPanel.New();
    objNavigationPanel.ClickEnter();
  }
  TestLog.Message("Entered vehicle plate Number as "+eVehicleDetails.sPlateNumber);
  
  this.Refresh();Delay(3000);
  
  // Select vehicle color
  objColorPanel = ColorPanel.New();
  objColorPanel.SelectColor(eVehicleDetails.sColor);
  
  TestLog.Message("Selected vehicle Color as "+eVehicleDetails.sColor);
  
  this.Refresh();Delay(5000);
  
  // Select Vehicle make  
  objMakesPanel = MakesPanel.New();

  objMakesPanel.SelectVehicleMake(eVehicleDetails.sVehicleMake);
  TestLog.Message("Selected vehicle Make as " +eVehicleDetails.sVehicleMake);
  
  Delay(2000);
   
  } // End Try
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
    
  } //End catch 
   
} //provideVehicleDetails


vehicleInfoForm.prototype.provideVehiclePlate = function (sPlateNumber)   {  

/*----------------------------------------------------------
  Method      : provideVehiclePlate()
  
  Description : This method will enter vehicle plate number.    
----------------------------------------------------------*/ 
try
{ 
  //Enter Plate No.
  objVehicleInfoScrn= VehicleInfoScreen.New();
  
  TestLog.Message("Entering vehicle plate Number..");
  
  objVehicleInfoScrn.EnterPlateNumber(sPlateNumber);
  
  objNavigationPanel = NavigationPanel.New();
  objNavigationPanel.ClickEnter();
   
  } // End Try
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
    
  } //End catch 
   
} //provideVehiclePlate

vehicleInfoForm.prototype.clickOnEnterButton = function () {  

/*-------------------------------------------------------
  Method      : clickOnEnterButton()
  
  Description : This method will enter vehicle plater no.      
-------------------------------------------------------*/ 
 
  //Creating object for NavigationPanel
  objNavigationPanel = NavigationPanel.New();
  
  objNavigationPanel.ClickEnter();
    
} //clickOnEnterButton


vehicleInfoForm.prototype.clickOnReservationButton = function () {  

/*-----------------------------------------------------------------------------
  Method      : clickOnReservationButton()
  
  Description : This method will click Reservation button on deals options panel  
------------------------------------------------------------------------------*/  

  //Creating object for DealsOptionsPanel
  objDealsOptionsPanel= DealsOptionsPanel.New();

  objDealsOptionsPanel.ClickReservation();
    
} //clickOnReservationButton

vehicleInfoForm.prototype.clickOnPrepayButton = function () {  

/*-----------------------------------------------------------------------------
  Method      : clickOnPrepayButton()
  
  Description : This method will click Prepay button on deals options panel  
------------------------------------------------------------------------------*/  

  //Creating object for DealsOptionsPanel
  objDealsOptionsPanel= DealsOptionsPanel.New();

  objDealsOptionsPanel.ClickPrepay();
    
} //clickOnReservationButton

function New() {

/*---------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating VehicleInfoForm() class from other units of the project. 
-----------------------------------------------------------------------------------------*/

  return new vehicleInfoForm();  
}


vehicleInfoForm.prototype.InputVehicleDetails = function (eVehicleDetails) {  

/*--------------------------------------------------------------------
  Method      : InputVehicleDetails()
  
  Description : This method will check for the VehicleFields available 
                during rush mode and do Check-In in Rush mode  
     
--------------------------------------------------------------------*/  
  bMatched = false;

  objVehicleInfoScrn= VehicleInfoScreen.New();
  
  if(eVehicleDetails.Plate === "YES"){
    if(objVehicleInfoScrn.IsFieldAvailable("PLATE")){
      objVehicleInfoScrn.EnterPlateNumber(eVehicleDetails.sPlateNumber);
      if(eVehicleDetails.sPlateNumber.length < 7){
        objNavigationPanel = NavigationPanel.New();
        objNavigationPanel.ClickEnter();
      }
    }
    else
      return bMatched;
  }
  else{
    if(objVehicleInfoScrn.IsFieldAvailable("PLATE"))
      return bMatched;
  }
  
  if(eVehicleDetails.Color === "YES"){
    if(objVehicleInfoScrn.IsFieldAvailable("COLOR")){
      objColorPanel = ColorPanel.New();
      objColorPanel.SelectColor(eVehicleDetails.sColor);
    }
    else
      return bMatched;
  }
  else{
    if(objVehicleInfoScrn.IsFieldAvailable("COLOR"))
      return bMatched;
  }

  if(eVehicleDetails.Make === "YES"){
    if(objVehicleInfoScrn.IsFieldAvailable("MAKE")){
      objMakesPanel = MakesPanel.New();
      objMakesPanel.SelectVehicleMake(eVehicleDetails.sVehicleMake);
    }
    else
      return bMatched;
  }
  else{
    if(objVehicleInfoScrn.IsFieldAvailable("MAKE"))
      return bMatched;
  } 
  
  bMatched = true;
  
  return bMatched;
} //InputVehicleDetails

vehicleInfoForm.prototype.GetVisibleFieldDetails = function (sRushMode) {  

/*---------------------------------------------------------------------------------
  Method      : getVisibleFieldDetails()
  
  Description : This method will give the Details of Visible fields in Daily Screen  
     
---------------------------------------------------------------------------------*/  
  eFieldDetails = {PlateField:false, ColorField:false, MakeField:false};

  objVehicleInfoScrn= VehicleInfoScreen.New();
  
  if(objVehicleInfoScrn.IsFieldAvailable("PLATE")){
    eFieldDetails.PlateField = true;
  }
  if(objVehicleInfoScrn.IsFieldAvailable("COLOR")){
    eFieldDetails.ColorField = true;
  }
  if(objVehicleInfoScrn.IsFieldAvailable("MAKE")){
    eFieldDetails.MakeField = true;
  }
  if(sRushMode === "Disabled")
    return eFieldDetails.PlateField && eFieldDetails.ColorField && eFieldDetails.MakeField;
  else
    return eFieldDetails;
} //getVisibleFieldDetails
