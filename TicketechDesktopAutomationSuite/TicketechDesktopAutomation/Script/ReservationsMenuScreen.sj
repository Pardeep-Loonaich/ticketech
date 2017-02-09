//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:ReservationsMenuScreen
  
  Description: 
  
  This class has methods and properties to perform the ReservationsMenuScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function reservationsMenuScreen() { 

/*----------------------------------------------------------------------------------- 
  Method: reservationsMenuScreen() 
  
  Description: This method will the Instantiate the reservationsMenuScreen Wrapper Helper
-----------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnReservationMenu =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenReservationsMenu", 2);
  this.throwError = false; 
    
} //reservationsMenuScreen

reservationsMenuScreen.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the Reservations Menu Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnReservationMenu.Exists;  //Return whether reservationsMenuScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


reservationsMenuScreen.prototype.GetTitleLabel = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTitleLabel()
  
  Description : This method returns the Reservation's Menu screen Title 
  
  Output      : Returns the Reservation's Menu screen Title 
-------------------------------------------------------------------------------*/  
  var UserTitleControlName = "labelTitle";
  return this.GetText(UserTitleControlName);
      
} //GetTitleLabel


reservationsMenuScreen.prototype.GetText = function (objControlName) {  

/*-------------------------------------------------------------------------------
  Method      : GetText()
  
  Description : This method returns the label of the given objControlName in the Reservations Menu Screen 
  
  Output      : Returns the label of the given object in the Reservations Menu Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at reservationsMenuScreen.Get"+objControlName+": The Reservations Menu screen does not Exist.",
              message     : this.scrnReservationMenu + " Screen does not Exist." }             
    
    return this.scrnMain.WaitWinFormsObject("WinFormsControlName", objControlName, 1000).Text;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetText

function New() {

/*------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating reservationsMenuScreen() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new reservationsMenuScreen();  
}