//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------
  Name:EmployeeEnrollmentMenuScreen
  
  Description: 
  
  This class has methods and properties to perform the EmployeeEnrollmentMenuScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************/

function employeeEnrollmentMenuScreen() { 

/*---------------------------------------------------------------------------------------------
  Method: employeeEnrollmentMenuScreen() 
  
  Description: This method will the Instantiate the EmployeeEnrollmentMenuScreen Wrapper Helper
----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnEmpEnrollMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenEmployeeEnrollmentMenu", 2);
  
  this.throwError = false; 
    
} //employeeEnrollmentMenuScreen

employeeEnrollmentMenuScreen.prototype.Exists = function () {  

/*----------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the employeeEnrollmentMenuScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnEmpEnrollMenu.Exists;  //Return whether employeeEnrollmentMenuScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

employeeEnrollmentMenuScreen.prototype.MoveToEmployeeDataRow = function (empId) {  

/*------------------------------------------------------------------------------------------
  Method      : MoveToEmployeeDataRow()
  
  Description : This method moves to the required Employee's Data Row
  
  Output      : Moves to the required Employee's Data Row in the employeeEnrollmentMenuScreen
-------------------------------------------------------------------------------------------*/  
  try {
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentMenuScreen.MoveToEmployeeDataRow: The EmployeeEnrollmentMenu Screen does not Exist.",
              message     : this.scrnEmpEnrollMenu + " Screen does not Exist." }             
    
    if (empId !== undefined && empId !== null) 
      return MoveAndGetRowDataByID(empId);

  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //MoveToEmployeeDataRow


employeeEnrollmentMenuScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the employeeEnrollmentMenu Screen 
  
  Output      : Returns the label of the given object in the employeeEnrollmentMenu Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at employeeEnrollmentMenuScreen.Get"+objControlName+": The EmployeeEnrollmentMenu screen does not Exist.",
              message     : this.scrnEmpEnrollMenu + " EmployeeEnrollmentMenu Screen does not Exist." }             
    
    return this.scrnEmpEnrollMenu.FindChild("WinFormsControlName", objControlName, 2).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

employeeEnrollmentMenuScreen.prototype.GetTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitle()
  
  Description : This method returns the current Title labelled in the employeeEnrollmentMenuS screen 
  
  Output      : Returns the current Title labelled in the employeeEnrollmentMenu screen 
-------------------------------------------------------------------------------*/  
  return   this.GetText("labelTitle");
      
} //GetTitle


function New() {

/*----------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating employeeEnrollmentMenuScreen() class from other units of the project. 
------------------------------------------------------------------------------------------------------*/

  return new employeeEnrollmentMenuScreen();  
}

function MoveAndGetRowDataByID(value){
/*------------------------------------------------------------------------------------------
  Method      : MoveToEmployeeDataRow()
  
  Description : This method moves to the required Employee's Data Row
  
  Output      : Moves to the required Employee's Data Row in the employeeEnrollmentMenuScreen
-------------------------------------------------------------------------------------------*/ 
  try {
  
    var objGrid = Sys.Process("PosApplication").FindChild("WinFormsControlName", "customDataGridInformation", 3);
    var iRowCount = objGrid.wRowCount;
    var employeeData = {ID : null,LastName : null,FirstName : null};

    if(iRowCount > 0)
       for(iCurrentRow=0;iCurrentRow<iRowCount;iCurrentRow++) {
          if(objGrid.wValue(iCurrentRow,0)== value){
             objGrid.ClickCell(iCurrentRow,0);
             employeeData.ID = objGrid.wValue(iCurrentRow,0);
             employeeData.FirstName = objGrid.wValue(iCurrentRow,1);
             employeeData.LastName = objGrid.wValue(iCurrentRow,2);
             break;
          }
       }
    return employeeData; 
  }
  

  catch(exception) {
    TestLog.Message("Error in MoveAndGetRowDataByID method: "+ exception);
  }
}