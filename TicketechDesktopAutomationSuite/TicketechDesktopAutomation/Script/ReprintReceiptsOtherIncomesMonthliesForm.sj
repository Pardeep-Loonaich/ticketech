//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT NavigationPanel
//USEUNIT ReprintReceiptsOtherIncomesMonthliesScreen
//USEUNIT CursorsPanel


/******************************************************************************************************
            ---------- Class Definition ----------
  Name:ReprintReceiptsOtherIncomesMonthliesForm
  
  Description: 
  
  This class has methods and properties to perform the ReprintReceiptsOtherIncomesMonthliesForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************************/

function reprintReceiptsOtherIncomesMonthliesForm() { 

/*--------------------------------------------------------------------------------------------------
  Method: reprintReceiptsOtherIncomesMonthliesForm() 
  
  Description: This method will the Instantiate the reprintReceiptsOtherIncomesMonthliesForm Wrapper
--------------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgReprintReceiptsOtherIncomesMonthlies =  Sys.Process("PosApplication").WaitWinFormsObject("FormReprintReceiptsOtherIncomesMonthlies", 3000); 
  
  this.objInformationScreen = InformationScreen.New();
  this.objReprintReceiptscreen = ReprintReceiptsOtherIncomesMonthliesScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  this.objCursorsPanel = CursorsPanel.New();
  
  this.throwError = false; 
    
} //reprintReceiptsOtherIncomesMonthliesForm

reprintReceiptsOtherIncomesMonthliesForm.prototype.Refresh = function () {  

/*------------------------------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the reprintReceiptsOtherIncomesMonthliesForm Wrapper   
------------------------------------------------------------------------------------------------------*/  
  try {
   
    this.dlgReprintReceiptsOtherIncomesMonthlies =  Sys.Process("PosApplication").WaitWinFormsObject("FormReprintReceiptsOtherIncomesMonthlies", 3000); 
  
    this.objInformationScreen = InformationScreen.New();
    this.objReprintReceiptscreen = ReprintReceiptsOtherIncomesMonthliesScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
    this.objCursorsPanel = CursorsPanel.New();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

reprintReceiptsOtherIncomesMonthliesForm.prototype.Exists = function () {  

/*----------------------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the reprintReceiptsOtherIncomesMonthliesForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgReprintReceiptsOtherIncomesMonthlies.Exists;  //Return whether reprintReceiptsOtherIncomesMonthliesForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

reprintReceiptsOtherIncomesMonthliesForm.prototype.SortReprintReciptsGridByColumn = function(sColumnHeader){
/*-----------------------------------------------------------------------------------------------------
  Method      : SortReprintReciptsGridByColumn()
  
  Description : This method is for sorting the Grid rows by column header
  
  Output      : Sorts the Grid rows based on the Column in the ReprintReceiptsOtherIncomesMonthliesForm
-----------------------------------------------------------------------------------------------------*/ 
  try {
    
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesForm.SortReprintReciptsGridByColumn: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.dlgReprintReceiptsOtherIncomesMonthlies + " Screen does not Exist." }   
    
    iGridRowCount = this.objReprintReceiptscreen.GetGridRowCount();
               
    this.objReprintReceiptscreen.SortDataGridByColumnHeader(sColumnHeader);
    Delay(2000);
    
    if(iGridRowCount > 1){
      eFirtRowReceiptData = this.objReprintReceiptscreen.GetFirstRowValue();
      
      this.objReprintReceiptscreen.SortDataGridByColumnHeader(sColumnHeader);
      Delay(2000);
      
      eLastRowReceiptData = this.objReprintReceiptscreen.GetLastRowValue();
      
      bTagCheck    = eFirtRowReceiptData.TagDesc === eLastRowReceiptData.TagDesc;
      bDateCheck   = eFirtRowReceiptData.Date    === eLastRowReceiptData.Date;
      bAmountCheck = eFirtRowReceiptData.Amount  === eLastRowReceiptData.Amount;
      bTypeCheck   = eFirtRowReceiptData.Type    === eLastRowReceiptData.Type;
      return (bTagCheck && bDateCheck && bAmountCheck && bTypeCheck);
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

reprintReceiptsOtherIncomesMonthliesForm.prototype.PrintAnyReciptInGrid = function(){
/*----------------------------------------------------------------------------------------------
  Method      : PrintAnyReciptInGrid()
  
  Description : This method is to Print Any Recipt In Grid
  
  Output      : Print Any random Recipt In Grid in the ReprintReceiptsOtherIncomesMonthliesForm
----------------------------------------------------------------------------------------------*/ 
  try {
    
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesForm.PrintAnyReciptInGrid: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.dlgReprintReceiptsOtherIncomesMonthlies + " Screen does not Exist." }   
    
    iGridRowCount = this.objReprintReceiptscreen.GetGridRowCount();
    
    if(iGridRowCount > 0)           
      this.objReprintReceiptscreen.ClickRandomRowByIndex(Utility.randomIntFromInterval(0,iGridRowCount-1));
    else
      TestLog.Message("No. of rows available: "+iGridRowCount); 
  }
  
  catch(exception) {
    TestLog.Message("Error in PrintAnyReciptInGrid method");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//PrintAnyReciptInGrid


reprintReceiptsOtherIncomesMonthliesForm.prototype.NavigateByCursors = function(){
/*-----------------------------------------------------------------------------------------------------------
  Method      : NavigateByCursors()
  
  Description : This method is to Navigate through the rows By Cursors In Grid
  
  Output      : Navigates through the rows By Cursors In Grid in the ReprintReceiptsOtherIncomesMonthliesForm
-----------------------------------------------------------------------------------------------------------*/ 
  try {
    
    var aRowIndex = [];
    
    this.lastError = {};

    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ReprintReceiptsOtherIncomesMonthliesForm.NavigateByCursors: The reprintReceiptsOtherIncomesMonthlies Screen does not Exist.",
              message     : this.dlgReprintReceiptsOtherIncomesMonthlies + " Screen does not Exist." }   
    
    iGridRowCount = this.objReprintReceiptscreen.GetGridRowCount();
    
    aRowIndex[0] = iGridRowCount;
     
    if(iGridRowCount > 1) {
      this.objCursorsPanel.ClickDownCursor();
      Delay(2000);
      aRowIndex[1] = this.objReprintReceiptscreen.GetCurrentRowIndex();
      
      this.objCursorsPanel.ClickUpCursor();
      Delay(2000);
      aRowIndex[2] = this.objReprintReceiptscreen.GetCurrentRowIndex();
               
      this.objCursorsPanel.ClickRightCursor();
      Delay(2000);
      aRowIndex[3] = this.objReprintReceiptscreen.GetCurrentRowIndex();
      
      this.objCursorsPanel.ClickLeftCursor();
      Delay(2000);
      aRowIndex[4] = this.objReprintReceiptscreen.GetCurrentRowIndex();
    }
      
    if(iGridRowCount <= 1) 
      TestLog.Message("No. of rows available: "+iGridRowCount); 
    
    return aRowIndex;  
  }
  
  catch(exception) {
    TestLog.Message("Error in NavigateByCursors method");
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  }
}//NavigateByCursors


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating reprintReceiptsOtherIncomesMonthliesForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new reprintReceiptsOtherIncomesMonthliesForm();  
}