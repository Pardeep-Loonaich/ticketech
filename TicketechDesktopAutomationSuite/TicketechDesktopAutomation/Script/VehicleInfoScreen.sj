//USEUNIT Utility


/******************************************************************************
            ---------- Class Definition ----------
  Name:VehicleInfoScreen
  
  Description: 
  
  This class has methods and properties to perform the VehicleInfoScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function vehicleInfoScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: vehicleInfoScreen() 
  
  Description: This method will the Instantiate the VehicleInfoScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnVehiInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenVehicleInfo", 3);
  
  this.throwError = false; 
    
} //VehicleInfoScreen

vehicleInfoScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the vehicleInfoScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnVehiInfo.Exists;  //Return whether vehicleInfoScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

vehicleInfoScreen.prototype.Refresh = function () {  

/*---------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method re-instantiate the vehicleInfoScreen.    
----------------------------------------------------------------------*/  
  try {

    this.scrnVehiInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenVehicleInfo");
     
  } //End try
  
 catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh



vehicleInfoScreen.prototype.EnterPlateNumber = function (plateNumber) {  

/*-------------------------------------------------------------------------------
  Method      : EnterPlateNumber()
  
  Description : This method enters the Vehicle plate number on the Vehicle Info screen
  
  Output      : Enters the Plate Number in Vehicle Info screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at vehicleInfoScreen.EnterPlateNumber: The Vehicle Plate textfield does not Exist.",
              message     : this.scrnVehiInfo + " Screen does not Exist." }             
    
    if (plateNumber !== undefined && plateNumber !== null)
      //this.scrnVehiInfo.FindChild("WinFormsControlName", "labelTextBox", 2).Keys(plateNumber);
      this.scrnVehiInfo.WinFormsObject("selectableTextBoxListFields").WinFormsObject("SelectableTextBox").WinFormsObject("labelTextBox").Keys(plateNumber);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterPlateNumber




vehicleInfoScreen.prototype.verifyFocus_On_PlateTextField = function () {  

/*-------------------------------------------------------------------------------
  Method      : verifyFocus_On_PlateTextField()
  
  Description : 
  
  Output      :  
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at vehicleInfoScreen.verifyFocus_On_PlateTextField: The Vehicle Plate textfield does not Exist.",
              message     : this.scrnVehiInfo + " Screen does not Exist." }             
    
   
      return this.scrnVehiInfo.WinFormsObject("selectableTextBoxListFields")
      .WinFormsObject("SelectableTextBox").WinFormsObject("labelTextBox").Enabled;
      
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //verifyFocus_On_PlateTextField


vehicleInfoScreen.prototype.IsFieldAvailable = function (sCaption) {  

/*-------------------------------------------------------------------------------
  Method      : IsFieldAvailable()
  
  Description : This method returns true if the field is Visible, else false
  
  Output      : Returns true if the field is Visible, else returns false 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at vehicleInfoScreen.IsFieldAvailable: The Vehicle Plate textfield does not Exist.",
              message     : this.scrnVehiInfo + " Screen does not Exist." }             
    
    objVehicleInfoField = this.scrnVehiInfo.FindChild(["WinFormsControlName","Caption"],["SelectableTextBox",sCaption],3);           
              
    return objVehicleInfoField.Visible;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //IsFieldAvailable


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new vehicleInfoScreen();  
}