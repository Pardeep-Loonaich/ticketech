//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT DateTimeScreen


/*************************************************************************
            ---------- Class Definition ----------
  Name:ManualDateInformationDateForm
  
  Description: 
  
  This class has methods and properties to perform the ManualDateInformationDateForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function manualDateInformationDateForm() { 

/*--------------------------------------------------------------------- 
  Method: manualDateInformationDateForm() 
  
  Description: This method will the Instantiate the manualDateInformationDateForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmManualDateInformationDate =  Sys.Process("PosApplication").WaitWinFormsObject("FormManualDateInformationDate", 3000);   
  this.navigationPanel = NavigationPanel.New();
  this.dateTimeScreen = DateTimeScreen.New();
  
  this.throwError = false; 
    
} //manualDateInformationDateForm

manualDateInformationDateForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the manualDateInformationDateForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
    
    this.frmManualDateInformationDate =  Sys.Process("PosApplication").WaitWinFormsObject("FormManualDateInformationDate", 3000);   
    this.navigationPanel = NavigationPanel.New();
    this.dateTimeScreen = DateTimeScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

manualDateInformationDateForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the manualDateInformationDateForm.  
  
  Output: True if panel Exists
          False if panel does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmManualDateInformationDate.Exists;  //Return whether manualDateInformationDateForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

manualDateInformationDateForm.prototype.EnterCheckInDate = function (iDate) {  

/*--------------------------------------------------------------------------
  Method      : EnterCheckInDate()
  
  Description : This method Enters CheckIn date , if iDate is not null or will simply enters default date by clicking Enter button  
  
  Output      : Enters date  if manualDateInformationDateForm Form Exists
--------------------------------------------------------------------------*/  
  try {
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at manualDateInformationDateForm.EnterCheckInDate: The ManualDateInformationDateForm Form does not Exist.",
              message     : this.frmManualDateInformationDate + " The ManualDateInformationDateForm Form does not Exist." }   
              
      if(iDate !== null) {
        this.dateTimeScreen.EnterDate(iDate);
        this.navigationPanel.ClickEnter();
        Log.Message("CheckIn Date entered manually")
        }
        else {
        this.navigationPanel.ClickEnter();
        Log.Message("Default CheckIn date entered")
        }
    }//End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterCheckInDate

manualDateInformationDateForm.prototype.EnterCheckInTime = function (iTime) {  

/*--------------------------------------------------------------------------
  Method      : EnterCheckInTime()
  
  Description : This method Enters CheckIn time , if iTime is not null or will simply enters default time by clicking Enter button  
  
  Output      : Enters time  if manualDateInformationDateForm Form Exists
--------------------------------------------------------------------------*/  
  try {
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ManualDateInformationDateForm.EnterCheckInTime: The ManualDateInformationDateForm Form does not Exist.",
              message     : this.frmManualDateInformationDate + " The ManualDateInformationDateForm Form does not Exist." }   
              
      if(iTime !== null) {
        this.dateTimeScreen.EnterTime(iTime);
        this.navigationPanel.ClickEnter();
        Log.Message("CheckIn Time entered manually")
        }
        else {
        this.navigationPanel.ClickEnter();
        Log.Message("Default CheckIn time entered")
        }
    }//End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterCheckInTime

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating manualDateInformationDateForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new manualDateInformationDateForm();  
}