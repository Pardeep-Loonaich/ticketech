//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:CustomerVehicleScreen
  
  Description: 
  
  This class has methods and properties to perform the CustomerVehicleScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function customerVehicleScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: customerVehicleScreen() 
  
  Description: This method will the Instantiate the CustomerVehicleScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnCustomerVehicle =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenCustomerVehicle", 3);
  
  this.throwError = false; 
    
} //customerVehicleScreen

customerVehicleScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the customerVehicleScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnCustomerVehicle.Exists;  //Return whether customerVehicleScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

customerVehicleScreen.prototype.ClickOther = function () {  

/*-------------------------------------------------------------------------------
  Method      : ClickOther()
  
  Description : This method clicks Other to checkin new vehicle for customer
  
  Output      : Clicks Other on Customer Vehicle screen 
-------------------------------------------------------------------------------*/  
  try {
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at customerVehicleScreen.ClickOther: The Customer Vehicle Exist.",
              message     : this.scrnCustomerVehicle + " Screen Exist." }             
    
       this.scrnCustomerVehicle.WinFormsObject("panel1").WinFormsObject("dataGridView").ClickCell(0,0);
       Log.Message("clicked Other to checkin vehicle");
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickOther


customerVehicleScreen.prototype.ClickFirstVehicleRow = function () {  

/*-------------------------------------------------------------------------------
  Method      : ClickFirstVehicleRow()
  
  Description : This method clicks first row of vehicle from customer vehicle grid
  
  Output      : Clicks first Customer Vehicle on screen 
-------------------------------------------------------------------------------*/  
  try {
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at customerVehicleScreen.ClickOther: The Customer Vehicle Exist.",
              message     : this.scrnCustomerVehicle + " Screen Exist." }             
    
       this.scrnCustomerVehicle.WinFormsObject("panel1").WinFormsObject("dataGridView").ClickCell(1,1);
       Log.Message("clicked first vehicle on screen");
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickFirstVehicleRow


function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating customerVehicleScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new customerVehicleScreen();  
}