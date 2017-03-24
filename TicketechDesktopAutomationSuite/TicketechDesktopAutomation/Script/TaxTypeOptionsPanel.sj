//USEUNIT Utility

/**********************************************************************************
            ---------- Class Definition ----------
  Name:TaxTypeOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the TaxTypeOptions panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function taxTypeOptionsPanel() { 

/*------------------------------------------------------------------------------------ 
  Method: taxTypeOptionsPanel() 
  
  Description: This method will the Instantiate the taxTypeOptionsPanel Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlTaxTypeOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelTaxTypeOptions", 2);
  this.throwError = false; 
    
} //taxTypeOptionsPanel

taxTypeOptionsPanel.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the taxTypeOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlTaxTypeOptions.Exists;  //Return whether taxTypeOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

taxTypeOptionsPanel.prototype.Click = function (btnName) {  

/*----------------------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the required button in the parameter  
  
  Output      : Clicks the required button in the parameter if TaxTypeOptions Panel Exists
----------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at taxTypeOptionsPanel.Click"+btnName+": The TaxTypeOptions Panel does not Exist.",
              message     : this.pnlTaxTypeOptions + " Panel does not Exist." }             
    
    this.pnlTaxTypeOptions.WaitWinFormsObject("ScreenButton", btnName, 1000).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

taxTypeOptionsPanel.prototype.ClickExemption = function () {  

/*----------------------------------------------------------------------
  Method      : ClickExemption()
  
  Description : This method Clicks the Exemption button  
  
  Output      : Click on Exemption button if TaxTypeOptions Panel Exists
----------------------------------------------------------------------*/  
  this.Click("EXEMPTION");
      
} //ClickExemption

taxTypeOptionsPanel.prototype.ClickFullTax = function () {  

/*--------------------------------------------------------------------
  Method      : ClickFullTax()
  
  Description : This method Clicks the FullTax button  
  
  Output      : Click on FullTax button if TaxTypeOptions Panel Exists
--------------------------------------------------------------------*/  
  this.Click("FULL TAX");
      
} //ClickFullTax

function New() {

/*--------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating taxTypeOptionsPanel() class from other units of the project. 
---------------------------------------------------------------------------------------------*/

  return new taxTypeOptionsPanel();  
}