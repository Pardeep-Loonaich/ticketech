//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT BackPanel
//USEUNIT CursorsPanel
//USEUNIT EmployeePrintTimecardPreviewScreen



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
  
  Description: This method will the Instantiate the EmployeePrintTimecardPreviewForm Wrapper
---------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeePrintTimecardPreview =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePrintTimecardPreview", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.cursorsPanel= CursorsPanel.New();
  this.backPanel= BackPanel.New();
  this.empPrintTCPreviewScreen = EmployeePrintTimecardPreviewScreen.New();
  
  this.throwError = false;  
} //employee PrintTimecardForm

employeePrintTimecardPreviewForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the EmployeePrintTimecardPreviewForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgEmployeePrintTimecardPreview =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeePrintTimecardPreview", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.cursorsPanel= CursorsPanel.New();
    this.backPanel= BackPanel.New();
    this.empPrintTCPreviewScreen = EmployeePrintTimecardPreviewScreen.New();   
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch      
} //Refresh

employeePrintTimecardPreviewForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the EmployeePrintTimecardPreviewForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeePrintTimecardPreview.Exists;  //Return whether employeePrintTimecardPreviewForm exists or not
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
  
  Output      : Clicks Enter button if EmployeePrintTimecardPreview Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeePrintTimecardPreview.SubmitForm: The EmployeePrintTimecardPreview Form does not Exist.",
              message     : this.dlgEmployeePrintTimecardPreview + " The EmployeePrintTimecardPreview Form does not Exist." }             
    
    this.navigationPanel.ClickEnter();
    Delay(1000);  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch     
} //SubmitForm

employeePrintTimecardPreviewForm.prototype.CancelForm = function () {  

/*--------------------------------------------------------------------------
  Method      : CancelForm()
  
  Description : This method Clicks Cancel button  
  
  Output      : Clicks Cancel button if EmployeePrintTimecardPreview Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at formEmployeePrintTimecardPreview.SubmitForm: The EmployeePrintTimecardPreview Form does not Exist.",
              message     : this.dlgEmployeePrintTimecardPreview + " The EmployeePrintTimecardPreview Form does not Exist." }             
    
    this.navigationPanel.ClickCancel();
    Delay(1000);  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch     
} //SubmitForm


employeePrintTimecardPreviewForm.prototype.GetFormInfo = function(){

/*------------------------------------------------------------------------------------ 
  Method: GetFormInfo() 
  
  Description:
  This method is for getting the Info of the Screen like Title, Message etc. 
------------------------------------------------------------------------------------*/

  try {
   
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeePrintTimecardPreviewForm.getFormInfo: The EmployeePrintTimecardPreview Form does not Exist.",
              message     : this.dlgEmployeePrintTimecardPreview + " The EmployeePrintTimecardPreview Form does not Exist." }
     
    frmInfo = {  Title    : this.empPrintTCPreviewScreen.GetTitle() };
      
    return frmInfo;    
  }
  
  catch(exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeePunchForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeePrintTimecardPreviewForm();  
}