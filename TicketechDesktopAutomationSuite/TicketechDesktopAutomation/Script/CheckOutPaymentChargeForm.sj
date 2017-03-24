//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT testOptionsPanel
//USEUNIT PaymentChargeScreen
//USEUNIT PaymentPanel
//USEUNIT NumericPanel
//USEUNIT Utility


/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckOutPaymentChargeForm
  
  Description: 
  
  This class has methods and properties to perform the CheckOutPaymentChargeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkOutPaymentChargeForm() { 

/*-------------------------------------------------------------------------- 
  Method: checkOutPaymentChargeForm() 
  
  Description: This method will the Instantiate the checkOutPaymentChargeForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckOutPaymentCharge  = Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentCharge", 3000); 
  
  this.objInfoScreen             = InformationScreen.New();
  this.objPaymentChargeScreen    = PaymentChargeScreen.New();
  this.objNavigationPanel        = NavigationPanel.New();
  this.objPaymentPanel           = PaymentPanel.New();
  this.objtestOptionsPanel       = testOptionsPanel.New();
  this.objNumericPanel           = NumericPanel.New();
  
  this.throwError = false; 
    
} //checkOutPaymentChargeForm

checkOutPaymentChargeForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the checkOutPaymentChargeForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgCheckOutPaymentCharge           = Sys.Process("PosApplication").WaitWinFormsObject("FormCheckOutPaymentCharge*", 3000); 
  
     this.objInfoScreen             = InformationScreen.New();
     this.objPaymentChargeScreen    = PaymentChargeScreen.New();
     this.objNavigationPanel        = NavigationPanel.New();
     this.objPaymentPanel           = PaymentPanel.New();
     this.objtestOptionsPanel       = testOptionsPanel.New();
     this.objNumericPanel           = NumericPanel.New();
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

checkOutPaymentChargeForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkOutPaymentChargeForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckOutPaymentCharge.Exists;  //Return whether checkOutPaymentChargeForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


checkOutPaymentChargeForm.prototype.SetAccountNumber= function (sAccountNo)   {  

/*-----------------------------------------------------------------
  Method      : SetAccountNumber()
  
  Description : This method will enter the account number 
     
-----------------------------------------------------------------*/ 
  try {
  
    this.objPaymentChargeScreen.SetAccountNo(sAccountNo);
   
    this.objNavigationPanel.ClickEnter();
    Delay(1000);

   } //End Try
  
   catch (exception) {
     for (prop in exception) 
     this.lastError[prop] = exception[prop];
     if (this.throwError) throw exception;
    
  } //End catch 
   
} //SetAccountNumber


checkOutPaymentChargeForm.prototype.GetFormInfo = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the footer message of the Screen  
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkOutPaymentChargeForm.getFormInfo: The checkOutPaymentChargeForm does not Exist.",
              message     : this.dlgCheckOutPaymentCharge + " The checkOutPaymentChargeForm does not Exist." }
     
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
  This method is for instantiating checkOutPaymentChargeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkOutPaymentChargeForm();  
}
