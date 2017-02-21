//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:DateTimeScreen
  
  Description: 
  
  This class has methods and properties to perform the DateTimeScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function dateTimeScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: dateTimeScreen() 
  
  Description: This method will the Instantiate the DateTimeScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnDateTime =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenDateTime", 3);
  
  this.throwError = false; 
    
} //dateTimeScreen

dateTimeScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the dateTimeScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnDateTime.Exists;  //Return whether dateTimeScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

dateTimeScreen.prototype.EnterDate = function (iDate) {  

/*-------------------------------------------------------------------------------
  Method      : EnterDate()
  
  Description : This method enters the Date in the Date Time screen
  
  Output      : Enters the Date in the Date Time screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at dateTimeScree.EnterDate: The Date Time screen Exist.",
              message     : this.scrnDateTime + " Screen Exist." }             
    
    if (iDate !== undefined && iDate !== null)
      Sys.Process("PosApplication").WinFormsObject("FormManualDateInformationDate").WinFormsObject("ScreenDateTime").WinFormsObject("selectableTextBoxDate").WinFormsObject("maskedTextBoxInfo").Clear();      
      Sys.Process("PosApplication").WinFormsObject("FormManualDateInformationDate").WinFormsObject("ScreenDateTime").WinFormsObject("selectableTextBoxDate").WinFormsObject("maskedTextBoxInfo").Keys(iDate);
      Delay(1000);
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterDate

dateTimeScreen.prototype.EnterTime = function (iTime) {  

/*-------------------------------------------------------------------------------
  Method      : EnterTime()
  
  Description : This method enters the Time in the Date Time screen
  
  Output      : Enters the Time in the Date Time screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at dateTimeScree.EnterTime: The Date Time screen Exist.",
              message     : this.scrnDateTime + " Screen Exist." }             
    
    if (iTime !== undefined && iTime !== null)      
      Sys.Process("PosApplication").WinFormsObject("FormManualDateInformationTime").WinFormsObject("ScreenDateTime").WinFormsObject("selectableTextBoxTime").WinFormsObject("labelTextBox").Keys(iTime);
      Delay(1000);
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterTime



function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating dateTimeScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new dateTimeScreen();  
}