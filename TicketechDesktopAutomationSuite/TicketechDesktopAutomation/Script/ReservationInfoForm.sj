//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT GetInputScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:ReservationInfoForm
  
  Description: 
  
  This class has methods and properties to perform the ReservationInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function reservationInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: reservationInfoForm() 
  
  Description: This method will the Instantiate the reservationInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmReservationInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormReservationInfo", 3000); 
  
  this.objGetInputScreen = GetInputScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //reservationInfoForm

reservationInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the reservationInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.frmReservationInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormReservationInfo", 3000); 
  
    this.objGetInputScreen = GetInputScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
        
    } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

reservationInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reservationInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmReservationInfo.Exists;  //Return whether reservationInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reservationInfoForm.prototype.EnterBarCode = function (sBarCode) {  

/*--------------------------------------------------------------------------
  Method      : EnterBarCode()
  
  Description : This method enters BarCode and clicks Enter button  
  
  Output      : Enters BarCode if GetInput Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationInfoForm.EnterBarCode: The Reservation Info Form does not Exist.",
              message     : this.frmReservationInfo + " The Reservation Info Form does not Exist." }             
    
    this.objGetInputScreen.SetBarCode(sBarCode);
    Delay(1000);
    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterBarCode

reservationInfoForm.prototype.EnterBarCodeWithError = function (sBarCode) {  

/*--------------------------------------------------------------------------
  Method      : EnterBarCodeWithError()
  
  Description : This method enters BarCode and click enter button and returns error. 
  
  Output      : Returns Error message after entering BarCode
--------------------------------------------------------------------------*/  
  try {
  
    this.EnterBarCode(sBarCode);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.objGetInputScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterBarCodeWithError()


reservationInfoForm.prototype.FillBarCode = function (sBarCode) {  

/*--------------------------------------------------------------------------
  Method      : FillBarCode()
  
  Description : This method just enters BarCode and don't clicks on Enter button  
  
  Output      : Only Enters BarCode if GetInput Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationInfoForm.EnterBarCode: The Reservation Info Form does not Exist.",
              message     : this.frmReservationInfo + " The Reservation Info Form does not Exist." }             
    
    this.objGetInputScreen.SetBarCode(sBarCode);
    Delay(1000);
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //FillBarCode


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating reservationInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reservationInfoForm();  
}
