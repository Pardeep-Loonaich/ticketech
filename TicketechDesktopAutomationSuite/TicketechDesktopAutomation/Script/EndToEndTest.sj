﻿

/*************************************************************************************************************************************
---------------------------------------------------[[SCRIPT DEVELOPMENT CHRONICLE]]---------------------------------------------------
Test Module Name   : End To End Tests
Developed By       : TT Team ASPIRE
--------------------------------------------------------------------------------------------------------------------------------------
**************************************************************************************************************************************/

function EndToEndTestDriver() {   
                                                        
/*===================================================================
  Driver Script: This is driver script for Test Module - EndToEnd
===================================================================*/

  try { 
    
    TestLog.AddTestPlan("End To End");
    DataPool.FilePath = Project.Path + "TestData\\";
    DataPool.FileName = "EndToEnd.xls";
    DataPool.SheetName = "Tests";
    EndToEndTestData = DataPool.New();
    
    while (! DataPool.EOF) {      

      if(DataPool.Item("Run") === "Yes"){
      
        var tcNo = DataPool.Item("TestID");
        tcNo = aqString.Replace(tcNo, ".", "_"); 
        tcNo = tcNo.toUpperCase();
        Indicator.PushText("TC#" + DataPool.Item("TestID"));
        
        TestLog.AddTestCase(DataPool.Item("TestID"), DataPool.Item("Title"), DataPool.Item("Steps"), DataPool.Item("ExpectedResult"));
        
        try { 
          Runner.CallMethod("EndToEndTest." + tcNo); 
          } 
        catch(e) {}
                 
        Log.PopLogFolder();                
      }// End If
      
      DataPool.Reset(EndToEndTestData);
      DataPool.NextItem(); //moving to next given test item
    }                                                                              
  }
  
  catch (exception){
    TestLog.Error(exception.description, Utility.formattedException(exception));
  }
  
  finally {
    DataPool.Close();    
    Log.PopLogFolder();
    EndToEndTestData = null;
  }  

} //EndToEndTestDriver
