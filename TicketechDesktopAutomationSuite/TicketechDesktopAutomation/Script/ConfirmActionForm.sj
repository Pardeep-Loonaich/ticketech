//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT BackPanel
//USEUNIT ConfirmActionScreen
//USEUNIT YesNoConfirmActionPanel


/********************************************************************************
            ---------- Class Definition ----------
  Name:ConfirmActionForm
  
  Description: 
  
  This class has methods and properties to perform the ConfirmActionForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************/

function confirmActionForm() { 

/*--------------------------------------------------------------------------- 
  Method: confirmActionForm() 
  
  Description: This method will the Instantiate the confirmActionForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgConfirmAction =  Sys.Process("PosApplication").WaitWinFormsObject("FormConfirmAction", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objConfirmActionScreen = ConfirmActionScreen.New();
  this.objYesNoConfirmActionPanel = YesNoConfirmActionPanel.New();
  this.objBackPanel = BackPanel.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //confirmActionForm

confirmActionForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the confirmActionForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {

    this.dlgConfirmAction =  Sys.Process("PosApplication").WaitWinFormsObject("FormConfirmAction", 3000);
  
    this.objInfoScreen = InformationScreen.New();
    this.objConfirmActionScreen = ConfirmActionScreen.New();
    this.objYesNoConfirmActionPanel = YesNoConfirmActionPanel.New();
    this.objBackPanel = BackPanel.New();
    this.objNavigationPanel = NavigationPanel.New();
        
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at ConfirmActionForm.Refresh");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

confirmActionForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the confirmActionForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgConfirmAction.Exists;  //Return whether confirmActionForm exists or not
  
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at ConfirmActionForm.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

confirmActionForm.prototype.ConfirmYes = function () {  

/*------------------------------------------------------------
  Method      : ConfirmYes()
  
  Description : This method Clicks Yes button  
  
  Output      : Clicks Yes button if ConfirmActionForm Exists
------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ConfirmActionForm.ConfirmYes: The ConfirmActionForm does not Exist.",
              message     : this.dlgConfirmAction + " The ConfirmActionForm does not Exist." }             
    
    this.objYesNoConfirmActionPanel.ClickYes();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at ConfirmActionForm.ConfirmYes");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ConfirmYes

confirmActionForm.prototype.ConfirmNo = function () {  

/*----------------------------------------------------------
  Method      : ConfirmNo()
  
  Description : This method Clicks No button  
  
  Output      : Clicks No button if ConfirmActionForm Exists
-----------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at confirmActionForm.ConfirmYes: The ConfirmActionForm does not Exist.",
              message     : this.dlgConfirmAction + " The ConfirmActionForm does not Exist." }             
    
    this.objYesNoConfirmActionPanel.ClickNo();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
	TestLog.Message("Exception at ConfirmActionForm.ConfirmNo");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ConfirmNo

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating confirmActionForm() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new confirmActionForm();  
}

confirmActionForm.prototype.GetFormInfo = function(){

/*--------------------------------------------------------------------- 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the Info of the Screen like Title, Message. 
----------------------------------------------------------------------*/
  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ConfirmActionForm.GetFormInfo: The ConfirmAction Form does not Exist.",
              message     : this.dlgConfirmAction + " The ConfirmAction Form does not Exist." }
     
    frmInfo = {  Title          : this.objConfirmActionScreen.GetTitle(),
                 ScreenText     : this.objConfirmActionScreen.GetScreenText(),
                 FooterMessage  : this.objConfirmActionScreen.GetFooterMessage()
              };
      
    return frmInfo;
      
  }
  catch(exception) {
	TestLog.Message("Exception at ConfirmActionForm.GetFormInfo");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }

}