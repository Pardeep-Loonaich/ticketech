//USEUNIT UserInfoForm
//USEUNIT MainDialog
//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT TimekeeperMenuForm
//USEUNIT EmployeeEnrollmentMenuForm
//USEUNIT EmployeeEnrollmentInfoForm
//USEUNIT EmployeeEnrollmentTypeForm
//USEUNIT FingerPrintForm


function TC_TKM_ACCESS_001() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_001 : Validate that the user whose role is mapped to Timekeeper feature (ADMINSTRATOR) is able to view and perform Timekeeper Menu Features successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var userInfo; //Stores the instance of Employee Info Screen
  var frmTimekeeperMenu;//Stores the instance of TimekeeperMenu Screen
  var frmEmployeeEnroll;//Stores the instance of EmployeeEnrollmentMenu Screen
  var screenTitle;
  var DBConnection;//Stores the instance of DBConnection
  var objADODriver;//Stores the current DB Driver
  
  DBConnection = DBUtility.New();
   
    //Test Data Setup:
    try {
   
      query = "SELECT TOP 1 UserName, UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
               +" AND  RU.RoleGUID IN ( Select DISTINCT RF.RoleGUID"
		              +" FROM RolesFeatures  RF WHERE RF.FeatureGUID IN (SELECT DISTINCT FeatureGUID FROM Features" 
                    +"  WHERE FeatureDescription IN ('CreateEmployee','Employee Enrollment')))";
      Log.Message(query);
      objADODriver = DBConnection.ExecuteQuery(query);
      objADODriver.First();
      
      if(!objADODriver.EOF) { 
      
        objTestData = {
                        username : objADODriver.FieldByName("UserName").Value.toString()
                       ,password : objADODriver.FieldByName("UserPassword").Value.toString()                                           
                      };
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into user info screen and submit username and password
      //--------------------------------------------------------------------
      home.NavigateToUserInfoScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Log In button.");
      
      //Initialize object of UserInfoScreen 
      userInfo = UserInfoForm.New();
     
      
      //Set data in Employee ID field and click Enter button from Navigation panel
      userInfo.InputAndSubmitForm(objTestData.username,objTestData.password);
      if (userInfo.lastError.name !== undefined) throw userInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to User Info screen and Logged in as"+objTestData.username);
      home = MainDialog.New();
      home.NavigateToTimeKeeperMenu();
    
      if (home.lastError.name !== undefined) throw home.lastError;
      TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
      //Initialize object of TimekeeperMenuScreen 
      frmTimekeeperMenu = TimekeeperMenuForm.New();
      
      frmTimekeeperMenu.NavigateToEnrollmentForm();
      if (frmTimekeeperMenu.lastError.name !== undefined) throw frmTimekeeperMenu.lastError;
      
      TestLog.Message("Step-4: Clicked Enrollment option button.");
      
      //Initialize object of EmployeeEnrollmentMenuScreen 
      frmEmployeeEnroll = EmployeeEnrollmentMenuForm.New();
    
      
      TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");
      //Verification : To verify whether the expected title is displayed
      //-----------------------------------------------------------------~
   
      screenTitle = frmEmployeeEnroll.sTitle;
        if(screenTitle === "EMPLOYEE ENROLLMENT")
          TestLog.Pass("TestCase Passed. Navigated to EmployeeEnrollmentMenu Form");
        else
         TestLog.Fail("TestCase Failed. Failed to Navigate to EmployeeEnrollmentMenu Form");
      //Checks the title
    }
    else
      TestLog.Error("No Test Data available!!!");
  }
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    DBConnection.close();
    Log.PopLogFolder();
  } //End finally 
  
  //Disposing objects 
  home = null;
  userInfo = null;
  frmTimekeeperMenu = null;
  frmEmployeeEnroll = null;

}


