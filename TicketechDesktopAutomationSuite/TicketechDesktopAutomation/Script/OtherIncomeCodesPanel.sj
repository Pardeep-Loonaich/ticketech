//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:OtherIncomeCodesPanel
  
  Description: 
  
  This class has methods and properties to perform the OtherIncomeCodes Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function otherIncomeCodesPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: otherIncomeCodesPanel() 
  
  Description: This method will the Instantiate the OtherIncomeCodes Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlOtherIncomeCodes =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelOtherIncomeCodes", 2);
  this.throwError = false; 
    
} //otherIncomeInfoCodePanel

otherIncomeCodesPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the otherIncomeCodesPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlOtherIncomeCodes.Exists;  //Return whether otherIncomeInfoCodePanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


otherIncomeCodesPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if OtherIncomeCodes Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at otherIncomeCodesPanel.Click"+btnName+": The OtherIncomeCodes Panel does not Exist.",
              message     : this.pnlOtherIncomeCodes + " Panel does not Exist." }             
    
    this.pnlOtherIncomeCodes.FindChild(["WndCaption", "Enabled"], [btnName, true], 2).ClickButton();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Click

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating otherIncomeInfoCodePanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new otherIncomeCodesPanel();  
}