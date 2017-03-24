//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT YesNoConfirmActionPanel
//USEUNIT RushDataScreen

/************************************************************************************
            ---------- Class Definition ----------
  Name:RushSelectionInfoForm
  
  Description: 
  
  This class has methods and properties to perform the RushSelectionInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
************************************************************************************/

function rushSelectionInfoForm() { 

/*-------------------------------------------------------------------------------
  Method: rushSelectionInfoForm() 
  
  Description: This method will the Instantiate the RushSelectionInfoForm Wrapper
-------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgRushSelectionInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormRushSelectionInfo*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objYesNoConfirmActionPanel  = YesNoConfirmActionPanel.New();
  this.objRushDataScreen  = RushDataScreen.New();
  
  
  this.throwError = false; 
    
} //RushSelectionInfoForm

rushSelectionInfoForm.prototype.Refresh = function () {  

/*----------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the RushSelectionInfoForm Wrapper   
----------------------------------------------------------------------------------------*/  
  try {
    
    this.dlgRushSelectionInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormRushSelectionInfo*", 3000); 
  
    this.objInfoScreen = InformationScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objYesNoConfirmActionPanel  = YesNoConfirmActionPanel.New();
    this.objRushDataScreen  = RushDataScreen.New();  
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
  } //Refresh
  
rushSelectionInfoForm.prototype.Exists = function () {  

/*----------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the rushSelectionInfo form.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgRushSelectionInfo.Exists;  //Return whether rushSelectionInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists
  
rushSelectionInfoForm.prototype.SetRushSelectionRequiredField = function (eConfirmData) {  

/*---------------------------------------------------------------------------------------------------
  Method      : SetRushSelectionRequiredField()
  
  Description : This method set a field as required or not during Rush Selection  
  
  Output      : Set a field as required or not during Rush selection, if rushSelectionInfoForm Exists
---------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at rushSelectionInfoForm.SetRushSelectionRequiredField: The rushSelectionInfoForm does not Exist.",
              message     : this.dlgRushSelectionInfo + " The rushSelectionInfoForm does not Exist." }             
    
    
    if(aqString.ToUpper(eConfirmData.Plate) === "YES")
      this.objYesNoConfirmActionPanel.ClickYes();
    else
      this.objYesNoConfirmActionPanel.ClickNo();
    
    aqUtils.Delay(1000);
    
    this.Refresh();
    aqUtils.Delay(1000);
    
    
    if(aqString.ToUpper(eConfirmData.Color) === "YES")
      this.objYesNoConfirmActionPanel.ClickYes();
    else
      this.objYesNoConfirmActionPanel.ClickNo();
    
    aqUtils.Delay(1000);
    
    this.Refresh();
    aqUtils.Delay(1000);
    
    
    if(aqString.ToUpper(eConfirmData.Make) === "YES")
      this.objYesNoConfirmActionPanel.ClickYes();
    else
      this.objYesNoConfirmActionPanel.ClickNo();
    
    aqUtils.Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetRushSelectionRequiredField



function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating rushSelectionInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new rushSelectionInfoForm();  
}