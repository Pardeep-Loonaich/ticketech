//USEUNIT Utility

/*************************************************************************************************
            ---------- Class Definition ----------
  Name:EmployeePrintTimecardPreviewScreen
  
  Description: 
  
  This class has methods and properties to perform the employeePrintTimecardPreviewScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
************************************************************************************************/

function employeePrintTimecardPreviewScreen() { 

/*----------------------------------------------------------------------------------------------- 
  Method: employeePrintTimecardPreviewScreen() 
  
  Description: This method will Instantiate the employeePrintTimecardPreviewScreen Wrapper Helper
-----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmpPrintTCPreview =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeePrintTimecardPreview", 2);
  this.throwError = false; 
    
} //employeePrintTimecardPreviewScreen

employeePrintTimecardPreviewScreen.prototype.Exists = function () {  

/*-----------------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeePrintTimecardPreview Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-----------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmpPrintTCPreview.Exists;  //Return whether employeePrintTimecardPreviewScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeePrintTimecardPreviewScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the employeePrintTimecardPreview screen 
  
  Output      : Returns the current Title labelled in the employeePrintTimecardPreview screen 
-------------------------------------------------------------------------------*/  
  return   this.GetText("labelTitle");
      
} //GetTitle

employeePrintTimecardPreviewScreen.prototype.GetFooterMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the current FooterMessage in the employeePrintTimecardPreview screen 
  
  Output      : Returns the current FooterMessage in the employeePrintTimecardPreview screen 
-------------------------------------------------------------------------------*/  
  return this.GetText("labelInformation");
      
} //GetFooterMessage

employeePrintTimecardPreviewScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the employeePrintTimecardPreview screen 
  
  Output      : Returns the label of the given object in the employeePrintTimecardPreview screen 
-------------------------------------------------------------------------------*/  
  try {
    
    sText = null;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeePrintTimecardPreviewScreen.Get"+objControlName+": The EmployeePrintTimecardPreview screen does not Exist.",
              message     : this.scrnEmpPrintTCPreview + " Screen does not Exist." }   
                        
    objText = this.scrnEmpPrintTCPreview.FindChild("WinFormsControlName", objControlName, 2);
    
    if (objText.Exists) 
      sText = objText.WndCaption;
    
    return sText;
    
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
  This method is for instantiating employeePrintTimecardPreviewScreen() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeePrintTimecardPreviewScreen();  
}
