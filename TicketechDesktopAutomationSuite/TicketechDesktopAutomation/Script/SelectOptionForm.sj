//USEUNIT Utility
//USEUNIT OptionsListPanel

/**************************************************************************
            ---------- Class Definition ----------
  Name:SelectOptionForm
  
  Description: 
  
  This class has methods and properties to perform the SelectOptionForm Form objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function selectOptionForm() { 

/*--------------------------------------------------------------------------- 
  Method: selectOptionForm() 
  
  Description: This method will the Instantiate the selectOptionForm Wrapper Helper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmSelectOption =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "FormSelectOption", 2000);
  this.objOptionsListPanel = OptionsListPanel.New();
  this.throwError = false; 
    
} //selectOptionForm

selectOptionForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the selectOptionForm.  
  
  Output: True if Panel Exists
          False if Panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmSelectOption.Exists;  //Return whether selectOptionForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


selectOptionForm.prototype.SelectAll = function () {  

/*-----------------------------------------------------------------
  Method      : SelectAll()
  
  Description : This method Clicks All button  
  
  Output      : Click on All button if select Option Form Exists
-----------------------------------------------------------------*/  
  this.objOptionsListPanel.ClickAll();
      
} //SelectAll


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating selectOptionForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new selectOptionForm();  
}