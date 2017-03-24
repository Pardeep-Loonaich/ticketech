//USEUNIT Utility

/*************************************************************************************************************************************
---------------------------------------------------[[SCRIPT DEVELOPMENT CHRONICLE]]---------------------------------------------------
Unit Name   : ConfigUtility
Developed By       : TT Team ASPIRE
Description : This unit contains all functions related to TkPosXmlConfig application.
--------------------------------------------------------------------------------------------------------------------------------------
**************************************************************************************************************************************/

function LaunchTkPosxmlConfigApp(){
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: LaunchTkPosxmlConfigApp
  Description: Launches a instance of TkPosXmlConfig app
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  try {

    if(! Utility.appExists("TkPosXmlConfig")) {
    
      Indicator.PushText("Launching POSXmlConfig application...");
      TestedApps.TkPosXmlConfig.Run(); //Run the POSXmlConfig app
      Delay(5000, "The POSXmlConfig app is being launched");
    
      if(appExists("TkPosXmlConfig"))
        Log.Message("Launching POSXmlConfig app is successful.");
      else
        Log.Message("Launching POSXmlConfig app is unsuccessful.");
    }
  
    else  {
      Log.Message("The POSXmlConfig app is already running, closing app");
      closeApp("TkPosXmlConfig");
      Indicator.PushText("Launching POSXmlConfig application... again");
      TestedApps.TkPosXmlConfig.Run(); //Run the POSXmlConfig app
      Delay(5000, "The POSXmlConfig app is being launched");
    
      if(appExists("TkPosXmlConfig"))
        Log.Message("Launching POSXmlConfig app is successful.");
      else
        Log.Message("Launching POSXmlConfig app is unsuccessful.");
    }
  
  } //End try
  
  catch(exception) {
    throw exception;
  } //End catch

}


function SelectGarage(sLocID, sLocGUID){
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Function: SelectGarage
  Description: Selects the provided LocID and LocGUID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
  try{
    LaunchTkPosxmlConfigApp();
      
    objTkPosXmlConfigApp = Sys.Process("TkPosXmlConfig").WaitWinFormsObject("POSMachine",3000);
    // Set locationID
    objLocationID = objTkPosXmlConfigApp.FindChild("WinFormsControlName","cLocationID",12);
    objLocationID.Clear(); Delay(200)
    objLocationID.SetText(sLocID);
     
    Delay(1000);  
               
    // Set locationGUID
    objLocationGUID = objTkPosXmlConfigApp.FindChild("WinFormsControlName","cLocationGuid",12);
    objLocationGUID.Clear(); Delay(200);
    objLocationGUID.SetText(sLocGUID);
    
    Delay(2000); 
      
    LocGUIDLength = objTkPosXmlConfigApp.FindChild("WinFormsControlName","cLocationGuid",12).Text.length;
      
    if(LocGUIDLength !== 36){
      exception = { name       : "Data Exception"
                   ,description: "LocationGUID length should be 36 digits"
                   ,message    : "Configuration will fail if location ID is not set proper"}
      throw exception;
    }
      
    // Click Create String button
    objTkPosXmlConfigApp.FindChild("WinFormsControlName","btnCreateScript",12).ClickButton(); 
    Delay(1000); 
           
    // Click OK button
    Sys.Process("TkPosXmlConfig").WaitWindow("#32770", "", 1, 1000).Window("Button", "OK", 1).ClickButton();
      
    pnlSplitter = Sys.Process("TkPosXmlConfig").WinFormsObject("POSMachine").WinFormsObject("splitContainer1").WinFormsObject("SplitterPanel", "", 2).WinFormsObject("cSplit").WaitWinFormsObject("SplitterPanel", "", 2,1000)
      
    // Click Save button
    pnlSplitter.WinFormsObject("btnSave").ClickButton();
    // Click Yes button
    Sys.Process("TkPosXmlConfig").WaitWindow("#32770", "Saving Configuration", 1, 1000).Window("Button", "&Yes", 1).ClickButton();      
    // Click Exit button
    pnlSplitter.WinFormsObject("btnCancel").ClickButton();
    // click Ok button
    Sys.Process("TkPosXmlConfig").WaitWindow("#32770", "Exit Configuration", 1, 1000).Window("Button", "OK", 1).ClickButton();
  }// end try
    
  catch(exception){
    throw exception;
  }// End Catch 
  finally{
    if(appExists("TkPosXmlConfig"))    
        closeApp("TkPosXmlConfig");      
  }      
}



