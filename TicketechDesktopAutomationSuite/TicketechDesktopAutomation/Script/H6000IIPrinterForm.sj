//USEUNIT Utility



/*************************************************************************
            ---------- Class Definition ----------
  Name:H6000IIPrinterForm
  
  Description: 
  
  This class has methods and properties to perform the H6000IIPrinterForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function h6000IIPrinterForm() { 

/*--------------------------------------------------------------------- 
  Method: h6000IIPrinterForm() 
  
  Description: This method will Instantiate the h6000IIPrinterForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  //this.dlgH6000IIPrinterForm = Sys.Process("PosApplication").FindChildEx(["WndCaption","Index"],["Printer Status", 1], 2, true, 30000); 
  this.dlgH6000IIPrinterForm = Sys.Process("PosApplication").WaitWindow("WindowsForms10.Window.8*","Printer Status", 1,30000);
  
  this.windowTitle = this.dlgH6000IIPrinterForm.WndCaption;
  this.throwError = false; 
    
} //h6000IIPrinterForm


h6000IIPrinterForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the h6000IIPrinterForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgH6000IIPrinterForm.Exists;  //Return whether h6000IIPrinterForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

h6000IIPrinterForm.prototype.ClickRetry = function () {  

/*--------------------------------------------------------------
  Method      : ClickRetry()
  
  Description : This method Clicks Retry button  
  
  Output      : Clicks Retry button if h6000IIPrinterForm Exists
--------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at h6000IIPrinterForm.ClickRetry: The h6000IIPrinterForm does not Exist.",
              message     : this.dlgH6000IIPrinterForm + " The h6000IIPrinterForm does not Exist." }             
    
    this.dlgH6000IIPrinterForm.FindChildEX("WndCaption","Retry",1,1000).ClickButton();            
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickRetry

h6000IIPrinterForm.prototype.ClickCancel = function () {  

/*---------------------------------------------------------------
  Method      : ClickCancel()
  
  Description : This method Clicks Cancel button  
  
  Output      : Clicks Cancel button if h6000IIPrinterForm Exists
---------------------------------------------------------------*/  
  try {
  
    flag = false;
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at h6000IIPrinterForm.ClickRetry: The h6000IIPrinterForm does not Exist.",
              message     : this.dlgH6000IIPrinterForm + " The h6000IIPrinterForm does not Exist." } 
  
    try{
      objBtnClick = this.dlgH6000IIPrinterForm.Window("WindowsForms10.Window.8.app.0.265601d_r13_ad1", "", 1).Window("WindowsForms10.BUTTON.app.0.265601d_r13_ad1", "Cancel", 2);

      objBtnClick.SetFocus();
      if(objBtnClick.WndCaption === "Cancel") {           
        objBtnClick.Keys("[Enter]");
        flag = true;
      }
    }
    catch(ex){
      TestLog.Message("Unexpected behaviour during Printer window Cancel Event");
    }
    
    return flag; 
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //ClickCancel

function New() {

/*-------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating h6000IIPrinterForm() class from other units of the project. 
--------------------------------------------------------------------------------------------*/

  return new h6000IIPrinterForm();  
}
