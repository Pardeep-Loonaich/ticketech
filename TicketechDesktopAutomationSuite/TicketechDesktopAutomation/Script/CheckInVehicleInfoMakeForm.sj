//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT MakesPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInVehicleInfoMakeForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInVehicleInfoMakeForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInVehicleInfoMakeForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInVehicleInfoMakeForm() 
  
  Description: This method will Instantiate the CheckInVehicleInfoMakeForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmCheckInVehicleInfoMake =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehicleInfoMake", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objMakesPanel = MakesPanel.New();
  
  this.throwError = false; 
    
} //checkInVehicleInfoMakeForm


checkInVehicleInfoMakeForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInVehicleInfoMakeForm.  
  
  Output: True if form Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmCheckInVehicleInfoMake.Exists;  //Return whether frmCheckInVehicleInfoMake exists or not
    this.objMakesPanel = MakesPanel.New();
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInVehicleInfoMakeForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInVehicleInfoMakeForm();  
}