//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT NonPaymentReasonsPanel
//USEUNIT PaymentNoChargeScreen
//USEUNIT Utility
//USEUNIT PaymentPanel

/*************************************************************************
            ---------- Class Definition ----------
  Name:NoChargePaymentForm
  
  Description: 
  
  This class has methods and properties to perform the NoChargePaymentForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function noChargePaymentForm() { 

/*-------------------------------------------------------------------------- 
  Method: noChargePaymentForm() 
  
  Description: This method will the Instantiate the noChargePaymentForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgNoChargePayment        = Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentNoCharge*", 3000); 
  
  this.objInfoScreen             = InformationScreen.New();
  this.objPaymentNoChargeScreen  = PaymentNoChargeScreen.New();
  this.objNavigationPanel        = NavigationPanel.New();
  this.objPaymentPanel           = PaymentPanel.New();
  this.objNonPaymentReasonsPanel = NonPaymentReasonsPanel.New();
  
  this.throwError = false; 
    
} //noChargePaymentForm

noChargePaymentForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the noChargePaymentForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgNoChargePayment        = Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentNoCharge*", 3000); 
  
    this.objInfoScreen             = InformationScreen.New();
    this.objPaymentNoChargeScreen  = PaymentNoChargeScreen.New();
    this.objNavigationPanel        = NavigationPanel.New();
    this.objPaymentPanel           = PaymentPanel.New();
    this.objNonPaymentReasonsPanel = NonPaymentReasonsPanel.New();
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

noChargePaymentForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the noChargePaymentForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgNoChargePayment.Exists;  //Return whether noChargePaymentForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


noChargePaymentForm.prototype.EnterDescription= function (sDescription)   {  

/*-----------------------------------------------------------------
  Method      : EnterDescription()
  
  Description : This method will enter the description.  
     
-----------------------------------------------------------------*/ 
  try {
  
    this.objPaymentNoChargeScreen.SetDescription(sDescription);
   
    this.objNavigationPanel.ClickEnter();
    Delay(1000);

   } //End Try
  
   catch (exception) {
     for (prop in exception) 
     this.lastError[prop] = exception[prop];
     if (this.throwError) throw exception;
    
  } //End catch 
   
} //enterDescription

noChargePaymentForm.prototype.ClickNoChargeType= function () {  

/*--------------------------------------------------------------------------
  Method      : ClickNoChargeType()
  
  Description : This method Clicks on the given nocharge type button    
  
  Output      : Clicks the given button if NoChargePaymentForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
     if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at noChargePaymentForm.ClickOtherIncome: The noChargePaymentForm does not Exist.",
              message     : this.dlgNoChargePayment + " The noChargePaymentForm does not Exist." }             
    
    this.objNonPaymentReasonsPanel.Click("NO CHARGE");
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickNoChargeType

noChargePaymentForm.prototype.GetFormInfo = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the footer message of the Screen  
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at noChargePaymentForm.getFormInfo: The noChargePaymentForm does not Exist.",
              message     : this.dlgNoChargePayment + " The noChargePaymentForm does not Exist." }
     
    frmInfo = {  
                 sFooterMessage  : this.objPaymentNoChargeScreen.GetErrorMessage()
              };
      
    return frmInfo;    
  }
  
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }

}//GetFormInfo


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating noChargePaymentForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new noChargePaymentForm();  
}
