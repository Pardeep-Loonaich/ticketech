//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//Copyright © 2003-2009 M-Files, Inc. All rights reserved.
//Author: Aspire Test Automation Team                          
////[The next two values could be rendered redundant if this file is kept in Source control, as the SCM system would provide the information needed]
//Last Modified Date: 23rd / Mar / 2012
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//************************************************************************************
// Class Name: TestResultLogger
//
// Purpose : Creating customized results for all Test execution 
//
// Description :
//     This class is just a wrapper class to post message in the log in specific format.
//     this class contains only public methods like add module, add test case, add test data,
//     etc to post information in log in standard & consistent format. Also this class
//     helps to improve the readability of the scripts  
//
//************************************************************************************

function RGB(r, g, b)
{   
  return r | (g << 8) | (b << 16);
}
  
//**********************************************************************************
// Purpose: customize result will display all project level, 
//          which all are identified for execution
//           For each project level execution starts, this will 
//           add one project level in the results
// Inputs: AddProject(): currrent project name, which is going 
//          execute  
//**********************************************************************************
function AddProject(ProjectName) {  

	try {

		var LogAttr = Log.CreateNewAttributes();
		var MemCpuInfo = "";
		LogAttr.FontColor = RGB(0, 0, 0);
		LogAttr.BackColor = RGB(166, 202, 240);
		LogAttr.Bold = true;
		LogAttr.Italic = false;
    LogAttr.ExtendedMessageAsPlainText = false;
    MemCpuInfo = "";
    
		folderIDCurrentProject = Log.CreateFolder(ProjectName, MemCpuInfo, 300, LogAttr)
		Log.PushLogFolder(folderIDCurrentProject)
	
	}

	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.AddProject : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}
} //AddProject  
   
  
  //**********************************************************************************************
  // Purpose: customize result will display all suite level,which all are identified for execution
  //           For each suite level execution starts, this will add one suite level in the results
  // Inputs: AddSuite(): currrent suite name, which is going execute  
  // customization : All suite level results will automatically get added in the corresponding 
  //                 project level 
  //***********************************************************************************************
