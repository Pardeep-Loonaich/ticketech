//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT EmployeeScheduleScreen


/*************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeScheduleInfoForm
  
  Description: 
  
  This class has methods and properties to perform the EmployeeScheduleInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function employeeScheduleInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: employeeScheduleInfoForm() 
  
  Description: This method will the Instantiate the employeeScheduleInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgEmployeeScheduleInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeScheduleInfo", 3000); 
  
  this.InfoScreen = InformationScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.objEmployeeScheduleScreen = EmployeeScheduleScreen.New();
  
  this.throwError = false; 
    
} //employeeScheduleInfoForm

employeeScheduleInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the employeeScheduleInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
  
    this.dlgEmployeeScheduleInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormEmployeeScheduleInfo", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.objEmployeeScheduleScreen = EmployeeScheduleScreen.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

employeeScheduleInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeScheduleInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgEmployeeScheduleInfo.Exists;  //Return whether employeeScheduleInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeScheduleInfoForm.prototype.GetRowDataByIndex = function(sColumnHeader){
/*------------------------------------------------------------------------------
  Method      : GetRowDataByIndex()
  
  Description : This method is to get the Rowdata by Index
  
  Output      : Gets the Row data by index in EmployeeScheduleInfoForm
---------------------------------------------------------------------------------*/ 
  try {
    
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeScheduleInfoForm.GetRowDataByIndex: The EmployeeScheduleScreen does not Exist.",
              message     : this.dlgEmployeeScheduleInfo + " Screen does not Exist." }   
    
    iGridRowCount = this.objEmployeeScheduleScreen.GetGridRowCount();
               
    this.objReprintReceiptscreen.SortDataGridByColumnHeader(sColumnHeader);
    Delay(2000);
    
    if(iGridRowCount > 1){
      eFirtRowReceiptData = this.objReprintReceiptscreen.GetFirstRowValue();
      
      this.objReprintReceiptscreen.SortDataGridByColumnHeader(sColumnHeader);
      Delay(2000);
      
      eLastRowReceiptData = this.objReprintReceiptscreen.GetLastRowValue();

    }
    else
      TestLog.Message("No. of rows available to sort: "+iGridRowCount);
  }
  
  catch(exception) {
    TestLog.Message("Error in SortReprintReciptsGridByColumn method");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//SortReprintReciptsGridByColumn

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeScheduleInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeScheduleInfoForm();  
}