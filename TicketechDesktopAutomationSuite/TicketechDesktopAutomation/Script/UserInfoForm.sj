﻿//USEUNIT Utility
//USEUNIT InformationScreen
//USEUNIT UserIdentificationScreen
//USEUNIT NavigationPanel
//USEUNIT NumericPanel



/*************************************************************************
            ---------- Class Definition ----------
  Name:UserInfoForm
  
  Description: 
  
  This class has methods and properties to perform the UserInfoForm objects. 
  Instance of the class can be created by calling the constructor. 
  To call it from other units used New()method.  
**************************************************************************/

function userInfoForm() { 

/*--------------------------------------------------------------------- 
  Method: userInfoForm() 
  
  Description: This method will the Instantiate the userInfoForm Wrapper
---------------------------------------------------------------------*/   
  this.lastError = {};
  
  this.dlgUserInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormUserInfo*", 3000); 
  
  this.infoScreen = InformationScreen.New();
  this.userInfoScreen = UserIdentificationScreen.New();
  this.navigationPanel = NavigationPanel.New();
  this.numericPanel = NumericPanel.New();
  
  this.throwError = false; 
    
} //userInfoForm

userInfoForm.prototype.Refresh = function () {  

/*-------------------------------------------------------------------------------
  Method      : Refresh()
  
  Description : This method will the re-instantiate the userInfoForm Wrapper   
--------------------------------------------------------------------------------*/  
  try {
//    Sys.Refresh();
//    Delay(1000);
//    
    this.dlgUserInfo =  Sys.Process("PosApplication").WaitWinFormsObject("FormUserInfo*", 3000); 
  
    this.infoScreen = InformationScreen.New();
    this.userInfoScreen = UserIdentificationScreen.New();
    this.navigationPanel = NavigationPanel.New();
    this.numericPanel = NumericPanel.New();
        
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Refresh

userInfoForm.prototype.Exists = function () {  

/*-----------------------------------------------------------------
  Method      : Exists()
  
  Description : This method checks the existance of the userInfoForm.  
  
  Output: True if dialog Exists
          False if dialog does not Exists   
-----------------------------------------------------------------*/  
  try {
  
    this.lastError = {};

    return this.dlgUserInfo.Exists;  //Return whether userInfoForm exists or not
  
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //Exists

userInfoForm.prototype.InputAndSubmitForm = function (username,password) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitForm()
  
  Description : This method enters Username and Password 
  
  Output      : Enters Username and Password if UserInfo Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.lastError = {};
    
    if (!this.Exists())
      throw { name        : "Wrapper Exception",
              description : "Error at userInfoForm.InputAndSubmitForm: The User Info Form does not Exist.",
              message     : this.dlgUserInfo + " The User Info Form does not Exist." }             
    
    this.userInfoScreen.SetUsername(username);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
    this.Refresh();
    
    this.userInfoScreen.SetPassword(password);
    Delay(1000);
    
    this.navigationPanel.ClickEnter();
    Delay(1000);
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitForm

userInfoForm.prototype.InputAndSubmitFormWithErrors = function (username,password) {  

/*--------------------------------------------------------------------------
  Method      : InputAndSubmitFormWithErrors()
    
  Description : This method enters Username and Password 
  
  Output      : Enters Username and Password if UserInfo Form Exists
--------------------------------------------------------------------------*/  
  try {
  
    this.InputAndSubmitForm(username,password);
    Delay(1000);
    
    this.Refresh();
    Delay(1000);
    
    return this.userIdentificationScreen.GetMessage();
    
  } //End try
  
  catch (exception) {
    for (prop in exception) this.lastError[prop] = exception[prop];
    if (this.throwError) throw exception
  } //End catch
      
} //InputandSubmitFormWithErrors

function New() {

/*------------------------------------------------------------------------------------ 
  Method: New() 
  
  Description:
  This method is for instantiating userInfoForm() class from other units of the project. 
------------------------------------------------------------------------------------*/

  return new userInfoForm();  
}