function AddTestPlan(SuiteName) {  

	try {
		
		var LogAttr = Log.CreateNewAttributes();
    var MemCpuInfo = "";                  
		LogAttr.FontColor = RGB(0, 0, 0);
		LogAttr.BackColor = RGB(196, 215, 215);
		LogAttr.Bold = true;
		LogAttr.Italic = false
		LogAttr.Underline = true;
    LogAttr.ExtendedMessageAsPlainText = false;
    Project.Variables.eventTime = "";
    MemCpuInfo = "";
     
		folderIDCurrentSuite = Log.CreateFolder("TestPlan:- " + SuiteName, MemCpuInfo, 300, LogAttr)
		Log.PushLogFolder(folderIDCurrentSuite)
	
	}
	catch(e) {
		Log.Warning("Exception at Script Extension->TestLog.TestPlan : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}
}
  
 
//**********************************************************************************************
// Purpose: customize result will display all TestCase level,which all are identified for execution
//           For each TestCase execution starts, this will add one TestCase in the results
// Inputs: AddTestCase(): TestCase id / Folder ID , TestCase Tittle ,Steps involved with 
//                        this test case,Execution result for the test case
// customization : All TestCase level results will automatically get added in the corresponding 
//                 Module level   
//***********************************************************************************************  
function AddTestCase(ID, Title, Steps, Result) {  
	
	try {

		var LogAttr, strRemarks; 
    var MemCpuInfo = ""; 
		LogAttr = Log.CreateNewAttributes();
		LogAttr.FontColor = RGB(0, 0, 0);
		LogAttr.BackColor = RGB(192, 220, 192);
		LogAttr.Bold = false;
		LogAttr.Italic = true;
    LogAttr.ExtendedMessageAsPlainText = false;
    Project.Variables.eventTime = "";
    Title = aqString.Replace(Title, "\n", "<br/>"); 
    Steps = aqString.Replace(Steps, "\n", "<br/>");
    Result = aqString.Replace(Result, "\n", "<br/>");

    strRemarks = "<html> <table border=\"1\" style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\"> TestCase Details </caption> <tr> <th width=150> Title </th> <th width=260> Description </th> <th width=160> Expected Result </th></tr>" +
                  "<tr> <td>" +  Title + "</td> <td>" + Steps + "</td> <td>" + Result + "</td></tr> </table> <br/></html>"
    
    MemCpuInfo = "";
    
    strRemarks = strRemarks + "\n\n\n" + MemCpuInfo;  
		folderIDCurrentTestCase = Log.CreateFolder("Test Case-" + ID + ": " + Title, strRemarks, 300, LogAttr)
		Log.PushLogFolder(folderIDCurrentTestCase)
   
	}
	catch(e) {
		Log.Warning("Exception at Script Extension->TestLog.addTestCase : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}

} //AddTestCase
  
//**********************************************************************************************
// Purpose: customize result will display all TestData used for executed TestCase               
// Inputs: LogTestDataInfo(): TestCase id / Folder ID , Record Set of Test Data
// customization : All LogTestDataInfo results will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************
  
function LogTestDataInfo(ID, colNames, colValues) { 

	try {
    
		var MemCpuInfo = "";
    LogAttr = Log.CreateNewAttributes();
		LogAttr.FontColor = RGB(0, 0, 0);
		LogAttr.BackColor = RGB(192, 192, 192);
		LogAttr.Bold = false
		LogAttr.Italic = true
    LogAttr.ExtendedMessageAsPlainText = false;
		strTestData = ""  

    StrTestData = "<html> <table border=\"1\" style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\"> TestData - " + VartoStr(ID) + " </caption>" +
                  "<tr> <th width=50 > S.No </th> <th width=150> Name </th> <th width=350> Value </th></tr>";
  
		if (colValues === undefined) {
			i = 0;
			for (prop in colNames)
			{
				StrTestData = StrTestData + "<tr> <td>" + (i + 1) + ") </td> <td>" + prop + "</td> <td>" + colNames[prop] + "</td></tr>"
				i++;
			}

	}
	else 	
		for (var i=0;i<colNames.length;i++)
      StrTestData = StrTestData + "<tr> <td>" + (i + 1) + ") </td> <td>" + colNames[i] + "</td> <td>" + colValues[i] + "</td></tr>";
      
    Project.Variables.eventTime = "";
    StrTestData = StrTestData + "</table> <br/> </html>"
	
    MemCpuInfo = "";
    
    StrTestData = StrTestData + "\n\n\n" + MemCpuInfo; 
	
	folderIDCurrentTestData = Log.CreateFolder("TestData-" + ID + ": ", StrTestData + "\n", 300, LogAttr)
	Log.PushLogFolder(folderIDCurrentTestData);
	 
	}
	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.addTestDataInfo : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	
	}

} //LogTestDataInfo

//**********************************************************************************************
// Purpose: customize result will display "Pass" for the executed TestCase               
// Inputs: LogPassResult(): Pass of the Testcase , Details about the Pass result
// customization : All Pass results will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************
function LogPassResult(Message, Comments, ImgPass) {  
	
	try {

		var LogAttr;
    var MemCpuInfo = "";
		if (Comments === undefined || Comments === null) Comments = "";
		LogAttr = Log.CreateNewAttributes();
		LogAttr.FontColor = RGB(0, 192, 0);
		LogAttr.BackColor = RGB(240, 244, 254);
		LogAttr.Bold = true;
		LogAttr.Italic = false;
    LogAttr.ExtendedMessageAsPlainText = false;
    
    MemCpuInfo = "";
          
    Comments = aqString.Replace(Comments, "\n", "<br/>");
    Comments = "<html> <table style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\">" + "" + " </caption>" +
                  "<tr> <td>" + Comments + "</td> </tr> </table> <br/> </html>";
      
    Comments = Comments + MemCpuInfo;
     if (ImgPass === undefined)
			Log.Message(Message, Comments + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr);
		else
			Log.Message(Message, Comments + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr, ImgPass);

    Project.Variables.eventTime = "";
    ProjectSuite.Variables.TestCaseStatus = ProjectSuite.Variables.TestCaseStatus + ",Pass";		

	}
	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.Pass : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}

} //LogPassResult
 
//**********************************************************************************************
// Purpose: customize result will display "Fail" for the executed TestCase               
// Inputs: LogFailResult(): Failure of the Testcase , Details about the Fail result
// customization : All Fail results will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************  
function LogFailResult(Message, Comments) {  
	
	try {

		var LogAttr, ImgFail;
    var MemCpuInfo = "";     
		if (Comments === undefined || Comments === null) Comments = "";
		LogAttr = Log.CreateNewAttributes();
		LogAttr.FontColor = RGB(255, 0, 0);
		LogAttr.BackColor = RGB(255, 255, 255);
		LogAttr.Bold = true;
		LogAttr.Italic = false;
    LogAttr.ExtendedMessageAsPlainText = false;

		ImgFail = Sys.Desktop.Picture();
    
    MemCpuInfo = "";
      
    Comments = aqString.Replace(Comments, "\n", "<br/>");
    Comments = "<html> <table style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\">" + "" + " </caption>" +
                  "<tr> <td>" + Comments + "</td> </tr> </table> <br/> </html>";
      
    Comments = Comments + MemCpuInfo;
      
		Log.Error(Message, Comments + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr, ImgFail)
		Project.Variables.eventTime = "";
		ImgFail = null
    ProjectSuite.Variables.TestCaseStatus = ProjectSuite.Variables.TestCaseStatus + ",Fail";
	}

	catch(e) {
		Log.Warning("Exception at Script Extension->TestLog.Fail : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}
} //Fail
  
//**********************************************************************************************
// Purpose: customize result will display "Message" for the executed TestCase               
// Inputs: LogMessage(): Message of the Testcase , Details about the Message 
// customization : All Message will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************
function LogMessage(Message, Comments, ImgMessage) {  
	
	try {
		
		var LogAttr = Log.CreateNewAttributes();
    var ImgMsg;
    var MemCpuInfo = "";
    LogAttr.ExtendedMessageAsPlainText = false;
     
	  if (Comments === undefined || Comments === null) Comments = "";
    
    MemCpuInfo = "";
    
    Comments = aqString.Replace(Comments, "\n", "<br/>");
    Comments = "<html> <table style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\">" + "" + " </caption>" +
                  "<tr> <td>" + Comments + "</td> </tr> </table> <br/> </html>";
                  
    Comments = Comments + MemCpuInfo;
    
    if (ImgMessage === undefined)
			Log.Message(Message, Comments  + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr);
		else
			Log.Message(Message, Comments  + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr, ImgMessage);

 Project.Variables.eventTime = "";

	}
	
	catch(e) {
		Log.Warning("Exception at Script Extension->TestLog.Message : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}

} //LogMessage

//**********************************************************************************************
// Purpose: customize result will display "Error" for the executed TestCase               
// Inputs: LogError(): Error of the Testcase , Details about the Error 
// customization : All Error will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************
function LogError(Message, Comments) {  

	try {

		var LogAttr = Log.CreateNewAttributes()
    var ImgErr;
    var MemCpuInfo = "";   
    LogAttr.ExtendedMessageAsPlainText = false;
    
		if (Comments === undefined || Comments === null) Comments = "";
    
    MemCpuInfo = "";
    
    Comments = aqString.Replace(Comments, "\n", "<br/>");
    Comments = "<html> <table style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\">" + "" + " </caption>" +
                  "<tr> <td>" + Comments + "</td> </tr> </table> <br/> </html>";
                  
    Comments = Comments + MemCpuInfo;
    
		ImgErr   = Sys.Desktop.Picture();
		Log.Error(Message, Comments + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr, ImgErr)
		Project.Variables.eventTime = "";
		ImgErr = null
    ProjectSuite.Variables.TestCaseStatus = ProjectSuite.Variables.TestCaseStatus + ",Error";
	
	}
	 catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.Error : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	 
	 }
	 
} //LogError

//**********************************************************************************************
// Purpose: customize result will display "Warning" for the executed TestCase               
// Inputs: LogWarning(): Warning of the Testcase , Details about the Warning 
// customization : All Warning will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************
function LogWarning(Message, Comments)  {  
	
	try {
		
    var LogAttr = Log.CreateNewAttributes();
    var ImgWar;
    var MemCpuInfo = "";
    LogAttr.ExtendedMessageAsPlainText = false;
		if (Comments === undefined || Comments === null) Comments = "";
    
    MemCpuInfo = "";
    
    Comments = aqString.Replace(Comments, "\n", "<br/>");
    Comments = "<html> <table style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\">" + "" + " </caption>" +
                  "<tr> <td>" + Comments + "</td> </tr> </table> <br/> </html>";
                  
    Comments = Comments + MemCpuInfo;
    
		ImgWar= Sys.Desktop.Picture();
		Log.Warning(Message, Comments + "<br/>" + aqString.Replace(Project.Variables.eventTime, "\n", "<br/>"), 300, LogAttr, ImgWar)
		Project.Variables.eventTime = "";
		ImgWar= null
    ProjectSuite.Variables.TestCaseStatus = ProjectSuite.Variables.TestCaseStatus + ",Warning";
	}
	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.AddSuite : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	 }
	 
} //LogWarning

//**********************************************************************************************
// Purpose: customize result will display "Event/Action" for the executed TestCase               
// Inputs: LogEvent(): Event/Action of the Testcase , Details about the Event/Action 
// customization : All Event/Action will automatically get added in the corresponding
//                 TestCase level   
//*********************************************************************************************
function LogEvent(Message, Comments) {  

	try {
		
		var LogAttr = Log.CreateNewAttributes();
    var ImgEvent;
    var MemCpuInfo = "";
    LogAttr.ExtendedMessageAsPlainText = false;
		if (Comments === undefined || Comments === null) Comments = "";
    
    MemCpuInfo = "";
      
    Comments = aqString.Replace(Comments, "\n", "<br/>");
    Comments = "<html> <table style=\"font-family:Courier New;font-size:12px;\" > <caption style=\"font-weight: bold; text-decoration:underline\">" + "" + " </caption>" +
                  "<tr> <td>" + Comments + "</td> </tr> </table> <br/> </html>";
                  
    Comments = Comments + MemCpuInfo;
		ImgEvent= Sys.Desktop.Picture()
		Log.Event(Message, Comments, 300, LogAttr, ImgEvent)
		ImgEvent= null
	
	}
	catch(e) {
		
		Log.Warning("Exception at Script Extension->TestLog.LogEvent : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}

} //LogEvent
  
function LogLink(Message ,strLink) {                                  
    
	try {
    
    var LogAttr = Log.CreateNewAttributes();
    var MemCpuInfo = "";
    LogAttr.ExtendedMessageAsPlainText = false;
    
    MemCpuInfo = "";
    
		Log.Link(strLink, Message, MemCpuInfo, 300, LogAttr, folderIDCurrentTestCase)     
	}
	 catch(e) {
		
		Log.Warning("Exception at Script Extension->TestLog.LogLink : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	 
	 }

}  // LogLink

function LogTime(StartTime, EndTime, TimeDiff) {  

	try {

		var LogAttr = Log.CreateNewAttributes();
		var MemCpuInfo = "";
		LogAttr.FontColor = RGB(100, 100, 100);
		LogAttr.BackColor = RGB(240, 248, 255);   
    LogAttr.Bold = true;
		LogAttr.Italic = false;
    LogAttr.ExtendedMessageAsPlainText = false;

		Log.Message("Start Time (mm/dd/yyyy HH:MM:SS) : " + StartTime, "",  300, LogAttr);
		Log.Message("End Time (mm/dd/yyyy HH:MM:SS)    : " + EndTime, "", 300, LogAttr);
		
    LogAttr.FontColor = RGB(0, 0, 0); 
    Log.Message("Time taken (dd:HH:MM:SS)                     : " + TimeDiff, "", 300, LogAttr);

	}

	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.LogTime : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}
  
} //LogTime

function LogStatisticsInfo(StatisticsObj){

  try {

		var LogAttr = Log.CreateNewAttributes();
		var logInfo = "";
		var MemCpuInfo = "";
    
    var StartTime = StatisticsObj.StartTime;
    var EndTime = StatisticsObj.EndTime;
    var TimeDiff = StatisticsObj.TimeDiff;
    var infoLog = StatisticsObj.infoLog;
    var EventLogStatus = StatisticsObj.EventLogStatus;
    
    EventLogStatus = aqString.Replace(EventLogStatus, "\n", "<br/>"); 
    
		LogAttr.FontColor = RGB(100, 100, 100);
		LogAttr.BackColor = RGB(166, 202, 240);    
    LogAttr.Bold = true;
		LogAttr.Italic = false;
    LogAttr.ExtendedMessageAsPlainText = false;

    MemCpuInfo = "";
                               
		folderIDCurrentProject = Log.CreateFolder("Log Statistics", MemCpuInfo, 300, LogAttr)
		Log.PushLogFolder(folderIDCurrentProject);
    
    LogAttr.BackColor = RGB(240, 248, 255);
		LogAttr.FontColor = RGB(0, 0, 0); 
    
    LogTime(StartTime, EndTime, TimeDiff); 
    logInfo = LogPlanStatus(infoLog);
    Log.Message("Log Results Details", logInfo, 300, LogAttr);
    
    if (EventLogStatus !== "" && EventLogStatus !== undefined && EventLogStatus !== null) {
      LogAttr.BackColor = RGB(240, 248, 255);
		  LogAttr.FontColor = RGB(220, 20, 60); 
      Log.Message("Windows Event Viewer - Error Logged Test case IDs.", EventLogStatus,300,LogAttr);
    }
    
    Log.PopLogFolder();

	}

	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.Statistics : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
	}
   
}

//**********************************************************************************************
// Purpose: Displays the executed plan results            
// Inputs: Null 
//***********************************************************************************************

function LogPlanStatus(infoLog) {

	try {

		var MemCpuInfo = "";
    var tc = 0; //Total number of cases executed
    var fc = 0; //Counts the total number of cases with fail result in a test plan
		var ec = 0; //Counts the total number of cases with error result in a test plan
		var pc = 0; //Counts the total number of cases with pass result in a test plan
		var wc = 0; //Counts the total number of cases with warning result in a test plan
		var nr = 0; //Counts the total number of cases with no result in a test plan
		var TCcount = []; //Stores the result status of current Test Plan in array
    var caseDetails = ""; //Stores the case details to log in additional information
    var logInfo = ""; //Stores log detail information

		if ( infoLog !== undefined && infoLog !== null && infoLog !== "" )
			TCcount = infoLog.substring(1).split("|");

		if ( TCcount !== undefined && TCcount !== "" && TCcount !== null && TCcount.length>0) {

  	  tc = TCcount.length 
      for ( var i=0,opc=pc; i<TCcount.length; ((opc+1===pc)?TCcount.splice(i,1):i++),opc=pc)
  		  aqString.StrMatches("Fail",TCcount[i])?fc++ : aqString.StrMatches("Error",TCcount[i])?ec++ : aqString.StrMatches("Warning",TCcount[i])?wc++ : aqString.StrMatches("Pass",TCcount[i])?pc++ : nr++ ;

  		if ( TCcount.length > 0 && tc > 1) {
			
    		var col=0;
    		var CaseDetailsBody = "";

  			for ( ; TCcount.length>0; TCcount.splice(0,1) ) {

  				TCcount[0] = TCcount[0].split(",");
  				CaseDetailsBody = CaseDetailsBody + "<tr>";        

  				for ( col=(col<TCcount[0].length)?TCcount[0].length:col; TCcount[0].length>0; TCcount[0].splice(0,1) )
  					CaseDetailsBody = CaseDetailsBody + "<td>" + TCcount[0][0] + "</td>";

  				CaseDetailsBody = CaseDetailsBody + "</tr>";
				
  			}	
      
  			var CaseDetailsHeader = "<html> <table border=\"1\" style=\"font-family:Courier New;font-size:13px;\" > <caption style=\"font-weight: bold; text-decoration:underline\"> Detail Log information <tr><th>Test Case No.</th>";
                                 
  			for ( var i=1; i<col; i++ )
  				CaseDetailsHeader = CaseDetailsHeader + "<th>Test Data" + i + "</th>";

  			CaseDetailsHeader = CaseDetailsHeader + "</tr>";
        
        caseDetails = CaseDetailsHeader + CaseDetailsBody + "</table></html>";
        
  		}
      
     
  		logInfo = " <html> <table border=\"1\" style=\"font-family:Courier New;font-size:13px;\" > <caption style=\"font-weight: bold; text-decoration:underline\"> Log Count information"
      logInfo = logInfo + "<tr> <th width=150>Total Cases</th> <th width=100>Pass</th> <th width=100>Fail</th> <th width=100>Error</th> <th width=120>Warning</th><th width=100>NA</th></tr>";
      logInfo = logInfo + "<tr> <td align=\"center\"> " +  tc + "</td> <td align=\"center\">" + pc + "</td> <td align=\"center\">" + fc + "</td> <td align=\"center\">" + ec + "</td> <td align=\"center\">" + wc + "</td> <td align=\"center\">" + nr + "</td>";
      logInfo = logInfo + " </table> <br/> </html> " + caseDetails

		}
		
    ProjectSuite.Variables.TestCaseStatus = "_Pass(" + pc + ")_Fail(" +  VarToStr(VarToInt(fc)+VarToInt(ec)) + ")_" + Sys.OSInfo.Name; 
    return logInfo;
  
	}

	catch(e) {

		Log.Warning("Exception at Script Extension->TestLog.LogPlanStatus : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message);
	}

} //LogPlanStatus