//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT CustomerInfoScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInCustomerInfoForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInCustomerInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInCustomerInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInCustomerInfoForm() 
  
  Description: This method will the Instantiate the checkInCustomerInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckInCustomerInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInCustomerInfo", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.customerInfoScreen = CustomerInfoScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.numericPanel = NumericPanel.New();
  
  this.throwError = false; 
    
} //checkInCustomerInfoForm

checkInCustomerInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkInCustomerInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgCheckInCustomerInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInCustomerInfo", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.customerInfoScreen = CustomerInfoScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.numericPanel = NumericPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkInCustomerInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInCustomerInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckInCustomerInfo.Exists;  //Return whether checkInCustomerInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

checkInCustomerInfoForm.prototype.InputAndSubmitForm = function (sVehicleTag) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters tag
  
  Output      : Enters tag if CheckInCustomerInfo Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInCustomerInfoForm.InputAndSubmitForm: The User Info Form does not Exist.",
              message     : this.dlgCheckInCustomerInfo + " The CheckInCustomerInfo Form does not Exist." }             
    
    this.customerInfoScreen.SetVehicleTag(sVehicleTag);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitForm

checkInCustomerInfoForm.prototype.InputAndSubmitFormWithErrors = function (sVehicleTag) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
    
  Description : This method enters Vehicle Tag
  
  Output      : Enters Vehicle Tag if CheckInCustomerInfo Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(sVehicleTag);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.customerInfoScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at CheckIncustomerInfoForm.InputAndSubmitFormWithErrors")
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitFormWithErrors

checkInCustomerInfoForm.prototype.ClickCancel = function (sVehicleTag) {  

/*--------------------------------------------------------------------------
  Method      : ClickCancel()
  
  Description : This method enters tag and clicks cancel
  
  Output      : Enters tag if CheckInCustomerInfo Form Exists and clicks Cancel
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInCustomerInfoForm.ClickCancel: The User Info Form does not Exist.",
              message     : this.dlgCheckInCustomerInfo + " The CheckInCustomerInfo Form does not Exist." }             
    
    this.customerInfoScreen.SetVehicleTag(sVehicleTag);
    Delay(1000);
    
    this.navigationPanel.ClickCancel();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickCancel


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInCustomerInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInCustomerInfoForm();  
}

