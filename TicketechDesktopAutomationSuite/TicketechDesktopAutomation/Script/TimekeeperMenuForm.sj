//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT TimekeeperOptionsPanel
//USEUNIT TimekeeperMenuScreen
//USEUNIT BackPanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:TimekeeperMenuForm
  
  Description: 
  
  This class has methods and properties to perform the TimekeeperMenuForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function timekeeperMenuForm() { 

/*--------------------------------------------------------------------- 
  Method: timekeeperMenuForm() 
  
  Description: This method will the Instantiate the timekeeperMenuForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgTimekeeperMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormTimekeeperMenu", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.timekeeperOptionsPanel = TimekeeperOptionsPanel.New();
  this.timekeeperMenuScreen - TimekeeperMenuScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.backPanel = BackPanel.New();
  
  this.throwError = false; 
    
} //timekeeperMenuForm

timekeeperMenuForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the timekeeperMenuForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.dlgTimekeeperMenu =  Sys.Process("PosApplication").WaitWinFormsObject("FormTimekeeperMenu", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.timekeeperOptionsPanel = TimekeeperOptionsPanel.New();
    this.timekeeperMenuScreen - TimekeeperMenuScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.backPanel = BackPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

timekeeperMenuForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the timekeeperMenuForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgTimekeeperMenu.Exists;  //Return whether timekeeperMenuForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

timekeeperMenuForm.prototype.NavigateToEnrollmentForm = function () {  

/*--------------------------------------------------------------------------
  Method      : NavigateToEnrollmentForm()
  
  Description : This method Clicks Enrollment button  
  
  Output      : Clicks Enrollment button if TimekeeperMenu Form Exists
--------------------------------------------------------------------------*/  
  try {
    var flag = false;
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at TimekeeperMenuForm.NavigateToEnrollmentForm: The TimekeeperMenu Form does not Exist.",
              message     : this.dlgTimekeeperMenu + " The TimekeeperMenu Form does not Exist." }   
              
      if(this.timekeeperOptionsPanel.IsBtnVisible("ENROLLMENT")) {
        this.timekeeperOptionsPanel.ClickEnrollment();
        flag = true;
    }
 
    return flag;
    Delay(1000);          
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //NavigateToEnrollmentForm

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating timekeeperMenuForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new timekeeperMenuForm();  
}