
function getXMLData(sXpath) {

/*---------------------------------------------------------------------------------------------------
  Method      : getXMLData(sXpath)
  
  Description : This method returns Node value of the given Xpath  from the PoliciesLocation XML file 
  
  Input       : sXpath - xpath of the node whose value is required
                e.g: -<RateNames>
                        -<Relations Id="00000000-0000-0000-0000-000000000000" xsi:type="RateTypeDescription">
                            <Ordinal>0</Ordinal>
                         </Relations>
                         
                getXMLData("//RateNames/Relations/Ordinal"); will return array, where array[0] will contain Value 0
  
  Output      : Returns the the Node value of the given Xpath from XML file in an array
  
  Note        : The PoliciesLocation XML file should be placed under Project.Path\TestData Folder
                eg: Project.Path\TestData\ABC026.xml
  
---------------------------------------------------------------------------------------------------*/ 

  var Doc, s, Nodes, ChildNodes, i, Node;
  var sNodeValue = new Array();
  
  // Create a COM object for MSXML 6: 
  Doc = Sys.OleObject("Msxml2.DOMDocument.6.0");

  Doc.async = false;
  
  // Load data from a file - file should be available in the required folder
  sFileName = Project.Path + "TestData\\ABC026.xml";
  Doc.load(sFileName);
  
  // Report an error, if, for instance, the markup or file structure is invalid 
  if(Doc.parseError.errorCode != 0)
  {
    s = "Reason:\t" + Doc.parseError.reason + "\n" +
        "Line:\t" + aqConvert.VarToStr(Doc.parseError.line) + "\n" + 
        "Pos:\t" + aqConvert.VarToStr(Doc.parseError.linePos) + "\n" + 
        "Source:\t" + Doc.parseError.srcText;
    // Post an error to the log and exit
    Log.Error("Cannot parse the document.", s); 
    return;
  }
  
  // The XPath expression obtains a list of "control" nodes 
  Nodes = Doc.selectNodes(sXpath);

  // Process the node
  for(i = 0; i < Nodes.length; i++)
  {
    // Get the node from the collection of the found nodes 
    Node = Nodes.item(i);
    // Get child nodes 
    ChildNodes = Node.childNodes;
    for(j = 0; j < ChildNodes.length; j++)
    {
      // Output child nodes to the log
    sNodeValue[j] =  ChildNodes.item(j).text;
    }
  } 
  return sNodeValue;
}


function getXMLDataAttribute(sXpath,sID) {

/*---------------------------------------------------------------------------------------------------
  Method      : getXMLDataAttribute(sXpath)
  
  Description : This method returns Node attribute value of the given sID from the PoliciesLocation XML file 
  
  Input       : sXpath - xpath of the node whose attribute is required, sID - Attribute name that is required
  
                e.g: -<RateNames>
                        -<Relations Id="00000000-0000-0000-0000-000000000000" xsi:type="RateTypeDescription">
                            <Ordinal>0</Ordinal>
                         </Relations>
                         
                getXMLDataAttribute("//RateNames/Relations","Id");
                
  Output      : Returns the the Node value of the given Xpath from XML file 
  
  Note        : The PoliciesLocation XML file should be placed under Project.Path\TestData Folder
                eg: Project.Path\TestData\ABC026.xml
  
---------------------------------------------------------------------------------------------------*/ 

  var Doc, s, Nodes, ChildNodes, i, Node;
  var sNodeAttribute = new Array();
  
  // Create a COM object for MSXML 6: 
  Doc = Sys.OleObject("Msxml2.DOMDocument.6.0");

  Doc.async = false;
  
  // Load data from a file - file should be available in the required folder
  sFileName = Project.Path + "TestData\\ABC026.xml";
  Doc.load(sFileName);
  
  // Report an error, if, for instance, the markup or file structure is invalid 
  if(Doc.parseError.errorCode != 0)
  {
    s = "Reason:\t" + Doc.parseError.reason + "\n" +
        "Line:\t" + aqConvert.VarToStr(Doc.parseError.line) + "\n" + 
        "Pos:\t" + aqConvert.VarToStr(Doc.parseError.linePos) + "\n" + 
        "Source:\t" + Doc.parseError.srcText;
    // Post an error to the log and exit
    Log.Error("Cannot parse the document.", s); 
    return;
  }
  
  // The XPath expression obtains a list of "control" nodes 
  Nodes = Doc.selectNodes(sXpath);
  
  if( Nodes.length != 0){
    // Process the node
    for(i = 0; i < Nodes.length; i++)
    {
      // Get the node from the collection of the found nodes 
      Node = Nodes.item(i);
      sNodeAttribute[i] = Node.getAttribute(sID);
    }
    return sNodeAttribute; 
  }
  
}