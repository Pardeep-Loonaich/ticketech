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
  
  this.scrnVehiInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenVehicleInfo", 1);
  
  this.throwError = false ; 
    
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

    return this.vehicleInfoScreen.Exists;  //Return whether vehicleInfoScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

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
              message     : this.scrnEmployeeInfo + " Screen does not Exist." }             
    
    if (empID !== undefined && empID !== null)
      this.scrnEmployeeInfo.FindChild("WinFormsControlName", "labelTextBox", 2).Keys(empID);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetEmployeeID

employeeInfoScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the info screen 
  
  Output      : Returns the error message displayed in the emp info screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeInfoScreen.GetErrorMessage: The Info screen does not Exist.",
              message     : this.scrnInfo + " Info does not Exist." }             
    
    return this.scrnEmployeeInfo.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new employeeInfoScreen();  
}