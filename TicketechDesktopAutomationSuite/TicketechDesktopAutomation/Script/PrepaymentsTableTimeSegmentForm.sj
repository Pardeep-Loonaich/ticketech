//USEUNIT Utility
//USEUNIT NavigationPanel
//USEUNIT GetTimeSegmentScreen

/*************************************************************************
            ---------- Class Definition ----------
  Name:PrepaymentsTableTimeSegmentForm
  
  Description: 
  
  This class has methods and properties to perform the PrepaymentsTableTimeSegmentForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function prepaymentsTableTimeSegmentForm() { 

/*--------------------------------------------------------------------- 
  Method: prepaymentsTableTimeSegmentForm() 
  
  Description: This method will the Instantiate the prepaymentsTableTimeSegmentForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.frmPrepaymentsTableTimeSegment =  Sys.Process("PosApplication").WaitWinFormsObject("FormPrepaymentsTableTimeSegment", 3000); 
  
  this.objGetTimeSegmentScreen = GetTimeSegmentScreen.New();
  this.objNavigationPanel = NavigationPanel.New();
  
  this.throwError = false; 
    
} //prepaymentsTableTimeSegmentForm

prepaymentsTableTimeSegmentForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the prepaymentsTableTimeSegmentForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.frmPrepaymentsTableTimeSegment =  Sys.Process("PosApplication").WaitWinFormsObject("FormPrepaymentsTableTimeSegment", 3000); 
  
    this.objGetTimeSegmentScreen = GetTimeSegmentScreen.New();
    this.objNavigationPanel = NavigationPanel.New();
        
    } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

prepaymentsTableTimeSegmentForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the prepaymentsTableTimeSegmentForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.frmPrepaymentsTableTimeSegment.Exists;  //Return whether prepaymentsTableTimeSegmentForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

prepaymentsTableTimeSegmentForm.prototype.EnterTimeSegment = function (timeSegment) {  

/*--------------------------------------------------------------------------
  Method      : EnterTimeSegment()
  
  Description : This method sets Start and End time and clicks Enter button  
  
  Output      : Enters start and end time if prepaymentsTableTimeSegment Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at prepaymentsTableTimeSegmentForm.EnterTimeSegment: The Prepayments Table Time Segment Form does not Exist.",
              message     : this.frmPrepaymentsTableTimeSegment + " The Prepayments Table Time Segment Form does not Exist." }             
    
    this.objGetTimeSegmentScreen.EnterTimeStart(timeSegment);
    Delay(1000);    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
    this.objGetTimeSegmentScreen.EnterTimeEnd(timeSegment);
    Delay(1000);    
    this.objNavigationPanel.ClickEnter();
    Delay(1000);
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //EnterTimeSegment


function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating prepaymentsTableTimeSegmentForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new prepaymentsTableTimeSegmentForm();  
}
