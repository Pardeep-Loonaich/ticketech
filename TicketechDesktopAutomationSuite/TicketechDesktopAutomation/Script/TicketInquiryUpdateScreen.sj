//USEUNIT Utility


/******************************************************************************
            ---------- Class Definition ----------
  Name:TicketInquiryUpdateScreen
  
  Description: 
  
  This class has methods and properties to perform the TicketInquiryUpdateScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function ticketInquiryUpdateScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: ticketInquiryUpdateScreen() 
  
  Description: This method will the Instantiate the TicketInquiryUpdateScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnTicketInquiryUpdate =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenTicketInquiryUpdate", 3);
  
  this.throwError = false; 
    
} //TicketInquiryUpdateScreen

ticketInquiryUpdateScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the ticketInquiryUpdateScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/   
    
    return this.scrnTicketInquiryUpdate.Exists;  //Return whether ticketInquiryUpdateScreen exists or not
       
} //Exists

ticketInquiryUpdateScreen.prototype.Refresh = function () {  

/*---------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method re-instantiate the ticketInquiryUpdateScreen.    
----------------------------------------------------------------------*/  
  try {
  
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryUpdateScreen.Refresh: ticketInquiryUpdateScreen does not Exist.",
              message     : this.scrnTicketInquiryUpdate + " Screen does not Exist." }  

    this.scrnTicketInquiryUpdate =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenTicketInquiryUpdate");
     
  } //End try
  
 catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh



ticketInquiryUpdateScreen.prototype.EnterPlateNumber = function (plateNumber) {  

/*-------------------------------------------------------------------------------
  Method      : EnterPlateNumber()
  
  Description : This method enters the Vehicle plate number on the ticketInquiryUpdate screen
  
  Output      : Enters the Plate Number in Vehicle Info screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at ticketInquiryUpdateScreen.EnterPlateNumber: The Vehicle Plate textfield does not Exist.",
              message     : this.scrnTicketInquiryUpdate + " Screen does not Exist." }             
    
    if (plateNumber !== undefined && plateNumber !== null)

      this.scrnTicketInquiryUpdate.FindChild("Caption","PLATE",3).WinFormsObject("maskedTextBoxInfo").Keys(plateNumber);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterPlateNumber


function New() {

/*---------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating TicketInquiryUpdateScreen() class from other units of the project. 
-----------------------------------------------------------------------------------------*/

  return new ticketInquiryUpdateScreen();  
}