function TC_TKM_ACCESS_002() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_002 : Validate that the user whose role is NOT mapped to Timekeeper feature, the Timekeeper Menu Features is not available
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var userInfo; //Stores the instance of Employee Info Screen
  var frmTimekeeperMenu;//Stores the instance of TimekeeperMenu Screen
  var frmEmployeeEnroll;//Stores the instance of EmployeeEnrollmentMenu Screen
  var screenTitle;
   var DBConnection;//Stores the instance of DBConnection
  var objADODriver;//Stores the current DB Driver
  
  DBConnection = DBUtility.New();
   
    //Test Data Setup:
    try {
   
      query = "SELECT UserName, UserPassword FROM Users U, RolesUsers RU WHERE U.UserGUID = RU.UserGUID"
                +" AND  RU.RoleGUID IN ( Select RF1.RoleGUID FROM RolesFeatures  RF1"
		            +" LEFT JOIN RolesFeatures RF2 ON RF1.RoleGUID = RF2.RoleGUID" 
		            +" AND RF2.FeatureGUID IN (Select Distinct FeatureGUID from Features where FeatureDescription IN ('CreateEmployee','Employee Enrollment'))"
		            +" WHERE RF1.FeatureGUID = (Select Distinct FeatureGUID from Features where FeatureDescription IN ('Timekeeper Menu'))"
		            +" AND   RF2.RoleGUID IS NULL)";
                
      Log.Message(query);
      objADODriver = DBConnection.ExecuteQuery(query);
      objADODriver.First();
      
      if(!objADODriver.EOF) { 
      
        objTestData = {
                        username : objADODriver.FieldByName("UserName").Value.toString()
                       ,password : objADODriver.FieldByName("UserPassword").Value.toString()                                           
                      };
     
      //Step-1: Launching the POS application and Initialize the home screen
      //--------------------------------------------------------------------
      Utility.launchApp();
      home = MainDialog.New();
      
      //Step-2: Navigate into user info screen and submit username and password
      //--------------------------------------------------------------------
      home.NavigateToUserInfoScreen();
      if (home.lastError.name !== undefined) throw home.lastError;
      
      TestLog.Message("Step-1: Clicked Log In button.");
      
      //Initialize object of UserInfoScreen 
      userInfo = UserInfoForm.New();
     
      //Set data in Employee ID field and click Enter button from Navigation panel
      userInfo.InputAndSubmitForm(objTestData.username,objTestData.password);
      if (userInfo.lastError.name !== undefined) throw userInfo.lastError;
      
      TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username+" with pass "+objTestData.password);
      home = MainDialog.New();
      
      if(!home.NavigateToTimeKeeperMenu()) {
        TestLog.Pass("TestCase Passed. Timekeeper Menu not available for user "+objTestData.username+ " who is not mapped to Any TKM Feature");
      }
        
      else {
        if (home.lastError.name !== undefined) throw home.lastError;
        TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
        //Initialize object of TimekeeperMenuForm 
        frmTimekeeperMenu = TimekeeperMenuForm.New();
        
        if (!frmTimekeeperMenu.NavigateToEnrollmentForm()) {
          TestLog.Pass("TestCase Passed. Employee Enrollment not available for user "+objTestData.username+ " who is not mapped to Enrollment TKM Feature");
        }
        else {
          if (frmTimekeeperMenu.lastError.name !== undefined) throw frmTimekeeperMenu.lastError;
          TestLog.Fail("TestCase Failed. Employee Enrollment available for user "+objTestData.username+ " who is not mapped to Enrollment TKM Feature");
        }
       }
      }//End Try
    else
      TestLog.Error("No Test Data available!!!");
  }
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } 
  
  finally {
    //Close the POS Application
    Utility.closePOSProcess();  
    DBConnection.close();
    Log.PopLogFolder();
  } //End finally 
  
  //Disposing objects 
  home = null;
  userInfo = null;
  frmTimekeeperMenu = null;
  frmEmployeeEnroll = null;

}

