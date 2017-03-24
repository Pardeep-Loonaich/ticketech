//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:CustomerInfoScreen
  
  Description: 
  
  This class has methods and properties to perform the CustomerInfoScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function customerInfoScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: customerInfoScreen() 
  
  Description: This method will the Instantiate the CustomerInfoScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnCustomerInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenCustomerInfo", 3);
  
  this.throwError = false; 
    
} //customerInfoScreen

customerInfoScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the customerInfoScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnCustomerInfo.Exists;  //Return whether customerInfoScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

customerInfoScreen.prototype.SetVehicleTag = function (sVehicleTag) {  

/*-------------------------------------------------------------------------------
  Method      : SetsVehicleTag()
  
  Description : This method enters the VehicleTag in the Customer Info screen
  
  Output      : Enters the VehicleTag  in the Customer Info screen 
-------------------------------------------------------------------------------*/  
  try {
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at customerInfoScreen.SetVehicleTag: The Customer Info Exist.",
              message     : this.scrnCustomerInfo + " Screen Exist." }             
    
    if (sVehicleTag!== undefined && sVehicleTag !== null)
       this.scrnCustomerInfo.FindChild("WinFormsControlName", "maskedTextBoxInfo", 3).Keys(sVehicleTag.toString());
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetVehilceTag

customerInfoScreen.prototype.GetErrorMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetErrorMessage()
  
  Description : This method returns the error message displayed in the customer info screen 
  
  Output      : Returns the error message displayed in the customer info screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at CustomerInfoScreen.GetErrorMessage: The Customer info screen  does not Exist.",
              message     : this.scrnCustomerInfo + " Customer info screen  does not Exist." }             
    
    return this.scrnCustomerInfo.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetErrorMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInCustomerInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new customerInfoScreen();  
}