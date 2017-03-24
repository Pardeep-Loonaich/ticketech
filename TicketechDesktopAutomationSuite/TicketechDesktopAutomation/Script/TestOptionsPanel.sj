//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:testOptionsPanel
  
  Description: 
  
  This class has methods and properties to perform the testOptionsPanel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function testOptionsPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: testOptionsPanel() 
  
  Description: This method will the Instantiate the testOptionsPanel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnltestOptions =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PaneltestOptions", 2);
  this.throwError = false; 
    
} //testOptionsPanel

testOptionsPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the testOptionsPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnltestOptions.Exists;  //Return whether testOptionsPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists
testOptionsPanel.prototype.ClickChangeAmount = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickChangeAmount()
  
  Description : This method Clicks the Change Amount button  
  
  Output      : Click on Change Amount if testOptionsPanel Exists
--------------------------------------------------------------------------*/  
  this.Click("CHANGE AMOUNT")
  
} //ClickChangeAmount

testOptionsPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if testOptionsPanel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at testOptionsPanel.Click"+btnName+": The testOptionsPanel does not Exist.",
              message     : this.pnltestOptions + " Panel does not Exist." }             
    
    this.pnltestOptions.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
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
  This method is for instantiating testOptionsPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new testOptionsPanel();  
}