//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:InformationScreen
  
  Description: 
  
  This class has methods and properties to perform the InformationScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function informationScreen() { 

/*----------------------------------------------------------------------------------- 
  Method: informationScreen() 
  
  Description: This method will the Instantiate the informationScreen Wrapper Helper
-----------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenInformation", 2);
  this.throwError = false; 
    
} //informationScreen

informationScreen.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the Information Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnInfo.Exists;  //Return whether mainScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

informationScreen.prototype.GetDBVersion = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetDBVersion()
  
  Description : This method returns the Current Version of the Connected DB 
  
  Output      : Returns the Current Version of the Connected DB 
-------------------------------------------------------------------------------*/  
  var DBVersionControlName = "labelVersion";
  this.GetText(DBVersionControlName);
      
} //GetDBVersion

informationScreen.prototype.GetUserTitle = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetUserTitle()
  
  Description : This method returns the Current User's Title 
  
  Output      : Returns the Current User's Title 
-------------------------------------------------------------------------------*/  
  var UserTitleControlName = "labelUser";
  this.GetText(UserTitleControlName);
      
} //GetUserTitle

informationScreen.prototype.GetUserRole = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetUserRole()
  
  Description : This method returns the Current User's Role 
  
  Output      : Returns the Current User's Role 
-------------------------------------------------------------------------------*/  
  var UserRoleControlName = "labelRole";
  this.GetText(UserRoleControlName);
      
} //GetUserRole

informationScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the information Screen 
  
  Output      : Returns the label of the given object in the information Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at informationScreen.Get"+objControlName+": The Main screen does not Exist.",
              message     : this.scrnInfo + " Screen does not Exist." }             
    
    return this.scrnInfo.WaitWinFormsObject("WinFormsControlName", objControlName, 1000).WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

informationScreen.prototype.VerifyVehicleCheckinInfo = function(iTicketNum){
/*------------------------------------------------------------------------------------------
  Method      : VerifyVehicleCheckinInfo()
  
  Description : This method returns vehicle information for given ticket number if exists on screen
  
  Output      : true/false
-------------------------------------------------------------------------------------------*/ 
  try {
  
    var objTable = Sys.Process("PosApplication").WinFormsObject("FormMain").WinFormsObject("ScreenInformation").WinFormsObject("activities").WinFormsObject("activities");
    var iItemCount = objTable.wItemCount;
    var vehicleData = {Color : null,Make : null,TicketNumber : null};

    if(iItemCount > 0)
       for(iCurrentItem=0;iCurrentItem<=iItemCount;iCurrentItem++) {
          if(aqString.Trim(objTable.wItem(iCurrentItem,3))=== iTicketNum){
             vehicleData.Color = aqString.Trim(objTable.wItem(iCurrentItem,1));
             vehicleData.Make = aqString.Trim(objTable.wItem(iCurrentItem,2));
             vehicleData.TicketNumber = aqString.Trim(objTable.wItem(iCurrentItem,3));
             break;
          }
       }
    return vehicleData; 
  }
  

  catch(exception) {
    TestLog.Message("Error in VerifyVehicleCheckinInfo method: "+ exception);
  }
}

informationScreen.prototype.VerifyTicketExists = function (iTicketNum) {  

/*------------------------------------------------------------------------------------------
  Method      : VerifyTicketExists()
  
  Description : This method verifies if ticket number exists or not
  
  Output      : true/false
-------------------------------------------------------------------------------------------*/  
  try {

    var VehicleInfo; 
    
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at informationScreen.VerifyTicketExists: The InformationScreen Screen does not Exist.",
              message     : this.scrnInfo + " Screen does not Exist." }             
    
    if (iTicketNum !== undefined && iTicketNum !== null) 
      VehicleInfo = this.VerifyVehicleCheckinInfo(iTicketNum);
      if(VehicleInfo.TicketNumber === iTicketNum){
      return true;      
      } else {
      return false;
      }

  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //VerifyTicketExists


function New() {

/*------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating informationScreen() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new informationScreen();  
}