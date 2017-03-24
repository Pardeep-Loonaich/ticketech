//USEUNIT Utility

/*********************************************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeScheduleScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeeScheduleScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************************/

function employeeScheduleScreen() { 

/*----------------------------------------------------------------------------------------------------------- 
  Method: employeeScheduleScreen() 
  
  Description: This method will the Instantiate the EmployeeScheduleScreen Wrapper Helper
-----------------------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmployeeSchedule =  Sys.Process("PosApplication").FindChild("WinFormsControlName","ScreenEmployeeSchedule",2);
  
  this.throwError = false; 
    
} //employeeScheduleScreen 

employeeScheduleScreen.prototype.Exists = function () {  

/*------------------------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeScheduleScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmployeeSchedule.Exists;  //Return whether employeeScheduleScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


employeeScheduleScreen.prototype.GetFirstRowValue = function(){
/*-----------------------------------------------------------------------------------------------------
  Method      : GetFirstRowValue()
  
  Description : This method is for getting the schedule firt row data
  
  Output      : Gets the first row data from the grid in the EmployeeScheduleScreen
-----------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeScheduleScreen.GetFirstRowValue: The EmployeeScheduleScreen does not Exist.",
              message     : this.scrnEmployeeScheduleScreen + " Screen does not Exist." } 
                
    iRowCount = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).wRowCount;
    if(iRowCount > 0)
      return GetRowDataByIndex(0);

  }
  
  catch(exception) {
    TestLog.Message("Error in GetFirstRowValue method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//GetFirstRowValue


employeeScheduleScreen.prototype.GetGridRowCount = function(){
/*-----------------------------------------------------------------------------------------------------
  Method      : GetGridRowCount()
  
  Description : This method is for getting the no of grid rows
  
  Output      : Gets the row count from the grid in the EmployeeScheduleScreen
-----------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeScheduleScreen.GetGridRowCount: The EmployeeScheduleScreen does not Exist.",
              message     : this.scrnEmployeeScheduleScreen + " Screen does not Exist." }   
    
    iRowCount = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).wRowCount;

    return iRowCount;

  }
  
  catch(exception) {
    TestLog.Message("Error in GetGridRowCount method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//GetGridRowCount

employeeScheduleScreen.prototype.ClickRandomRowByIndex = function(iIndex){
/*-----------------------------------------------------------------------------------------------
  Method      : ClickRandomRowByIndex()
  
  Description : This method is to Click Random Row By Index
  
  Output      : Clicks Random Row from the grid in the EmployeeScheduleScreen
-----------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeScheduleScreen.GetGridRowCount: The EmployeeScheduleScreen does not Exist.",
              message     : this.scrnEmployeeScheduleScreen + " Screen does not Exist." }   
    
    Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).ClickCell(iIndex,0);

  }
  
  catch(exception) {
    TestLog.Message("Error in GetGridRowCount method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//ClickRandomRowByIndex

employeeScheduleScreen.prototype.GetCurrentRowIndex = function(){
/*-----------------------------------------------------------------------------------------------------------
  Method      : GetCurrentRowIndex()
  
  Description : This method is to Get Current RowIndex
  
  Output      : Gets Current focused Row Index from the grid in the EmployeeScheduleScreen
------------------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at EmployeeScheduleScreen.GetCurrentRowIndex: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnEmployeeScheduleScreen + " Screen does not Exist." }   
    
    return Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).SelectedRows.Item(0).Index;

  }
  
  catch(exception) {
    TestLog.Message("Error in GetCurrentRowIndex method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//GetCurrentRowIndex


function GetRowDataByIndex(iIndexValue){
/*------------------------------------------------------------------------------------------
  Method      : GetRowDataByIndex()
  
  Description : This gets the required reciepts data by row Index
  
  Output      : Gets the required Data Row in the EmployeeScheduleScreen
-------------------------------------------------------------------------------------------*/ 
  try {
  
    var objGrid = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3);
    
    var scheduleTime = {  Day : objGrid.wValue(iIndexValue,0).OleValue
                        , TimeIn    : objGrid.wValue(iIndexValue,1).OleValue
                        , TimeOut  : objGrid.wValue(iIndexValue,2).OleValue
                        , Hours    : objGrid.wValue(iIndexValue,3).OleValue
                        , Total    : objGrid.wValue(iIndexValue,4).OleValue
                      };
    
    return scheduleTime; 
  }
  
  catch(exception) {
    TestLog.Message("Error in GetRowDataByIndex method: "+ exception);
  }
}//GetRowDataByIndex

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating employeeScheduleScreen() class 
  from other units of the project. 
------------------------------------------------------------------------------------*/

  return new employeeScheduleScreen(); 
   
}//New
