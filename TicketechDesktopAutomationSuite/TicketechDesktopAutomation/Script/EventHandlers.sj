//USEUNIT Utility

function OnStart(Sender){

  if(Project.TestItems.Current != undefined && Project.TestItems.Current.Name == "Execute Next Suite")
    return;

  //Gets Start time of the project
  ProjectSuite.Variables.StartTime = aqConvert.DateTimeToStr(aqDateTime.Now());  
}

function OnStop(Sender) { 
  //Calculates time difference and logs
  ProjectSuite.Variables.EndTime = aqConvert.DateTimeToStr(aqDateTime.Now()); 
  var timeDiff = aqDateTime.TimeInterval(aqConvert.StrToDateTime(ProjectSuite.Variables.StartTime), aqConvert.StrToDateTime(ProjectSuite.Variables.EndTime))
  var statisticsObj = {
                         StartTime : aqConvert.DateTimeToStr(ProjectSuite.Variables.StartTime),
                         EndTime : aqConvert.DateTimeToStr(ProjectSuite.Variables.EndTime),
                         TimeDiff : aqConvert.TimeIntervalToStr(timeDiff),
                         infoLog : "",
                         EventLogStatus : ""
                     };
  
  TestLog.Statistics(statisticsObj);
  Log.UnlockEvents();
  
  if(Project.TestItems.Current != undefined)//If it is a Project lever or suite level run
    Log.SaveResultsAs(ProjectSuite.Path + "Log\\"+ Project.TestItems.Current.Name+ ProjectSuite.Variables.TestCaseStatus + ".mht", 2, true, 2);//Export the Log to 'Log' Folder
  
  ProjectSuite.Variables.StartTime = ""; 
  ProjectSuite.Variables.EndTime = ""; 
  ProjectSuite.Variables.TestCaseStatus = "";  
}

function OnUnexpectedWindow(Sender, Window, LogParams) {

  //TestLog.Warning("Unexpected Window appeared. Refer the attached screen shot");

}

function OnOverlappingWindow(Sender, Window, OverlappingWindow, LogParams) {
  
  Log.Picture(Sys.Desktop, "Overlapping Window. Refer the attached screen shot");
  OverlappingWindow.Minimize();
  Delay(5000);
  Window.SetFocus();
      
  if (OverlappingWindow.Focused && Sys.Desktop.ActiveWindow().Name === OverlappingWindow.Name) {
    TestLog.Warning("Unabled to minimize overlapping window. So closing it.");
    OverlappingWindow.Close();
    Delay(10000);
  }
        
}

function OnLogError(Sender, LogParams) {

  if (ProjectSuite.Variables.overrideMenuEvents) {  //supressing menu errors in log
    
    ProjectSuite.Variables.menuExists = true;
    ProjectSuite.Variables.menuEnabled = true
    var errorMsg = LogParams.Str;
    
    if (errorMsg.indexOf("not found") > 0 && errorMsg.indexOf("control item") > 0) {
      LogParams.Locked = true;
      ProjectSuite.Variables.menuExists = false;
    }
  
    if (errorMsg.indexOf("disabled") > 0 && errorMsg.indexOf("menu item") > 0) {
      LogParams.Locked = true;
      ProjectSuite.Variables.menuEnabled = false;
    }
       
  }  
  
  if (Project.Variables.VariableExists("SupressTreeViewErrors")) { //supressing tree view errors in log
  
    var errorMsg = LogParams.Str;

    if (errorMsg.indexOf("The TreeView node") >= 0 && errorMsg.indexOf("not found.") >= 0) {
      LogParams.Locked = true;
      Project.Variables.TreeNodeExists = false;
    }

  }
  
  if (Project.Variables.VariableExists("SupressWindowDisabledErrors")) { //supressing window disabled errors in log
  
    var errorMsg = LogParams.Str;

    if (errorMsg.indexOf("The window") >= 0 && errorMsg.indexOf("disabled") > 0) {
      LogParams.Locked = true;
      Project.Variables.WindowEnabled = false;
    }
      
  }
  
  if (Project.Variables.VariableExists("SupressTextBoxErrors")) { //supressing text box errors in log
  
    var errorMsg = LogParams.Str;

    if (errorMsg.indexOf("edit box") >= 0 || errorMsg.indexOf("read-only") > 0) {
      LogParams.Locked = true;
      Project.Variables.TextBoxEnabled = false;
    }
      
  }
  
  if (Project.Variables.VariableExists("SupressTabErrors")) { //supressing tab errors in log
  
    var errorMsg = LogParams.Str;

    if (errorMsg.indexOf("tab control") >= 0 || errorMsg.indexOf("did not change") > 0) {
      LogParams.Locked = true;
      Project.Variables.TabChanged = false;
    }
      
  }   
   
}
