//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT BackPanel
//USEUNIT CursorsPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeePrintTimecardPreviewForm
  
  Description: 
  
  This class has methods and properties to perform the Employee PrintTimecardPreviewForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeePrintTimecardPreviewForm() { 

/*-------------------------------------------------------------------------- 
  Method: employeePrintTimecardPreviewForm() 
  
  Description: This method will the Instantiate the employeePrintTimecardPreviewForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgemployeePrintTimecardPreview =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePrintTimecardPreview", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.cursorsPanel= CursorsPanel.New();
  this.backPanel= BackPanel.New();
  
  this.throwError = false; 
    
} //employee PrintTimecardForm

employeePrintTimecardPreviewForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employee PrintTimecardForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
  this.dlgemployeePrintTimecardPreview =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePrintTimecardPreview", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.cursorsPanel= CursorsPanel.New();
  this.backPanel= BackPanel.New();
  
     
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeePrintTimecardPreviewForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeePrintTimecardPreviewForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgemployeePrintTimecardPreview.Exists;  //Return whether employee PrintTimecardForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeePrintTimecardPreviewForm.prototype.SubmitForm = function () {  

/*--------------------------------------------------------------------------
  Method      : SubmitForm()
  
  Description : This method Clicks enter button  
  
  Output      : Clicks Enter button if Employee Punch Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeePrintTimecardPreview.SubmitForm: The Employee PrintTimecardPreview Form does not Exist.",
              message     : this.dlgemployeePrintTimecardPreview + " The Employee PrintTimecardPreview Form does not Exist." }             
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SubmitForm

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeePunchForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeePrintTimecardPreviewForm();  
}