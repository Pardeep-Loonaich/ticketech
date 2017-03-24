//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT NoPunchHoursScreen
//USEUNIT Utility
//USEUNIT FormNoPunchHoursDayPanel
//USEUNIT FormNoPunchHoursTypePanel


/*************************************************************************
            ---------- Class Definition ----------
  Name:NoPunchHoursForm
  
  Description: 
  
  This class has methods and properties to perform the NoPunchHoursForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function noPunchHoursForm() { 

/*---------------------------------------------------------------------------------- 
  Method: noPunchHoursForm() 
  
  Description: This method will the Instantiate the noPunchHoursForm Wrapper
---------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgNoPunchHours =  Sys.Process("PosApplication").WaitWinFormsObject("FormNoPunchHours*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objNoPunchHoursScreen = NoPunchHoursScreen.New();
  this.objNavigationPanel = NavigationPanel.New();


  this.throwError = false; 
    
} //noPunchHoursForm

noPunchHoursForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the noPunchHoursForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgNoPunchHours =  Sys.Process("PosApplication").WaitWinFormsObject("FormNoPunchHours*", 3000); 
    
    this.objInfoScreen = InformationScreen.New();
    this.objNoPunchHoursScreen = NoPunchHoursScreen.New();
    this.objNavigationPanel = NavigationPanel.New(); 
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

noPunchHoursForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the noPunchHoursForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgNoPunchHours.Exists;  //Return whether noPunchHoursForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


noPunchHoursForm.prototype.InputNoPunchHoursDetails = function (ePunchHoursDetails) {  

/*-----------------------------------------------------------------
  Method      : InputNoPunchHoursDetails()
  
  Description : This method enters NoPunchHours details 
  
  Output      : Enters NoPunchHours details if noPunchHours Form Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at NoPunchHoursForm.InputNoPunchHoursDetails: The NoPunchHours Form does not Exist.",
              message     : this.dlgNoPunchHours + " The NoPunchHours Form does not Exist." }             
              
    if(ePunchHoursDetails.sLeaveType !== null && ePunchHoursDetails.sLeaveType !== undefined && ePunchHoursDetails.sLeaveType !== "") {
      this.objFormNoPunchHoursTypePanel = FormNoPunchHoursTypePanel.New();
      this.objFormNoPunchHoursTypePanel.Click(ePunchHoursDetails.sLeaveType);
      Delay(1000);
      
      this.Refresh();
      Delay(1000);
    }
    else {
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
    
      return this.objNoPunchHoursScreen.GetErrorMessage();
    }
    
    if(ePunchHoursDetails.sDayOfWeek !== null && ePunchHoursDetails.sDayOfWeek !== undefined && ePunchHoursDetails.sDayOfWeek !== "") {
      this.objFormNoPunchHoursDayPanel = FormNoPunchHoursDayPanel.New();
      this.objFormNoPunchHoursDayPanel.Click(ePunchHoursDetails.sDayOfWeek);
      Delay(1000);
            
      this.Refresh();
      Delay(1000);
    }
    else {
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
    
      return this.objNoPunchHoursScreen.GetErrorMessage();
    }
    
    if(ePunchHoursDetails.iPayHours !== null && ePunchHoursDetails.iPayHours !== undefined && ePunchHoursDetails.iPayHours > 0 ) {
      this.objNoPunchHoursScreen.SetPayHours(ePunchHoursDetails.iPayHours);
      Delay(1000);
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
    }
    else {
      this.objNavigationPanel.ClickEnter();
      Delay(1000);
    
      return this.objNoPunchHoursScreen.GetErrorMessage();
    }

   } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputNoPunchHoursDetails



function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating noPunchHoursForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new noPunchHoursForm();  
}
