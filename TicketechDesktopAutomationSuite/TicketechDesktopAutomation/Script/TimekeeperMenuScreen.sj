//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:TimekeeperMenuScreen
  
  Description: 
  
  This class has methods and properties to perform the timekeeperMenuScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function timekeeperMenuScreen() { 

/*------------------------------------------------------------------------------- 
  Method: timekeeperMenuScreen() 
  
  Description: This method will Instantiate the timekeeperMenuScreen Wrapper Helper
--------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnTimekeeperMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenTimekeeperMenu", 2);
  this.throwError = false; 
    
} //timekeeperMenuScreen

timekeeperMenuScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the timekeeperMenu Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnTimekeeperMenu.Exists;  //Return whether timekeeperMenuScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

timekeeperMenuScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the timekeeperMenu screen 
  
  Output      : Returns the current Title labelled in the timekeeperMenu screen 
-------------------------------------------------------------------------------*/  
  return   this.GetText("labelTitle");
      
} //GetTitle

timekeeperMenuScreen.prototype.GetFooterMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the current FooterMessage in the timekeeperMenu screen 
  
  Output      : Returns the current FooterMessage in the timekeeperMenu screen 
-------------------------------------------------------------------------------*/  
  return this.GetText("labelInformation");
      
} //GetFooterMessage

timekeeperMenuScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the timekeeperMenu screen 
  
  Output      : Returns the label of the given object in the timekeeperMenu screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at timekeeperMenuScreen.Get"+objControlName+": The TimekeeperMenu screen does not Exist.",
              message     : this.scrnTimekeeperMenu + " Screen does not Exist." }             
    
    return this.scrnTimekeeperMenu.FindChild("WinFormsControlName", objControlName, 2).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating timekeeperMenuScreen() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new timekeeperMenuScreen();  
}