function TC_TKM_ACCESS_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_004 : Validate that the user whose role is mapped to Timekeeper feature (ADMINISTRATOR) is able to view and perform Timekeeper Menu Features successfully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var userInfo; //Stores the instance of Employee Info Screen
  var frmTimekeeperMenu;//Stores the instance of TimekeeperMenu Screen
  var frmEmployeeEnrollMenu;//Stores the instance of EmployeeEnrollmentMenu Screen
  var frmEmployeeEnrollInfo;//Stores the instance of EmployeeEnrollmentInfo Screen
  var frmEmployeeEnrollType;//Stores the instance of EmployeeEnrollmentType Screen
  var screenTitle;
  var objTestData = {sEmpId : null, sFirstName : null, sLastName : null, iSSNum : null, sBirthDate: null, username : "ADMINISTRATOR" , password : "POSTICKETECH"};
  
  var DBConnection = DBUtility.New(); 
      
  try {
  
    //Data Generator
    objTestData.sEmpId = "E"+Utility.getRandomValue("NUMERIC",6);
    TestLog.Message("The employee ID is"+objTestData.sEmpId);
    objTestData.sFirstName = Utility.getRandomString(["FLASH","DANIEL","PETER","SPIDER","HARRY","MARY","MAY","BEN"]);
    objTestData.sLastName  = Utility.getRandomString(["THOMPSON","CRAIG","PARKER","OSBORNE","JANE","MORGAN","ROOT","STOKES"]);
    objTestData.iSSNum     = Utility.getRandomValue("NUMERIC",9);
    objTestData.sBirthDate = "12121983";     
    TestLog.Message("The employee ID is "+objTestData.sEmpId+ " " +objTestData.sFirstName+ " " +objTestData.sLastName);
  
    //Step-1: Launching the POS application and Initialize the home screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    home = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    home.NavigateToUserInfoScreen();
    if (home.lastError.name !== undefined) throw home.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    userInfo = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    userInfo.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (userInfo.lastError.name !== undefined) throw userInfo.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as"+objTestData.username);
    home = MainDialog.New();
    
    home.NavigateToTimeKeeperMenu();
    if (home.lastError.name !== undefined) throw home.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
    //Initialize object of TimekeeperMenuForm 
    frmTimekeeperMenu = TimekeeperMenuForm.New();
      
    frmTimekeeperMenu.NavigateToEnrollmentForm();
    if (frmTimekeeperMenu.lastError.name !== undefined) throw frmTimekeeperMenu.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Initialize object of EmployeeEnrollmentMenuForm
    frmEmployeeEnrollMenu = EmployeeEnrollmentMenuForm.New();
    
    frmEmployeeEnrollMenu.NavigateToAddEmployeeForm();
    if (frmEmployeeEnrollMenu.lastError.name !== undefined) throw frmEmployeeEnrollMenu.lastError;  
      
    TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");
    
    //Initialize object of EmployeeEnrollmentInfoForm 
    frmEmployeeEnrollInfo = EmployeeEnrollmentInfoForm.New();
    
    frmEmployeeEnrollInfo.InputAndSubmitForm(objTestData);
    if (frmEmployeeEnrollInfo.lastError.name !== undefined) throw frmEmployeeEnrollInfo.lastError;  
      
    TestLog.Message("Step-6: Navigated to EmployeeEnrollmentInfo Form.");
    
    //Initialize object of EmployeeEnrollmentTypeForm 
    frmEmployeeEnrollType = EmployeeEnrollmentTypeForm.New();
    
    frmEmployeeEnrollType.CancelForm();
    if (frmEmployeeEnrollType.lastError.name !== undefined) throw frmEmployeeEnrollType.lastError;  
      
    TestLog.Message("Step-7: Navigated to EmployeeEnrollmentType Form.");
    
    //DB Verification
    
    try {
         
      query = "SELECT EmployeeID, EmployeeLastName FROM Employees WHERE EmployeeID =\'"+objTestData.sEmpId+"\'";
      objADODriver = DBConnection.ExecuteQuery(query);
      objADODriver.First();
      
      while (!objADODriver.EOF)
      { 
        if(objADODriver.FieldByName("EmployeeID").Value == objTestData.sEmpId && objADODriver.FieldByName("EmployeeLastName").Value == objTestData.sLastName)  {
          TestLog.Pass("Test Passed. The employee " +objTestData.sEmpId + " details are added successfully") ;
        break;
        } 
        else  {
          TestLog.Fail("Test Failed. The employee " +objTestData.sEmpId + " details are not added") ;
        }
      }}
   catch(exception){
      TestLog.Error(exception.description, Utility.formattedException(exception));
   }
     
    } //End try    
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  home = null;
  userInfo = null;
  frmTimekeeperMenu = null;
  frmEmployeeEnroll = null;
  DB

}


