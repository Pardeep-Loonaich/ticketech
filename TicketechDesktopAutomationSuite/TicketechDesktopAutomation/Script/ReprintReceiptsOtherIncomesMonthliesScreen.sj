//USEUNIT Utility

/*********************************************************************************************************
            ---------- Class Definition ----------
  Name:ReprintReceiptsOtherIncomesMonthliesScreen
  
  Description: 
  
  This class has methods and properties to perform the ReprintReceiptsOtherIncomesMonthliesScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************************/

function reprintReceiptsOtherIncomesMonthliesScreen() { 

/*----------------------------------------------------------------------------------------------------------- 
  Method: reprintReceiptsOtherIncomesMonthliesScreen() 
  
  Description: This method will the Instantiate the ReprintReceiptsOtherIncomesMonthliesScreen Wrapper Helper
-----------------------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnReprintReceiptsOtherIncomesMonthlies =  Sys.Process("PosApplication").FindChild("WinFormsControlName","ScreenReprintReceiptsOtherIncomesMonthlies",2);
  
  this.throwError = false; 
    
} //reprintReceiptsOtherIncomesMonthliesScreen 

reprintReceiptsOtherIncomesMonthliesScreen.prototype.Exists = function () {  

/*------------------------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reprintReceiptsOtherIncomesMonthliesScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnReprintReceiptsOtherIncomesMonthlies.Exists;  //Return whether reprintReceiptsOtherIncomesMonthliesScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reprintReceiptsOtherIncomesMonthliesScreen.prototype.SortDataGridByColumnHeader = function(sColumnHeader){
/*----------------------------------------------------------------------------------------------------------
  Method      : SortDataGridByColumnHeader()
  
  Description : This method is for sorting row based on column header like the Tag/Desc,Date,Amount and Type
  
  Output      : Sorts the row based on Column Header of the DataGrid
----------------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesScreen.SortDataGridByColumnHeader: The ReprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnReprintReceiptsOtherIncomesMonthlies + " Screen does not Exist." }   
    
    Delay(1000);
    
    var objGrid = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3);
    
    switch (sColumnHeader) {
     case "TagDesc"    : objGrid.ClickColumnHeader(0); Delay(1000);break;
     case "Date"       : objGrid.ClickColumnHeader(1); Delay(1000);break;
     case "Amount"     : objGrid.ClickColumnHeader(2); Delay(1000);break;
     case "Type"       : objGrid.ClickColumnHeader(3); Delay(1000);break;
     default           : TestLog.Message("No Column avilable with given "+sColumnHeader); break;
    }
  }
  
  catch(exception) {
    TestLog.Message("Error in SortDataGridByColumnHeader method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//SortDataGridByColumnHeader

reprintReceiptsOtherIncomesMonthliesScreen.prototype.GetFirstRowValue = function(){
/*-----------------------------------------------------------------------------------------------------
  Method      : GetFirstRowValue()
  
  Description : This method is for getting the receipts firt row data
  
  Output      : Gets the first row data from the grid in the ReprintReceiptsOtherIncomesMonthliesScreen
-----------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesScreen.GetFirstRowValue: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnReprintReceiptsOtherIncomesMonthliesScreen + " Screen does not Exist." } 
                
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

reprintReceiptsOtherIncomesMonthliesScreen.prototype.GetLastRowValue = function(){
/*-----------------------------------------------------------------------------------------------------
  Method      : GetLastRowValue()
  
  Description : This method is for getting the receipts firt row data
  
  Output      : Gets the first row data from the grid in the ReprintReceiptsOtherIncomesMonthliesScreen
-----------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesScreen.GetLastRowValue: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnReprintReceiptsOtherIncomesMonthliesScreen + " Screen does not Exist." }   
    
    iRowCount = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).wRowCount;
    if(iRowCount > 0)
      return GetRowDataByIndex(iRowCount-1);

  }
  
  catch(exception) {
    TestLog.Message("Error in GetLastRowValue method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//GetLastRowValue

reprintReceiptsOtherIncomesMonthliesScreen.prototype.GetGridRowCount = function(){
/*-----------------------------------------------------------------------------------------------------
  Method      : GetGridRowCount()
  
  Description : This method is for getting the no of grid rows
  
  Output      : Gets the row count from the grid in the ReprintReceiptsOtherIncomesMonthliesScreen
-----------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesScreen.GetGridRowCount: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnReprintReceiptsOtherIncomesMonthliesScreen + " Screen does not Exist." }   
    
    iRowCount = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).wRowCount;

    return iRowCount;

  }
  
  catch(exception) {
    TestLog.Message("Error in GetGridRowCount method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//GetGridRowCount

reprintReceiptsOtherIncomesMonthliesScreen.prototype.ClickRandomRowByIndex = function(iIndex){
/*-----------------------------------------------------------------------------------------------
  Method      : ClickRandomRowByIndex()
  
  Description : This method is to Click Random Row By Index
  
  Output      : Clicks Random Row from the grid in the ReprintReceiptsOtherIncomesMonthliesScreen
-----------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesScreen.GetGridRowCount: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnReprintReceiptsOtherIncomesMonthliesScreen + " Screen does not Exist." }   
    
    Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3).ClickCell(iIndex,0);

  }
  
  catch(exception) {
    TestLog.Message("Error in GetGridRowCount method: "+ exception);
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//ClickRandomRowByIndex

reprintReceiptsOtherIncomesMonthliesScreen.prototype.GetCurrentRowIndex = function(){
/*-----------------------------------------------------------------------------------------------------------
  Method      : GetCurrentRowIndex()
  
  Description : This method is to Get Current RowIndex
  
  Output      : Gets Current focused Row Index from the grid in the ReprintReceiptsOtherIncomesMonthliesScreen
------------------------------------------------------------------------------------------------------------*/ 
  try {
  
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesScreen.GetCurrentRowIndex: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.scrnReprintReceiptsOtherIncomesMonthliesScreen + " Screen does not Exist." }   
    
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
  
  Output      : Gets the required Data Row in the ReprintReceiptsOtherIncomesMonthliesScreen
-------------------------------------------------------------------------------------------*/ 
  try {
  
    var objGrid = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3);
    
    var receiptData = {  TagDesc : objGrid.wValue(iIndexValue,0).OleValue
                        ,Date    : objGrid.wValue(iIndexValue,1).OleValue
                        ,Amount  : objGrid.wValue(iIndexValue,2).OleValue
                        ,Type    : objGrid.wValue(iIndexValue,3).OleValue
                      };
    
    return receiptData; 
  }
  
  catch(exception) {
    TestLog.Message("Error in GetRowDataByIndex method: "+ exception);
  }
}//GetRowDataByIndex

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating reprintReceiptsOtherIncomesMonthliesScreen() class 
  from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reprintReceiptsOtherIncomesMonthliesScreen();  
}//New
