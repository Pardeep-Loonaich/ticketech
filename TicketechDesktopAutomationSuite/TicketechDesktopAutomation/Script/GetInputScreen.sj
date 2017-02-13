//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:GetInputScreen
  
  Description: 
  
  This class has methods and properties to perform the GetInputScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function getInputScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: getInputScreen() 
  
  Description: This method will the Instantiate the GetInputScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnGetInput =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenGetInput", 3);
  
  this.throwError = false; 
    
} //getInputScreen

getInputScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the getInputScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnGetInput.Exists;  //Return whether getInputScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

getInputScreen.prototype.SetBarCode = function (sBarCode) {  

/*-------------------------------------------------------------------------------
  Method      : SetBarCode()
  
  Description : This method enters the Code in the Employee Code screen
  
  Output      : Enters the BarCode  in the Set Input screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at getInputScreen.SetBarCode: The Barcode Code Exist.",
              message     : this.scrnGetInput + " Screen Exist." }             
    
    if (sBarCode !== undefined && sBarCode !== null)
      //this.scrnGetInput.FindChild("Caption","BARCODE",1).FindChild("WinFormsControlName", "labelTextBox", 1).Keys(sBarCode);
      Sys.Process("PosApplication").WinFormsObject("FormReservationInfo").WinFormsObject("ScreenGetInput").WinFormsObject("selectableTextBoxInput").WinFormsObject("labelTextBox").Keys(sBarCode);
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetBarCode

getInputScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the barcode getInput screen 
  
  Output      : Returns the error message displayed in the Get Input screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at GetInputScreen.GetErrorMessage: The GetInput screen does not Exist.",
              message     : this.scrnGetInput + " GetInput screen does not Exist." }             
    
    return this.scrnGetInput.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating getInputScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new getInputScreen();  
}