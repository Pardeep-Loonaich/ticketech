//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:MainScreen
  
  Description: 
  
  This class has methods and properties to perform the mainScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function mainScreen() { 

/*------------------------------------------------------------------------------- 
  Method: mainScreen() 
  
  Description: This method will the Instantiate the mainScreen Wrapper Helper
--------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnMain =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenMain", 2);
  this.throwError = false; 
    
} //mainScreen

mainScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the main Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnMain.Exists;  //Return whether mainScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

mainScreen.prototype.GetDate = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetDate()
  
  Description : This method returns the current date labelled in the main screen 
  
  Output      : Returns the current date labelled in the main screen 
-------------------------------------------------------------------------------*/  
  this.GetText("labelDate");
      
} //GetDate

mainScreen.prototype.GetTime = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTime()
  
  Description : This method returns the current time labelled in the main screen 
  
  Output      : Returns the current GetTime labelled in the main screen 
-------------------------------------------------------------------------------*/  
  this.GetText("labelTime");
      
} //GetTime

mainScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the main screen 
  
  Output      : Returns the label of the given object in the main screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at mainScreen.Get"+objControlName+": The Main screen does not Exist.",
              message     : this.scrnMain + " Screen does not Exist." }             
    
    return this.scrnMain.WaitWinFormsObject("WinFormsControlName", objControlName, 1000).WndCaption;
    
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
  This method is for instantiating mainScreen() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new mainScreen();  
}