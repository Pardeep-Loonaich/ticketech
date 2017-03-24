//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:GetTimeSegmentScreen
  
  Description: 
  
  This class has methods and properties to perform the GetTimeSegmentScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function getTimeSegmentScreen() { 

/*----------------------------------------------------------------------------------- 
  Method: getTimeSegmentScreen() 
  
  Description: This method will the Instantiate the getTimeSegmentScreen Wrapper Helper
-----------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnGetTimeSegment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenGetTimeSegment", 3);
  this.throwError = false; 
    
} //reservationsMenuScreen

getTimeSegmentScreen.prototype.Exists = function () {  

/*-------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the Get Time Segment Screen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnGetTimeSegment.Exists;  //Return whether getTimeSegmentScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

getTimeSegmentScreen.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method refresh the objects of the Get Time Segment Screen.  
  
  Output:   
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    this.scrnGetTimeSegment =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenGetTimeSegment", 3);
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh


getTimeSegmentScreen.prototype.EnterTimeStart = function (objTestData) {  

/*-------------------------------------------------------------------------------
  Method      : EnterTimeStart()
  
  Description : This method enters start time on the Get Time Segment Screen 
  
  Output      : This method enters start time on the Get Time Segment Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at getTimeSegmentScreen "+objTestData.starttime+": The Get Time Segment screen does not Exist.",
              message     : this.scrnGetTimeSegment + " Screen does not Exist." }             
    
    this.scrnGetTimeSegment.WinFormsObject("selectableTextBoxTimeStart").WinFormsObject("maskedTextBoxInfo").Keys(objTestData.starttime);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterTimeStart

getTimeSegmentScreen.prototype.EnterTimeEnd = function (objTestData) {  

/*-------------------------------------------------------------------------------
  Method      : EnterTimeEnd()
  
  Description : This method enters start time on the Get Time Segment Screen 
  
  Output      : This method enters start time on the Get Time Segment Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at getTimeSegmentScreen "+objTestData.endtime+": The Get Time Segment screen does not Exist.",
              message     : this.scrnGetTimeSegment + " Screen does not Exist." }             
    
    this.scrnGetTimeSegment.WinFormsObject("selectableTextBoxTimeEnd").WinFormsObject("maskedTextBoxInfo").Keys(objTestData.endtime);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterTimeEnd



getTimeSegmentScreen.prototype.GetFooterMessage = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetFooterMessage()
  
  Description : This method returns the current Footer Message in the Get Time Segment screen
  
  Output      : Returns the current Footer Message in the Get Time Segment screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at getTimeSegmentScreen.GetFooterMessage: The Get Time Segment screen does not Exist.",
              message     : this.scrnGetTimeSegment + " Screen does not Exist." }             
        
    return this.scrnGetTimeSegment.WinFormsObject("screenInformationFooter").WinFormsObject("labelInformation").WndCaption;
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetFooterMessage

function New() {

/*------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating getTimeSegmentScreen() class from other units of the project. 
-------------------------------------------------------------------------------------------*/

  return new getTimeSegmentScreen();  
}