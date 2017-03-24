//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryResultsScreen
  
  Description: 
  
  This class has methods and properties to perform the TicketInquiryResultsScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************/

function ticketInquiryResultsScreen() { 

/*---------------------------------------------------------------------------------------------
  Method: ticketInquiryResultsScreen() 
  
  Description: This method will the Instantiate the TicketInquiryResultsScreen Wrapper Helper
----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnTicketInquiryResults =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenTicketInquiryResults", 2);
  
  this.throwError = false; 
    
} //ticketInquiryResultsScreen

ticketInquiryResultsScreen.prototype.Exists = function () {  

/*----------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketInquiryResultsScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-----------------------------------------------------------------------------------*/  

    return this.scrnTicketInquiryResults.Exists;  //Return whether ticketInquiryResultsScreen exists or not
  
} //Exists

ticketInquiryResultsScreen.prototype.MoveToTicketDataRow = function (sTicketNo) {  

/*------------------------------------------------------------------------------------------
  Method      : MoveToTicketDataRow()
  
  Description : This method moves to the required Ticket's Data Row
  
  Output      : Moves to the required Ticket's Data Row in the ticketInquiryResultsScreen
-------------------------------------------------------------------------------------------*/  
  try {
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryResultsScreen.MoveToTicketDataRow: The TicketInquiryResults Screen does not Exist.",
              message     : this.scrnTicketInquiryResults + " Screen does not Exist." }             
    
    Delay(2000);
    if (sTicketNo !== undefined && sTicketNo !== null) 
      return MoveAndGetRowDataByID(sTicketNo);

  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //MoveToTicketDataRow



function New() {

/*----------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating ticketInquiryResultsScreen() class from other units of the project. 
------------------------------------------------------------------------------------------------------*/

  return new ticketInquiryResultsScreen();  
}

function MoveAndGetRowDataByID(value){
/*------------------------------------------------------------------------------------------
  Method      : MoveToEmployeeDataRow()
  
  Description : This method moves to the required Employee's Data Row
  
  Output      : Moves to the required Employee's Data Row in the ticketInquiryResultsScreen
-------------------------------------------------------------------------------------------*/ 
  try {
  
    var objGrid = Sys.Process("PosApplication").FindChild("WinFormsControlName", "dataGridView", 3);
    var iRowCount = objGrid.wRowCount;
    var VehicleData = {sTicketNumber : null, sColor : null, sVehicleMake : null, sPlateNumber : null, bDataAvailable: false};

    if(iRowCount > 0)
       for(iCurrentRow=0;iCurrentRow<iRowCount;iCurrentRow++) {
          if(objGrid.wValue(iCurrentRow,0).OleValue == value){
             VehicleData.sTicketNumber = objGrid.wValue(iCurrentRow,0).OleValue;
             VehicleData.sColor        = objGrid.wValue(iCurrentRow,1).OleValue;
             VehicleData.sVehicleMake  = objGrid.wValue(iCurrentRow,2).OleValue;
             VehicleData.sPlateNumber  = objGrid.wValue(iCurrentRow,2).OleValue;
             VehicleData.bDataAvailable = true;
             objGrid.ClickCell(iCurrentRow,0);
             break;
          }
       }
    return VehicleData; 
  }
  

  catch(exception) {
    TestLog.Message("Error in MoveAndGetRowDataByID method: "+ exception);
  }
}