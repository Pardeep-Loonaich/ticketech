//USEUNIT Utility

/*******************************************************************
            ---------- Class Definition ----------

  Name:OptionsListPanel
  
  Description: 
  
  This class has methods and properties to perform the Options List Panel objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function optionsListPanel() { 

/*-------------------------------------------------------------------------------------- 
  Method: optionsListPanel() 
  
  Description: This method will the Instantiate the Options List Panel Wrapper Helper
--------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.pnlOptionsList =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "PanelOptionsList", 3);
  this.throwError = false; 
    
} //optionsListPanel

optionsListPanel.prototype.Exists = function () {  

/*-----------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the optionsListPanel.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.pnlOptionsList.Exists;  //Return whether optionsListPanel exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

optionsListPanel.prototype.ClickAll = function () {  

/*--------------------------------------------------------------------------
  Method      : ClickAll()
  
  Description : This method Clicks All button  
  
  Output      : Click on All button if Options List Panel Exists
--------------------------------------------------------------------------*/  
  this.Click("All")
  
} //ClickAll


optionsListPanel.prototype.Click = function (btnName) {  

/*--------------------------------------------------------------------------
  Method      : Click()
  
  Description : This method Clicks the given button  
  
  Output      : Click on the given button if Options List Panel Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at optionsListPanel.Click"+btnName+": The Options List Panel does not Exist.",
              message     : this.pnlOptionsList + " Panel does not Exist." }             
    
    this.pnlOptionsList.FindChild(["Value", "Visible"], [btnName, true], 2).ClickButton();
    
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
  This method is for instantiating optionsListPanel() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new optionsListPanel();  
}