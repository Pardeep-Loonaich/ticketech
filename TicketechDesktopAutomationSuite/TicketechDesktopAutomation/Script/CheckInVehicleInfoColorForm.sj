//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT ColorPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:CheckInVehicleInfoColorForm
  
  Description: 
  
  This class has methods and properties to perform the CheckInVehicleInfoColorForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function checkInVehicleInfoColorForm() { 

/*--------------------------------------------------------------------- 
  Method: checkInVehicleInfoColorForm() 
  
  Description: This method will Instantiate the CheckInVehicleInfoColorForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmCheckInVehicleInfoColor =  Sys.Process("PosApplication").WaitWinFormsObject("FormCheckInVehicleInfoColor", 3000); 
  
  this.objInfoScreen = InformationScreen.New();
  this.objColorPanel = ColorPanel.New();
  
  this.throwError = false; 
    
} //checkInVehicleInfoColorForm


checkInVehicleInfoColorForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the checkInVehicleInfoColorForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmCheckInVehicleInfoColor.Exists;  //Return whether checkInVehicleInfoColorForm exists or not
    this.objColorPanel = ColorPanel.New();
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


checkInVehicleInfoColorForm.prototype.provideVehicleColor = function (sColor)   {  

/*-----------------------------------------------------------------
  Method      : provideVehicleColor()
  
  Description : This method will select vehicle color.  
     
-----------------------------------------------------------------*/ 
  try
  { 
  // Select vehicle color
  objColorPanel = ColorPanel.New();
  TestLog.Message("Selecting vehicle Color..");
  objColorPanel.SelectColor(sColor);
   
  } // End Try
  catch (exception) {
    for (prop in exception) 
    this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception;
    
  } //End catch 
   
} //provideVehicleColor


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating checkInVehicleInfoColorForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new checkInVehicleInfoColorForm();  
}