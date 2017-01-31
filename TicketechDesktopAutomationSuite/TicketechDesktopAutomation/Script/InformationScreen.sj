//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:InformationScreen
  
  Description: 
  
  This class has methods and properties to perform the InformationScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function informationScreen() { 

/*----------------------------------------------------------------------------------- 
  Method: informationScreen() 
  
  Description: This method will the Instantiate the informationScreen Wrapper Helper
-----------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenInformation", 2000);
  this.throwError = false; 
    
} //informationScreen

informationScreen.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the Information Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnInfo.Exists;  //Return whether mainScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

function New() {

/*------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating informationScreen() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new informationScreen();  
}