function TC_TKM_ENR_003() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ENR_003: Verify that an existing employee details can be modified and saved succesfully via CORRECT button in Enrollment Menu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var userInfo; //Stores the instance of Employee Info Screen
  var frmTimekeeperMenu;//Stores the instance of TimekeeperMenu Screen
  var frmEmployeeEnrollMenu;//Stores the instance of EmployeeEnrollmentMenu Screen
  var frmEmployeeEnrollInfo;//Stores the instance of EmployeeEnrollmentInfo Screen
  var frmEmployeeEnrollType;//Stores the instance of EmployeeEnrollmentType Screen
  var screenTitle;
  var empCurrentData;
  var objTestData = {sEmpId : "E943176", sFirstName : null, sLastName : null, iSSNum : null, sBirthDate: null, username : "ADMINISTRATOR" , password : "POSTICKETECH"};
   
  try {
  
    //Data Generator
    objTestData.sFirstName = Utility.getRandomString(["FLASH","DANIEL","PETER","SPIDER","HARRY","MARY","MAY","BEN"]);
    objTestData.sLastName  = Utility.getRandomString(["THOMPSON","CRAIG","PARKER","OSBORNE","JANE","MORGAN","ROOT","STOKES"]);
    objTestData.iSSNum     = Utility.getRandomValue("NUMERIC",9);
    objTestData.sBirthDate = "12121983";     
    TestLog.Message("The employee ID is "+objTestData.sEmpId+ " " +objTestData.sFirstName+ " " +objTestData.sLastName);
  
    //Step-1: Launching the POS application and Initialize the home screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    home = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    home.NavigateToUserInfoScreen();
    if (home.lastError.name !== undefined) throw home.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    userInfo = UserInfoForm.New(); 
      
    //Set data in Username and Password field and click Enter button from Navigation panel
    userInfo.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (userInfo.lastError.name !== undefined) throw userInfo.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    home = MainDialog.New();
    
    home.NavigateToTimeKeeperMenu();
    if (home.lastError.name !== undefined) throw home.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
    //Initialize object of TimekeeperMenuForm 
    frmTimekeeperMenu = TimekeeperMenuForm.New();
      
    frmTimekeeperMenu.NavigateToEnrollmentForm();
    if (frmTimekeeperMenu.lastError.name !== undefined) throw frmTimekeeperMenu.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Initialize object of EmployeeEnrollmentMenuForm
    frmEmployeeEnrollMenu = EmployeeEnrollmentMenuForm.New();
    
    empCurrentData = frmEmployeeEnrollMenu.NaviagteToUpdateEmployeeDataForm(objTestData.sEmpId);   
    if (frmEmployeeEnrollMenu.lastError.name !== undefined) throw frmEmployeeEnrollMenu.lastError;  
      
    TestLog.Message("Step-5: Navigated to EmployeeEnrollmentMenu Form.");
    
    //Initialize object of EmployeeEnrollmentInfoForm 
    frmEmployeeEnrollInfo = EmployeeEnrollmentInfoForm.New();
    
    frmEmployeeEnrollInfo.UpdateAndSubmitForm(objTestData);
    if (frmEmployeeEnrollInfo.lastError.name !== undefined) throw frmEmployeeEnrollInfo.lastError;  
      
    TestLog.Message("Step-6: Navigated to EmployeeEnrollmentInfo Form.");
    TestLog.Pass("The employee details are updated");
    } //End try    
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  home = null;
  userInfo = null;
  frmTimekeeperMenu = null;
  frmEmployeeEnroll = null;

}

