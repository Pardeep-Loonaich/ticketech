//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:MenuScreen
  
  Description: 
  
  This class has methods and properties to perform the MenuScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function menuScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: menuScreen() 
  
  Description: This method will Instantiate the MenuScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenMenu", 3);
  
  this.throwError = false; 
    
} //menuScreen

menuScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the menuScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnMenu.Exists;  //Return whether menuScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at menuScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


menuScreen.prototype.ConfirmManualTicketEntryMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : ConfirmManualTicketEntryMessage()
  
  Description : This method returns true if manual ticket entry message exists on the menu screen 
  
  Output      : Returns true/false based on manual ticket entry message exists on the menu screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    flag = false;
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at MenuScreen.ConfirmManualTicketEntryMessage: The Menu screen does not Exist.",
              message     : this.scrnMenu + " Menu screen does not Exist." }             
    
    if(this.scrnMenu.FindChild("WinFormsControlName","labelManualEntry",2).Exists)
      flag = true;
    
    return flag;   
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ConfirmManualTicketEntryMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating menuScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new menuScreen();  
}