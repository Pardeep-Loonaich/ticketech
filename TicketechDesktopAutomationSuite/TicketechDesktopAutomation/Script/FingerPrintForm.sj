//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT FingerPrintScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:FingerPrintForm
  
  Description: 
  
  This class has methods and properties to perform the FingerPrintForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function fingerPrintForm() { 

/*-------------------------------------------------------------------------- 
  Method: fingerPrintForm() 
  
  Description: This method will the Instantiate the FingerPrintForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgFingerPrint =  Sys.Process("PosApplication").WaitWinFormsObject("FormFingerPrint", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.fingerPrintScreen = FingerPrintScreen.New();
  this.navigationPanel = NavigationPanel.New();
  
  this.sTitle = this.fingerPrintScreen.GetTitle();
  
  this.throwError = false; 
    
} //FingerPrintForm

fingerPrintForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the FingerPrintForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.dlgFingerPrint =  Sys.Process("PosApplication").WaitWinFormsObject("FormFingerPrint", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.fingerPrintScreen = FingerPrintScreen.New();
    this.navigationPanel = NavigationPanel.New();
    
    this.sTitle = this.fingerPrintScreen.GetTitle();
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
  
  } //Refresh
  

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating fingerPrintForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new fingerPrintForm();  
}