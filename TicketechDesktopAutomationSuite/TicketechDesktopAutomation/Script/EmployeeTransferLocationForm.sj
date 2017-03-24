//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT EmployeeTransferScreen
//USEUNIT NumericPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeTransferLocationForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeeTransferLocationForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeTransferLocationForm() { 

/*--------------------------------------------------------------------- 
  Method: employeeTransferLocationForm() 
  
  Description: This method will the Instantiate the employeeTransferLocationForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeeTransferLocation =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeTransferLocation", 3000); 
  
  this.infoScreen             = InformationScreen.New();
  this.employeeTransferScreen = EmployeeTransferScreen.New();
  this.navigationPanel        = NavigationPanel.New();
  this.numericPanel           = NumericPanel.New();
  
  this.throwError = false; 
    
} //employeeTransferLocationForm

employeeTransferLocationForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeTransferLocationForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.dlgEmployeeTransferLocation =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeTransferLocation", 3000); 
  
    this.infoScreen             = InformationScreen.New();
    this.employeeTransferScreen = EmployeeTransferScreen.New();
    this.navigationPanel        = NavigationPanel.New();
    this.numericPanel           = NumericPanel.New();
        
  } //End try
  
  catch (exception) {
	TestLog.Messgae("Exception at EmployeeTransferLocationForm.Refresh");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeTransferLocationForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeTransferLocationForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeeTransferLocation.Exists;  //Return whether employeeTransferLocationForm exists or not
  
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at EmployeeTransferLocationForm.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeTransferLocationForm.prototype.InputLocationCode = function (code) {  

/*--------------------------------------------------------------------------
  Method      : InputLocationCode()
  
  Description : This method enters Location Code  
  
  Output      : Enters Location Code if EmployeeTransferLocation Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FormEmployeeTransferLocation.InputLocationCode: The EmployeeTransferLocation Form does not Exist.",
              message     : this.dlgEmployeeTransferLocation + " The EmployeeTransferLocation Form does not Exist." }             
    
    this.employeeTransferScreen.SetLocationCode(code);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at EmployeeTransferLocationForm.InputLocationCode");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputLocationCode


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeTransferLocationForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeTransferLocationForm();  
}
