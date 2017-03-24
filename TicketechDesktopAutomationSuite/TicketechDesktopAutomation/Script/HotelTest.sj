//USEUNIT Utility
//USEUNIT DBUtility
//USEUNIT SQLQueries
//USEUNIT XMLReader
//USEUNIT MainDialog
//USEUNIT UserInfoForm




function TC_HTL_CHKIN_009() {
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  TC_REPLACE_VEHICLE_009 : Verfiy the HOTEL button is enabled/disabled as per Policy document
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

  //Variable Declaration 
  //---------------------
  var objMainDialog; //Stores the instance of MainDialog
  var objUserInfoForm; //Stores the instance of UserInfoForm
   
  try { 
    
    bHotelEnabled = XMLReader.getXMLData("//AcceptHotel/Value");
    
    if(bHotelEnabled)
      aHotelList = XMLReader.getXMLData("//Hotels/HotelList")
     
    //Launching the POS application and Initialize the objMainDialog screen
    Utility.launchApp();
    objMainDialog = MainDialog.New();
    
    bButtonExists = objMainDialog.IsHotelAvailable();    
    TestLog.Message("Hotel Set as Enabled = "+bHotelEnabled[0]+" in Policy File; Is Hotel available in App = "+bButtonExists);
    
    // Verify Make panel not displayed
    
    Utility.assertResult( (aqString.ToUpper(bButtonExists) === aqString.ToUpper(bHotelEnabled[0]))
                          ,"Test Passed. Hotel button set in application as set in Policy File"
                          ,"Test Failed. Hotel button not set as per policy document"
                        );
     
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
  objMainDialog = null;

} //TC_HTL_CHKIN_009