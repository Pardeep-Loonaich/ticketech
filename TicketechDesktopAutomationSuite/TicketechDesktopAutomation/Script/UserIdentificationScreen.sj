//USEUNIT Utility

/******************************************************************************
            ---------- Class Definition ----------
  Name:UserIdentificationScreen
  
  Description: 
  
  This class has methods and properties to perform the UserIdentificationScreen objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
*****************************************************************************/

function userIdentificationScreen() { 

/*------------------------------------------------------------------------------------ 
  Method: userIdentificationScreen() 
  
  Description: This method will the Instantiate the UserIdentificationScreen Wrapper Helper
------------------------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.scrnUserInfo =  Sys.Process("PosApplication").FindChild("WinFormsControlName", "ScreenUserIdentification", 3);
  
  this.throwError = false; 
    
} //userIdentificationScreen

userIdentificationScreen.prototype.Exists = function () {  

/*---------------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the userIdentificationScreen.  
  
  Output: True if Screen Exists
          False if Screen does not Exists   
----------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.scrnUserInfo.Exists;  //Return whether userIdentificationScreen exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

userIdentificationScreen.prototype.SetUsername = function (username) {  

/*-------------------------------------------------------------------------------
  Method      : SetUsername()
  
  Description : This method enters the Username in the User Identification screen
  
  Output      : Enters the Username in the User Identification screen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at userIdentificationScreen.SetUsername: The User Identification screen does not Exist.",
              message     : this.scrnUserInfo + " Screen does not Exist." }             
    
    if (username !== undefined && username !== null)
      this.scrnUserInfo.FindChild("Caption", "USERNAME", 1000).FindChild("WinFormsControlName","maskedTextBoxInfo",1000).Keys(username);
      
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetUserName

userIdentificationScreen.prototype.SetPassword = function (password) {  

/*-------------------------------------------------------------------------------
  Method      : SetPassword()
  
  Description : This method enters the Password in the User Identification screen
  
  Output      : Enters the Password in the User Identification screen
-------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at userIdentificationScreen.SetUsername: The User Identification screen does not Exist.",
              message     : this.scrnUserInfo + " Screen does not Exist." }             
    
    if (password !== undefined && password !== null)
      this.scrnUserInfo.FindChild("Caption", "PASSWORD", 1000).FindChild("WinFormsControlName","maskedTextBoxInfo",1000).Keys(password);
      
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //SetPassword

userIdentificationScreen.prototype.GetMessage = function () {  

/*------------------------------------------------------------------------------------
  Method      : GetMessage()
  
  Description : This method returns the message displayed in the user identification screen 
  
  Output      : Returns the the message displayed in the user identification screen 
-------------------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at UserIdentificationScreen.GetMessage: The Info screen does not Exist.",
              message     : this.scrnInfo + " Info does not Exist." }             
    
    return this.scrnUserInfo.WinFormsObject("screenInformationFooter")
              .WinFormsObject("labelInformation").WndCaption;
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //GetMessage

function New() {

/*------------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating userIdentificationScreen() class from other units of the project. 
------------------------------------------------------------------------------------------*/

  return new userIdentificationScreen();  
}