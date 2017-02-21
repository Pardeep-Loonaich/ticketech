//USEUNIT Utility

/**********************************************************************************
            ---------- Class Definition ----------
  Name:ConfirmActionScreen
  
  Description: 
  
  This class has methods and properties to perform the ConfirmActionScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**********************************************************************************/

function confirmActionScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: confirmActionScreen() 
  
  Description: This method will the Instantiate the ConfirmActionScreen Wrapper Helper
-------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnConfirmAction =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenConfirmAction", 3);
  
  this.throwError = false; 
    
} //confirmActionScreen

confirmActionScreen.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the confirmActionScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnConfirmAction.Exists;  //Return whether confirmActionScreen exists or not
  
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at confirmActionScreen.Exists");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

confirmActionScreen.prototype.GetText = function (objControlName) {  

/*-----------------------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the Text displayed in the given field of ConfirmAction screen 
  
  Output      : Returns the Text displayed in the given field of ConfirmAction screen 
------------------------------------------------------------------------------------------------*/  
  try {
    text = null;
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ConfirmActionScreen.Get"+objControlName+": The ConfirmActionScreen does not Exist.",
              message     : this.scrnConfirmAction + "ConfirmActionScreen does not Exist." } 
              
                          
    objText = this.scrnConfirmAction.FindChild("WinFormsControlName",objControlName,3);
              
    if (objText.Exists)          
      text = objText.WndCaption;
    
    return text;
    
  } //End try
  
  catch (exception) {
    TestLog.Message("Exception at confirmActionScreen.GetText "+objControlName);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

confirmActionScreen.prototype.GetTitle = function () {  

/*----------------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the ConfirmAction screen 
  
  Output      : Returns the current Title labelled in the ConfirmAction screen 
-----------------------------------------------------------------------------------------*/  
  return   this.GetText("labelTitle");
  
} //GetTitle 


confirmActionScreen.prototype.GetScreenText = function () {  

/*----------------------------------------------------------------------------------------
  Method      : GetScreenText()
  
  Description : This method returns the Text displayed in the ConfirmAction screen 
  
  Output      : Returns the Text displayed in the ConfirmAction screen 
--------------------------------------------------------------------------------*/  
  return   this.GetText("labelText");
  
} //GetScreenText 


confirmActionScreen.prototype.GetFooterMessage = function () {  

/*---------------------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the message displayed in the footer of ConfirmAction screen 
  
  Output      : Returns the message displayed in the footer of ConfirmAction screen 
---------------------------------------------------------------------------------------------*/  
  return   this.GetText("labelInformation");
      
} //GetFooterMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating confirmActionForm() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new confirmActionScreen();  
}