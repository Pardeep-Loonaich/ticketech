//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT UserIdentificationScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel
//USEUNIT VehicleInfoScreen
//USEUNIT ColorPanel
//USEUNIT MakesPanel

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

/*--------------------------------------------------------------------- 
  Method: VehicleInfoForm() 
  
  Description: This method will the Instantiate the VehicleInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.vehicleInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehiclePlate", 3000); 
  
  this.objVehicleInfoScrn = VehicleInfoScreen.New();
  
  this.throwError = false; 
    
} //VehicleInfoForm

vehicleInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the VehicleInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    Sys.Refresh();
    Delay(1000);

    
    this.vehicleInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehiclePlate", 3000); 
  
    this.objVehicleInfoScrn = VehicleInfoScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

vehicleInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the vehicle info form.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.vehicleInfo.Exists;  //Return whether VehicleInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists



 vehicleInfoForm.prototype.provideVehicleDetails = function (sPlateNumber,sColor,sVehicleMake)   {  

/*-----------------------------------------------------------------
  Method      : provideVehicleDetails()
  
  Description : This method will enter vehicle plater number, color and make.  
     
-----------------------------------------------------------------*/ 
try
{ 
//Enter Plate No.
  objVehicleInfoScrn= VehicleInfoScreen.New();
  TestLog.Message("Entering vehicle plate Number..");
  objVehicleInfoScrn.EnterPlateNumber(sPlateNumber);
  objNavigationPanel = NavigationPanel.New();
  objNavigationPanel.ClickEnter();
  // Select vehicle color
  objColorPanel = ColorPanel.New();
  TestLog.Message("Selecting vehicle Color..");
  objColorPanel.SelectColor(sColor);
  // Select Vehicle make  
  objMakesPanel = MakesPanel.New();
  TestLog.Message("Selecting vehicle Make as ");
  objMakesPanel.SelectVehicleMake(sVehicleMake);
   
  } // End Try
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
    
  } //End catch 
   
} //provideVehicleDetails



vehicleInfoForm.prototype.clickOnEnterButton = function () {  

/*-----------------------------------------------------------------
  Method      : clickOnEnterButton()
  
  Description : This method will enter vehicle plater no.  
     
-----------------------------------------------------------------*/  
//Creating object for NavigationPanel
  objVehicleInfoScrn= NavigationPanel.New();
  //invoking mehtod from NavigationPanel
  objVehicleInfoScrn.ClickEnter();
 
  
  


      
} //clickOnEnterButton


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating VehicleInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new vehicleInfoForm();  
}