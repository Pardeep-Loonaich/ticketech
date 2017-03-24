//USEUNIT Utility

/*******************************************************************************************
            ---------- Class Definition ----------
  Name:StayPriceScreen 
  
  Description: 
  
  This class has methods and properties to perform the StayPriceScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*******************************************************************************************/

function stayPriceScreen() { 

/*---------------------------------------------------------------------------------------------
  Method: stayPriceScreen() 
  
  Description: This method will the Instantiate the StayPriceScreen Wrapper Helper
----------------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnStayPrice =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenStayPrice", 2);
  
  this.throwError = false; 
    
} //stayPriceScreen

stayPriceScreen.prototype.Exists = function () {  

/*----------------------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the stayPriceScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
-----------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnStayPrice.Exists;  //Return whether stayPriceScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists


stayPriceScreen.prototype.GetTotalValue = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetTotalValue()
  
  Description : This method returns the total amount in the screenStayPrice Screen 
  
  Output      : Returns the total amount in the screenStayPrice Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at stayPriceScreen.GetTotalValue : The ScreenStayPrice screen does not Exist.",
              message     : this.scrnStayPrice + " ScreenStayPrice Screen does not Exist." }             
    
    return this.scrnStayPrice.FindChild("WinFormsControlName","dataGridView",4).wValue(2, 1);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetTotalValue

stayPriceScreen.prototype.GetRateType = function () {  

/*-------------------------------------------------------------------------------
  Method      : GetRateType()
  
  Description : This method returns the rate type in the screenStayPrice Screen 
  
  Output      : Returns the rate type in the screenStayPrice Screen 
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at stayPriceScreen.GetRateType : The ScreenStayPrice screen does not Exist.",
              message     : this.scrnStayPrice + " ScreenStayPrice Screen does not Exist." }             
    
    return  this.scrnStayPrice.WinFormsObject("selectableTextBoxRate").WinFormsObject("maskedTextBoxInfo").wText;
      
    } //End try 
    
   catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetRateType
   

function New() {

/*----------------------------------------------------------------------------------------------------- 
  Method: New() 
  
  Description:
  This method is for instantiating stayPriceScreen() class from other units of the project. 
------------------------------------------------------------------------------------------------------*/

  return new stayPriceScreen();  
}
