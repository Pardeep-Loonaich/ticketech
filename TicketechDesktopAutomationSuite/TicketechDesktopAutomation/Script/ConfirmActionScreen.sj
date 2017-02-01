//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:ConfirmActionScreen
  
  Description: 
  
  This class has methods and properties to perform the ConfirmActionScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function confirmActionScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: confirmActionScreen() 
  
  Description: This method will the Instantiate the ConfirmActionScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnConfirmAction =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenConfirmAction", 3);
  
  this.throwError = false; 
    
} //confirmActionScreen

confirmActionScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the confirmActionScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnConfirmAction.Exists;  //Return whether confirmActionScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

confirmActionScreen.prototype.GetMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetMessage()
  
  Description : This method returns the message displayed in the ConfirmAction screen 
  
  Output      : Returns the message displayed in the ConfirmAction screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ConfirmActionScreen.GetMessage: The Info screen does not Exist.",
              message     : this.scrnConfirmAction + " Info does not Exist." }             
    
    return this.scrnConfirmAction.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetMessage

confirmActionScreen.prototype.GetScreenText = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetScreenText()
  
  Description : This method returns the Text displayed in the ConfirmAction screen 
  
  Output      : Returns the Text displayed in the ConfirmAction screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ConfirmActionScreen.GetScreenText: The Info screen does not Exist.",
              message     : this.scrnConfirmAction + " Info does not Exist." }             
    
    return this.scrnConfirmAction.FindChild("WinFormsControlName","labelText",3).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetScreenText

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating confirmActionForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new confirmActionScreen();  
}