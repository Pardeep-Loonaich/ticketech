//USEUNIT Utility

/*********************************************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryScreen
  
  Description: 
  
  This class has methods and properties to perform the TicketInquiryScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
********************************************************************************************************/

function ticketInquiryScreen() { 

/*----------------------------------------------------------------------------------------------------------- 
  Method: ticketInquiryScreen() 
  
  Description: This method will the Instantiate the TicketInquiryScreen Wrapper Helper
-----------------------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnTicketInquiry =  Sys.Process("PosApplication").FindChild("WinFormsControlName","ScreenTicketInquiry",2);
  
  this.throwError = false; 
    
} //ticketInquiryScreen 

ticketInquiryScreen.prototype.Exists = function () {  

/*------------------------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketInquiryScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-------------------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnTicketInquiry.Exists;  //Return whether ticketInquiryScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


ticketInquiryScreen.prototype.GetTicketDetails = function(){
/*------------------------------------------------------------------------------------------
  Method      : GetRowDataByIndex()
  
  Description : This gets the required  data by row Index
  
  Output      : Gets the required Data Row in the TicketInquiryScreen
-------------------------------------------------------------------------------------------*/ 
  try {
    
    Delay(1000);
    
    var objGrid = this.scrnTicketInquiry.FindChild("WinFormsControlName", "dataGridView", 3);
    
    var FormData = {     sTicketNumber : objGrid.wValue(0,1).OleValue
                        ,sColor        : objGrid.wValue(1,1).OleValue
                        ,sVehicleMake  : objGrid.wValue(2,1).OleValue
                        ,sPlateNumber  : objGrid.wValue(3,1).OleValue
                        ,sVehicleTag   : objGrid.wValue(4,1).OleValue
                      };
    
    return FormData; 
  }
  
  catch(exception) {
    TestLog.Message("Error in GetRowDataByIndex method: "+ exception);
  }
}//GetRowDataByIndex

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating ticketInquiryScreen() class 
  from other units of the project. 
------------------------------------------------------------------------------------*/

  return new ticketInquiryScreen();  
}//New
