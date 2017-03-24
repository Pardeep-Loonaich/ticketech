//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT OtherIncomeCodesPanel
//USEUNIT OtherIncomeScreen
//USEUNIT Utility

/*************************************************************************
            ---------- Class Definition ----------
  Name:OtherIncomeInfoCodeForm
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomeInfoCodeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function otherIncomeInfoCodeForm() { 

/*-------------------------------------------------------------------------- 
  Method: otherIncomeInfoCodeForm() 
  
  Description: This method will the Instantiate the otherIncomeInfoCodeForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgOtherIncomeInfoCode =  Sys.Process("PosApplication").WaitWinFormsObject("FormOtherIncomeInfoCode", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objOtherIncomeScreen = OtherIncomeScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objOtherIncomeCodesPanel = OtherIncomeCodesPanel.New();
  
  this.throwError = false; 
    
} //otherIncomeInfoCodeForm

otherIncomeInfoCodeForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the otherIncomeInfoCodeForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgOtherIncomeInfoCode =  Sys.Process("PosApplication").WaitWinFormsObject("FormOtherIncomeInfoCode", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objOtherIncomeScreen = OtherIncomeScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objOtherIncomeCodesPanel = OtherIncomeCodesPanel.New();
       
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

otherIncomeInfoCodeForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomeInfoCodeForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgOtherIncomeInfoCode.Exists;  //Return whether otherIncomeInfoCodeForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


otherIncomeInfoCodeForm.prototype.ProvideDescription= function (sDescription)   {  

/*-----------------------------------------------------------------
  Method      : provideDescription()
  
  Description : This method will enter description.  
     
-----------------------------------------------------------------*/ 
try
{ 

  this.objOtherIncomeScreen.SetDescription(sDescription);
  
  this.objNavigationPanel.ClickEnter();
  Delay(1000);

  } // End Try
  
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
    
  } //End catch 
   
} //provideDescription

otherIncomeInfoCodeForm.prototype.ClickOtherIncome= function () {  

/*--------------------------------------------------------------------------
  Method      : ClickOtherIncome()
  
  Description : This method Clicks Other Income button  
  
  Output      : Clicks Other Income button if OtherIncomeInfoCodeForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeInfoCodeForm.ClickOtherIncome: The otherIncomeInfoCodeForm does not Exist.",
              message     : this.dlgOtherIncomeInfoCode + " The otherIncomeInfoCodeForm does not Exist." }             
    
    this.objOtherIncomeCodesPanel.Click("OTHER INCOME");
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickOtherIncome


otherIncomeInfoCodeForm.prototype.SubmitForm= function () {  

/*--------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks Enter button  
  
  Output      : Clicks Enter button if OtherIncomeInfoCodeForm Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeInfoCodeForm.SubmitForm: The otherIncomeInfoCodeForm does not Exist.",
              message     : this.dlgOtherIncomeInfoCode + " The otherIncomeInfoCodeForm does not Exist." }             
    
    this.objNavigationPanel.Click("ENTER");
    Delay(1000);
    
    return this.objOtherIncomeScreen.GetErrorMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitForm

otherIncomeInfoCodeForm.prototype.GetFormInfo = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the Info of the Screen like Title, Message etc. 
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeInfoCodeForm.getFormInfo: The otherIncomeInfoCodeForm does not Exist.",
              message     : this.dlgOtherIncomeInfoCode + " The otherIncomeInfoCodeForm does not Exist." }
     
    frmInfo = {  
                 sFooterMessage  : this.objOtherIncomeScreen.GetErrorMessage()
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
  This method is for instantiating otherIncomeInfoCodeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new otherIncomeInfoCodeForm();  
}
