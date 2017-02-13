//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:FingerPrintScreen
  
  Description: 
  
  This class has methods and properties to perform the FingerPrintScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function fingerPrintScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: fingerPrintScreen() 
  
  Description: This method will the Instantiate the FingerPrintScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnFingerPrint =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenFingerPrint",3);
  
  this.throwError = false; 
    
} //fingerPrintScreen

fingerPrintScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the FingerPrintScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnFingerPrint.Exists;  //Return whether FingerPrintScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

fingerPrintScreen.prototype.GetText = function (objControlName) {  

/*------------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the Text displayed in the given field of FingerPrint screen 
  
  Output      : Returns the Text displayed in the given field of FingerPrint screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at FingerPrintScreen.GetText"+objControlName+": The FingerPrintScreen does not Exist.",
              message     : this.scrnFingerPrint + "FingerPrintScreen does not Exist." }             
    
    return this.scrnFingerPrint.FindChild("WinFormsControlName",objControlName,3).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

fingerPrintScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the FingerPrint screen 
  
  Output      : Returns the current Title labelled in the FingerPrint screen 
-------------------------------------------------------------------------------*/ 
  Log.Message(this.GetText("labelTitle")); 
  return   this.GetText("labelTitle");
  
} //GetTitle 

fingerPrintScreen.prototype.GetScreenText = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetScreenText()
  
  Description : This method returns the current ScreenText in the FingerPrint screen 
  
  Output      : Returns the current ScreenText in the FingerPrint screen 
-------------------------------------------------------------------------------*/ 
  Log.Message(this.GetText("labelText")); 
  return   this.GetText("labelText");
  
} //GetScreenText 

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating FingerPrintScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/
  return new fingerPrintScreen();  
}

  