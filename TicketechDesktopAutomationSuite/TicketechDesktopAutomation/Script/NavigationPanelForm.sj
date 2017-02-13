//USEUNIT Utility
//USEUNIT NavigationPanel

/**************************************************************************
            ---------- Class Definition ----------
  Name:NavigationPanelForm
  
  Description: 
  
  This class has methods and properties to perform the NavigationPanelForm Form objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function navigationPanelForm() { 

/*--------------------------------------------------------------------------- 
  Method: navigationPanelForm() 
  
  Description: This method will the Instantiate the navigationPanelForm Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlNavigationForm =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelNavigation", 2);
  this.objNavigationPanel = NavigationPanel.New();
  this.throwError = false; 
    
} //navigationPanelForm

navigationPanelForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the navigationPanelForm.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlNavigationForm.Exists;  //Return whether navigationPanelForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

navigationPanelForm.prototype.Click = function (btnName) {  

/*-----------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if navigationPanelForm Form Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at navigationPanelForm.Click"+btnName+": The NavigationPanelForm Form does not Exist.",
              message     : this.pnlNavigationForm + " Form does not Exist." }             
    
    this.pnlNavigationForm.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

navigationPanelForm.prototype.ClickEnter = function () {  

/*-----------------------------------------------------------------
  Method      : ClickEnter()
  
  Description : This method Clicks the Enter button  
  
  Output      : Click on Enter button if NavigationPanelForm form Exists
-----------------------------------------------------------------*/  
  this.objNavigationPanel.ClickEnter();
      
} //ClickEnter

navigationPanelForm.prototype.ClickCancel = function () {  

/*-----------------------------------------------------------------
  Method      : ClickCancel()
  
  Description : This method Clicks the Cancel button  
  
  Output      : Click on Cancel button if NavigationPanelForm from Exists
-----------------------------------------------------------------*/  
  this.objNavigationPanel.ClickCancel();
      
} //ClickCancel

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating NavigationPanelForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new navigationPanelForm();  
}