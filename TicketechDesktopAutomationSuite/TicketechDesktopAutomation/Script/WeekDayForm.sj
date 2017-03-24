//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT Utility
//USEUNIT WeekdayPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:WeekdayForm
  
  Description: 
  
  This class has methods and properties to perform the WeekdayForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function weekdayForm() { 

/*---------------------------------------------------------------------------------- 
  Method: weekdayForm() 
  
  Description: This method will the Instantiate the weekdayForm Wrapper
---------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgWeekday =  Sys.Process("PosApplication").WaitWinFormsObject("FormWeekday*", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objWeekdayPanel = WeekdayPanel.New();

  this.throwError = false; 
    
} //weekdayForm

weekdayForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the weekdayForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgWeekday =  Sys.Process("PosApplication").WaitWinFormsObject("FormWeekday*", 3000); 
    
    this.objInfoScreen = InformationScreen.New();
    this.objNavigationPanel = NavigationPanel.New(); 
    this.objWeekdayPanel = WeekdayPanel.New();
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

weekdayForm.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the weekdayForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgWeekday.Exists;  //Return whether weekdayForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


weekdayForm.prototype.InputWeekDetails = function (eWeekDetails) {  

/*-----------------------------------------------------------------
  Method      : InputWeekDetails()
  
  Description : This method enters week details 
  
  Output      : Enters week details if weekday Form Exists
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at WeekdayForm.InputWeekDetails: The weekdayForm does not Exist.",
              message     : this.dlgWeekday + " The weekdayForm does not Exist." }             
              

      this.objWeekdayPanel.Click(eWeekDetails.sDayOfWeek);
      Delay(1000);

   } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputWeekDetails

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating weekdayForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new weekdayForm();  
}