function TC_TKM_ENR_004() {
  
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_TKM_ACCESS_004 : Verify that an existing employee's punch in option can be modified via Correct Enrollment  (Change Enrollment to Fingerprint)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var home; //Stores the instance of home screen
  var userInfo; //Stores the instance of Employee Info Screen
  var frmTimekeeperMenu;//Stores the instance of TimekeeperMenu Screen
  var frmEmployeeEnrollMenu;//Stores the instance of EmployeeEnrollmentMenu Screen
  var frmEmployeeEnrollInfo;//Stores the instance of EmployeeEnrollmentInfo Screen
  var frmEmployeeEnrollType;//Stores the instance of EmployeeEnrollmentType Screen
  var frmFingerPrint;//Stores the instance of FingerPrint Screen
  var screenTitle;
  var objTestData = {sEmpId : "E943176", username : "ADMINISTRATOR" , password : "POSTICKETECH"};
   
  try {
  
    //Step-1: Launching the POS application and Initialize the home screen
    //--------------------------------------------------------------------
    Utility.launchApp();
    home = MainDialog.New();
      
    //Step-2: Navigate into user info screen and submit username and password
    //--------------------------------------------------------------------
    home.NavigateToUserInfoScreen();
    if (home.lastError.name !== undefined) throw home.lastError;
      
    TestLog.Message("Step-1: Clicked Log In button.");
      
    //Initialize object of UserInfoForm 
    userInfo = UserInfoForm.New();
        
    //Set data in Username and Password field and click Enter button from Navigation panel
    userInfo.InputAndSubmitForm(objTestData.username,objTestData.password);
    if (userInfo.lastError.name !== undefined) throw userInfo.lastError;
      
    TestLog.Message("Step-2: Navigated to User Info screen and Logged in as "+objTestData.username);
    home = MainDialog.New();
    
    //Step-3: Navigate into TimeKeeper screen by clicking Timekeeper Menu button
    //--------------------------------------------------------------------------
    home.NavigateToTimeKeeperMenu();
    if (home.lastError.name !== undefined) throw home.lastError;
    
    TestLog.Message("Step-3: Navigated to Time Keeper screen"); 
      
    //Initialize object of TimekeeperMenuForm 
    frmTimekeeperMenu = TimekeeperMenuForm.New();
    
    //Step-4:  Navigate into Employee Enrollment Menu screen by clicking Enrollemnt  button
    //--------------------------------------------------------------------------------------
      
    frmTimekeeperMenu.NavigateToEnrollmentForm();
    if (frmTimekeeperMenu.lastError.name !== undefined) throw frmTimekeeperMenu.lastError;
      
    TestLog.Message("Step-4: Clicked Enrollment option button.");
      
    //Initialize object of EmployeeEnrollmentMenuForm
    frmEmployeeEnrollMenu = EmployeeEnrollmentMenuForm.New();
    
    frmEmployeeEnrollMenu.NavigateToCorrectEnrollmentForm(objTestData.sEmpId);
    if (frmEmployeeEnrollMenu.lastError.name !== undefined) throw frmEmployeeEnrollMenu.lastError;
    
    TestLog.Message("Step-3: Navigated to Employee Enrollment Type screen"); 
      
    //Initialize object of EmployeeEnrollmentTypeForm 
    frmEmployeeEnrollType = EmployeeEnrollmentTypeForm.New();
    frmEmployeeEnrollType.SelectFingerPrintType();
       
    if (frmEmployeeEnrollType.lastError.name !== undefined) throw frmEmployeeEnrollType.lastError;  
      
    TestLog.Message("Step-5: Navigated to Finger Print Form.");
    
     // Navigate into Finger Print screen 
      //-------------------------------------------
      
      //Initialize object of FingerPrintForm
      frmFingerPrint = FingerPrintForm.New();
      
      screenTitle = frmFingerPrint.sTitle;
      if(screenTitle === "CAPTURE FINGERPRINT")
        TestLog.Pass("TestCase Passed. Navigated to FingerPrint Form");
      else
        TestLog.Fail("TestCase Failed. Failed to Navigate to FingerPrint Form");
      //Checks the title
      
    } //End try    
        
  catch(exception) {
    TestLog.Error(exception.description, Utility.formattedException(exception));
  } //End catch
    
  finally {
    //Close the POS Application
    Utility.closePOSProcess(); 
    Log.PopLogFolder();
  } //End finally
    
  //Disposing objects 
  home = null;
  userInfo = null;
  frmTimekeeperMenu = null;
  frmEmployeeEnroll = null;

}
