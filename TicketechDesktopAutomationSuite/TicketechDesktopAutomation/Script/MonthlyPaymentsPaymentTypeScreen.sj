//USEUNIT Utility

/******************************************************************************************
            ---------- Class Definition ----------
  Name:MonthlyPaymentsPaymentTypeScreen
  
  Description: 
  
  This class has methods and properties to perform the MonthlyPaymentsPaymentTypeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************/

function monthlyPaymentsPaymentTypeScreen() { 

/*--------------------------------------------------------------------------------------------- 
  Method: monthlyPaymentsPaymentTypeScreen() 
  
  Description: This method will Instantiate the MonthlyPaymentsPaymentTypeScreen Wrapper Helper
----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnMonthlyPayType =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenMonthlyPaymentsPaymentType", 2);
  
  this.throwError = false; 
    
} //monthlyPaymentsPaymentTypeScreen

monthlyPaymentsPaymentTypeScreen.prototype.Exists = function () {  

/*----------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the MonthlyPaymentsPaymentTypeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnMonthlyPayType.Exists;  //Return whether MonthlyPaymentsPaymentTypeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

monthlyPaymentsPaymentTypeScreen.prototype.SetPayAmount = function (iPayAmount) {  

/*-------------------------------------------------------------------------------------------------------
  Method      : SetPayAmount()
  
  Description : This method enters the Payment Amount in the given field of MonthlyPaymentsPaymentType screen
  
  Output      : Enters the payment Amount in the given field of MonthlyPaymentsPaymentType screen
-------------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsPaymentTypeScreen.SetPayAmount: The MonthlyPaymentsPaymentType screen does not Exist.",
              message     : this.scrnMonthlyPayType + " Screen does not Exist." }             
    
    if (iPayAmount !== undefined && iPayAmount !== null)
      this.scrnMonthlyPayType.FindChild("Caption", "PAYMENT AMOUNT",2).FindChild("WinFormsControlName","maskedTextBoxInfo",1).Keys(iPayAmount);
         
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPayAmount


monthlyPaymentsPaymentTypeScreen.prototype.GetMessage = function () {  

/*-----------------------------------------------------------------------------------------
  Method      : GetMessage()
  
  Description : This method returns the message displayed in the MonthlyPaymentsPaymentType screen 
  
  Output      : Returns the the message displayed in the MonthlyPaymentsPaymentType screen 
------------------------------------------------------------------------------------------*/  
  try {
    Message = null;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsPaymentTypeScreen.GetMessage: The MonthlyPaymentsPaymentType screen does not Exist.",
              message     : this.scrnMonthlyPayType + " Info does not Exist." }  
    
    objMessage = this.scrnMonthlyPayType.FindChild("WinFormsControlName","labelInformation",3); 
             
    if(objMessage.Exists)
      Message = objMessage.WndCaption;
    
    return Message;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetMessage


monthlyPaymentsPaymentTypeScreen.prototype.GetCustomerName = function () {  

/*-----------------------------------------------------------------------------------------
  Method      : GetCustomerName()
  
  Description : This method returns the CustoerName displayed in the MonthlyPaymentsPaymentType screen 
  
  Output      : Returns the the CustomerName displayed in the MonthlyPaymentsPaymentType screen 
------------------------------------------------------------------------------------------*/  
  try {
    sCustomerName = null;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsPaymentTypeScreen.GetCustomerName: The MonthlyPaymentsPaymentType screen does not Exist.",
              message     : this.scrnMonthlyPayType + " Screen does not Exist." }  
    
    objCustomerName = this.scrnMonthlyPayType.FindChild("WinFormsControlName","labelText",3); 
             
    if(objCustomerName.Exists)
      sCustomerName = objCustomerName.WndCaption;
    
    return sCustomerName;
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch    
} //GetCustomerName


monthlyPaymentsPaymentTypeScreen.prototype.GetPayDetail = function (sCaption) {  

/*-----------------------------------------------------------------------------------------
  Method      : GetDueAmount()
  
  Description : This method returns the Payment Data displayed in the MonthlyPaymentsPaymentType screen 
  
  Output      : Returns the the Payment Data displayed in the MonthlyPaymentsPaymentType screen 
------------------------------------------------------------------------------------------*/  
  try {
    sPayData = null;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MonthlyPaymentsPaymentTypeScreen.GetPayDetail: The MonthlyPaymentsPaymentType screen does not Exist.",
              message     : this.scrnMonthlyPayType + " Screen does not Exist." }  
    
    objPayData = this.scrnMonthlyPayType.FindChild("Caption",sCaption,2).FindChild("WinFormsControlName","maskedTextBoxInfo",0);
             
    if(objPayData.Exists)
      sPayData = objPayData.WndCaption;
    
    return sPayData;
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch     
} //GetPayDetail

function New() {

/*------------------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating MonthlyPaymentsPaymentTypeScreen() class from other units of the project. 
------------------------------------------------------------------------------------------------------*/

  return new monthlyPaymentsPaymentTypeScreen();  
}