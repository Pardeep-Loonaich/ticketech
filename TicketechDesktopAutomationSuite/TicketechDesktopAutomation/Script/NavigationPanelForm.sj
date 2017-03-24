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
  this.objNavigationPanel = NavigationPanel.New();
  this.throwError = false; 
    
} //navigationPanelForm

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