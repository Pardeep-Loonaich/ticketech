//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT YesNoConfirmActionPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInVehicleDamageForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInVehicleDamageForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInVehicleDamageForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInVehicleDamageForm() 
  
  Description: This method will Instantiate the checkInVehicleDamageForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckInVehicleDamage =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehicleDamage", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objYesNoConfirmActionPanel = YesNoConfirmActionPanel.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //checkInVehicleDamageForm


checkInVehicleDamageForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInVehicleDamageForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckInVehicleDamage.Exists;  //Return whether checkInVehicleDamageForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkInVehicleDamageForm.prototype.ConfirmYes = function () {  

/*--------------------------------------------------------------------------
  Method      : ConfirmYes()
  
  Description : This method Clicks Yes button  
  
  Output      : Clicks Yes button if checkInVehicleDamageForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInVehicleDamageForm.ConfirmYes: The checkInVehicleDamageForm does not Exist.",
              message     : this.dlgCheckInVehicleDamage + " The checkInVehicleDamageForm does not Exist." }             
    
    this.objYesNoConfirmActionPanel.ClickYes();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ConfirmYes

checkInVehicleDamageForm.prototype.ConfirmNo = function () {  

/*--------------------------------------------------------------------------
  Method      : ConfirmNo()
  
  Description : This method Clicks No button  
  
  Output      : Clicks No button if checkInVehicleDamageForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInVehicleDamageForm.ConfirmYes: The checkInVehicleDamageForm does not Exist.",
              message     : this.dlgCheckInVehicleDamage + " The checkInVehicleDamageForm does not Exist." }             
    
    this.objYesNoConfirmActionPanel.ClickNo();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ConfirmNo

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInVehicleDamageForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInVehicleDamageForm();  
}