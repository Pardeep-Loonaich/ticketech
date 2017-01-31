//USEUNIT Utility

/*************************************************************************************************************************************
---------------------------------------------------[[SCRIPT DEVELOPMENT CHRONICLE]]---------------------------------------------------
Test Module Name   : MainDriver
Developed By       : TT Team ASPIRE
--------------------------------------------------------------------------------------------------------------------------------------
**************************************************************************************************************************************/

function MainDriver(smokeRun, endToEnd) {   
                                                        
/*===================================================================
  Driver Script: This is driver script to run all the Test Modules
===================================================================*/

  try { 
    var moduleName = null;
    
    if (smokeRun == true) 
      TestLog.AddProject("Smoke Tests")
    else if (endToEnd == true) 
      TestLog.AddProject("EndtoEnd Tests")
    else 
      TestLog.AddProject("Functional Tests")
      
    DataPool.FilePath = Project.Path + "TestData\\";
    if (endToEnd == false) {
      DataPool.FileName = "MainDriver.xls";
      DataPool.SheetName = "Modules";
      SuiteData = DataPool.New();
    }
    else {
      DataPool.FileName = "EndToEnd.xls";
      DataPool.SheetName = "Tests";
      SuiteData = DataPool.New();
    }
    
    while (!DataPool.EOF) {      
      if (endToEnd == true && DataPool.Item("Run") == "Yes") {
          var tcNo = DataPool.Item("TestID");
          Indicator.PushText("TC#" + DataPool.Item("TestID"));
        
          TestLog.AddTestCase(tcNo, DataPool.Item("Title"), DataPool.Item("Steps"), DataPool.Item("ExpectedResult"));
          try { 
            Runner.CallMethod("EndToEndTest." + tcNo); 
            } 
          catch(e) {}
          finally {   
            Log.PopLogFolder();
          }
      }
      else if(endToEnd == false && DataPool.Item("Run") == "Yes"){
        try {             
          TestLog.AddTestPlan(DataPool.Item("Module Name"));
          DataPool.FilePath = Project.Path + "TestData\\";
          moduleName = aqString.Replace(DataPool.Item("Module Name"), " ", "");
          DataPool.FileName = moduleName + ".xls";
          DataPool.SheetName = "Tests";
          var ModuleData = DataPool.New();
    
          while (!DataPool.EOF) {                      
          
            if((DataPool.Item("Run") == "Yes" && smokeRun == true && DataPool.Item("Smoke") == "Yes") || 
               (DataPool.Item("Run") == "Yes" && smokeRun == false && DataPool.Item("Smoke") == "No")) {

              var tcNo = DataPool.Item("TestID");
              Indicator.PushText("TC#" + DataPool.Item("TestID"));
        
              TestLog.AddTestCase(tcNo, DataPool.Item("Title"), DataPool.Item("Steps"), DataPool.Item("ExpectedResult"));
              try { 
                Runner.CallMethod(moduleName+"Test." + tcNo); 
                } 
              catch(e) {}
              finally {   
                Log.PopLogFolder();
              }                
            }// End If      
            DataPool.Reset(ModuleData);
            DataPool.NextItem(); //moving to next given test item
          }
        }
        catch(exp) {
          TestLog.Error(exp.description, Utility.formattedException(exp));
        }
        finally {        
          DataPool.Close();    
          Log.PopLogFolder();
          ModuleData = null;                               
        }                     
      }
      DataPool.Reset(SuiteData);
      DataPool.NextItem(); //moving to next given test item
    }
  }
  catch(exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  }  
  finally {
    DataPool.Close();    
    Log.PopLogFolder();
    SuiteData = null;
  }  
} //MainDriver
