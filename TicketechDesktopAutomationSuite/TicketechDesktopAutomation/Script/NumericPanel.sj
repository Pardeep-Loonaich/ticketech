//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:NumericPanel
  
  Description: 
  
  This class has methods and properties to perform the Numeric Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function numericPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: numericPanel() 
  
  Description: This method will the Instantiate the Numeric Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlNumeric =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelNumeric", 2);
  this.throwError = false; 
    
} //numericPanel

numericPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the NumericPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlNumeric.Exists;  //Return whether NumericPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating numericPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new numericPanel();  
}