//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:RushDataScreen
  
  Description: 
  
  This class has methods and properties to perform the RushDataScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function rushDataScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: rushDataScreen() 
  
  Description: This method will the Instantiate the RushDataScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnRushData =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenRushData",3);
  
  this.throwError = false; 
    
} //rushDataScreen

rushDataScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the RushDataScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnRushData.Exists;  //Return whether RushDataScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

rushDataScreen.prototype.GetText = function (objControlName) {  

/*------------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the Text displayed in the given field of RushData Screen 
  
  Output      : Returns the Text displayed in the given field of RushData Screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at RushDataScreen.GetText"+objControlName+": The RushDataScreen does not Exist.",
              message     : this.scrnRushData + "RushDataScreen does not Exist." }             
    
    return this.scrnRushData.WinFormsObject(objControlName).WinFormsObject("maskedTextBoxInfo").Text;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText


rushDataScreen.prototype.GetConfirmColor = function () {  

/*--------------------------------------------------------------------------------------
  Method      : GetConfirmColor()
  
  Description : This method returns the current confirmation in ColorTextBox 
  
  Output      : Returns the current Tconfirmation in ColorTextBox in the RushData Screen 
--------------------------------------------------------------------------------------*/ 

  return   this.GetText("selectableTextBoxColor");
  
} //GetConfirmColor

rushDataScreen.prototype.GetConfirmMake= function () {  

/*--------------------------------------------------------------------------------------
  Method      : GetConfirmMake()
  
  Description : This method returns the current confirmation in MakeTextBox 
  
  Output      : Returns the current confirmation in MakeTextBox in the RushData Screen 
--------------------------------------------------------------------------------------*/ 

  return   this.GetText("selectableTextBoxMake");
  
} //GetConfirmMake

rushDataScreen.prototype.GetConfirmPlate = function () {  

/*--------------------------------------------------------------------------------------
  Method      : GetConfirmPlate()
  
  Description : This method returns the current confirmation in PlateTextBox 
  
  Output      : Returns the current confirmation in PlateTextBox in the RushData Screen 
--------------------------------------------------------------------------------------*/ 

  return   this.GetText("selectableTextBoxPlate");
  
} //GetConfirmPlate


function New() {

/*--------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating RushDataScreen() class from other units of the project. 
----------------------------------------------------------------------------------------*/
  return new rushDataScreen();  
}

  