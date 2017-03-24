//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT CustomerVehicleScreen
//USEUNIT NavigationPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInCustomerVehicleForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInCustomerVehicleForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInCustomerVehicleForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInCustomerVehicleForm() 
  
  Description: This method will the Instantiate the checkInCustomerVehicleForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmCheckInCustomerVehicle =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInCustomerVehicle", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objCustomerVehicleScreen = CustomerVehicleScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //checkInCustomerVehicleForm

checkInCustomerVehicleForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkInCustomerVehicleForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.frmCheckInCustomerVehicle =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInCustomerVehicle", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objCustomerVehicleScreen = CustomerVehicleScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkInCustomerVehicleForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInCustomerVehicleForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmCheckInCustomerVehicle.Exists;  //Return whether checkInCustomerVehicleForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkInCustomerVehicleForm.prototype.SelectOtherVehicle = function () {  

/*--------------------------------------------------------------------------
  Method      : SelectOtherVehicle()
  
  Description : This method clicks on Other
  
  Output      : clicks Other vehicle to checkin
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInCustomerVehicleForm.SelectOtherVehicle: The Customer Vehicle Form does not Exist.",
              message     : this.frmCheckInCustomerVehicle + " The checkInCustomerVehicleForm Form does not Exist." }             
    
    this.objCustomerVehicleScreen.ClickOther();
    Delay(1000);    
    
    //this.Refresh();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectOtherVehicle


checkInCustomerVehicleForm.prototype.SelectFirstVehicle = function () {  

/*--------------------------------------------------------------------------
  Method      : SelectFirstVehicle()
  
  Description : This method clicks on first vehicle from grid
  
  Output      : clicks first vehicle to checkin from vehicle grid
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInCustomerVehicleForm.SelectFirstVehicle: The Customer Vehicle Form does not Exist.",
              message     : this.frmCheckInCustomerVehicle + " The checkInCustomerVehicleForm Form does not Exist." }             
    
    this.objCustomerVehicleScreen.ClickFirstVehicleRow();
    Delay(1000);    
    
    //this.Refresh();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SelectFirstVehicle


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInCustomerVehicleForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInCustomerVehicleForm();  
}

