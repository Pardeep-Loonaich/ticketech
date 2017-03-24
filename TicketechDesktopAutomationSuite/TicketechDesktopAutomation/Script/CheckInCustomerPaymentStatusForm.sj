//USEUNIT Utility
//USEUNIT PaymentStatusScreen
//USEUNIT NavigationPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInCustomerPaymentStatusForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInCustomerPaymentStatusForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInCustomerPaymentStatusForm() { 

/*------------------------------------------------------------------------------------------  
  Method: checkInCustomerPaymentStatusForm() 
  
  Description: This method will the Instantiate the checkInCustomerPaymentStatusForm Wrapper
------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgCheckInCustomerPaymentStatus =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInCustomerPaymentStatus", 3000); 
  
  this.objPaymentStatusScreen = PaymentStatusScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //checkInCustomerPaymentStatusForm

checkInCustomerPaymentStatusForm.prototype.Exists = function () {  

/*-------------------------------------------------------------------------------------- 
  Method      : Exists()
  
  Description : This method checks the existance of the checkInCustomerPaymentStatusForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
---------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgCheckInCustomerPaymentStatus.Exists;  //Return whether CheckInCustomerPaymentStatusForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInCustomerPaymentStatusForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInCustomerPaymentStatusForm();  
}

checkInCustomerPaymentStatusForm.prototype.GetFormInfo = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the Info of the Screen like Title, Message etc. 
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at checkInCustomerPaymentStatusForm.getFormInfo: The checkInCustomerPaymentStatus Form does not Exist.",
              message     : this.dlgCheckInCustomerPaymentStatus + " The checkInCustomerPaymentStatus Form does not Exist." }
     
    frmInfo = {  sTitle           : this.objPaymentStatusScreen.GetTitle(),
                 sAccountNumber   : this.objPaymentStatusScreen.GetAccountNumber(),
                 sScreenMessage   : this.objPaymentStatusScreen.GetScreenMessage(),
                 sFooterMessage   : this.objPaymentStatusScreen.GetFooterMessage()
              };
      
    return frmInfo;     
  }
  
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
} //GetFormInfo



