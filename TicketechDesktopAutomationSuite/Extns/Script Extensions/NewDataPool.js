//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//Copyright © 2003-2009 M-Files, Inc. All rights reserved.
//Author: Aspire Test Automation Team                          
//[The next two values could be rendered redundant if this file is kept in Source control, as the SCM system would provide the information needed]
//Last Modified Date: 5th / Feb / 2011
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//************************************************************************************
// Class Name: DataPooler
//
// Description:
//     Using this class data can read from a excel work book. This class access the data
//     excel referring each sheet as a database table through ADO 
//
// Properties Info:
//
//     This class contains below properties which can accessed by objects through property method 

//     1) TestDataFilePath - has excel work book path
//     2) TestDataFileName - has excel work book file name which need accessed
//     3) TestDataSheetName - has sheet name in work order which needs to read  
//     4) Item - a array that holds current record set value 
//     5) Column - array that holds names of column in the excel sheet
//
//     TestDataFilePath, TestDataFileName & TestDataSheetName needs to set from instance of class.
//     And it those properties can be set using property methods FilePath, FileName & Sheetname
//
//     ColumnNames & Values in excel sheet can read using get property methods FieldName, 
//     FieldIndex & Fields   
//
// Methods Info:
//
//     This class contains below two methods to execute a command line
//
//     1) ConnectTestDataFile - Establishes the ADO connection to excel work book. 
//                              FileName & Path should be set prior to this method
//
//     2) OpenTestDataSheet - This method reads data in excel sheet by querying it.
//                            Prior using this method sheet name should be set
//
//     3) GetNextTestData  - Moves the recordset pointer to next record and updates 
//                           item property values
//
//************************************************************************************

var filePath, 
	fileName, 
	sheetName, 
	adoConn,
	colCount;
	
var Items = [], colNames = [];
var lastError = {};
var adoConn;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Objec: connector; used to store the connection info of the connected excel sheet
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function connector() {
	this.Path = "";
	this.File = "";
	this.Sheet = "";
	this.Connection = "";
	this.RecordSet = "";
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Creates a new data pool connection to the specified excel sheet
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function newDataPool(TestDataPath, TestDataFileName, TestDataSheetName) {

	try {

		adoConn = new connector();
		
		if (TestDataPath != undefined) {
			adoConn.Path = TestDataPath
			SetFilePath(TestDataPath);
		}
		else {
			adoConn.Path = filePath;
		}

		if (TestDataFileName != undefined) {
			adoConn.File = TestDataFileName
			SetFileName(TestDataFileName);
		}
		else {
			adoConn.File = fileName;
		}

		if (TestDataSheetName != undefined) {
			adoConn.Sheet = TestDataSheetName
			SetSheetName(TestDataSheetName);
		}
		else {
			adoConn.Sheet = sheetName;
		}

		ConnectTestDataFile();
		OpenTestDataSheet();
		return adoConn;
	
	}
	catch(e) {

		Log.Warning("Exception at Script Extension->NewDataPool.New() : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
		
		throw e;
		
	}
	
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Establishes a ADO connection to the specified excel document
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ConnectTestDataFile() {
	
	try {
	
		// Check existance of the file
		if(!aqFile.Exists(filePath + "\\" + fileName))
		{    
			throw {
				name: "DataPooler Exception",
				description: "Error at DataPool.ConnectTestData method.",
				message: "The specified testdata file " + (fileName) + " not found at " + filePath
			}
		}
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//Set ConnectionString and connection
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		var ConnStr = "DRIVER=Microsoft Excel Driver (*.xls);DBQ=";

		adoConn.Connection = Sys.OleObject("ADODB.Connection");
		adoConn.Connection.ConnectionString = ConnStr + filePath + "\\" + fileName + ";ReadOnly=1;";
		adoConn.Connection.Open();
    
	}
	catch(e) {

		Log.Warning("Exception at Script Extension->DataPool.New() [Connect] : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
		
		throw e;
	}

}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Resets the connection of datapool extension to specified one.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function resetConnection(Conn) {

	try {
	
		adoConn = Conn;
		colCount = adoConn.RecordSet.Fields.Count;

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//Copy values to array items from record set
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		if (! adoConn.RecordSet.EOF)
		{
			colNames = [];
			Items = [];
			
			for(colIndex = 0; colIndex < colCount; colIndex++)
			{
			  colNames.push(adoConn.RecordSet.Fields(colIndex).Name);
			  Items.push(adoConn.RecordSet.Fields(colIndex).Value);
			}
			
			colCount
		}
	
	}
	catch(e) {

		Log.Warning("Exception at Script Extension->DataPool.Reset : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
		
		throw e;
	}
	
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Sets the FilePath property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function SetFilePath(Path) {
 filePath = Path; // Set File Path
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Sets the FileName property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function SetFileName(Name)  { 
	fileName = Name; // Set File Name
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Sets the SheetName property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function SetSheetName(Name) {

	//Double quote the Sheetname if it consists of space or "-", 
	if((Name.indexOf(" " , 0) != -1) || (Name.indexOf("-" , 0) != -1))
		Name = "//" + Name + "$//";
	else
		Name = Name + "$";

	sheetName = Name;
} 
  
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the FilePath property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function FilePath()  {
	return filePath;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the FileName property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function FileName() {
	return fileName;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the SheetName property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function SheetName() {
	return sheetName;
}
   
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the column count property
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function FieldCount() {
	return colCount;
}
  
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the Field Name at Index
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function FieldName(Index) {

	if (isNaN(Index))
	  return Index
	else
	  return colNames[Index];

}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the Index of Column 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function FieldIndex(Name) {    

	var colIndex;

	for(colIndex = 0; colIndex < colCount; colIndex++)
	{    
	  if(Name.toUpperCase() == colNames[colIndex].toUpperCase())
		return colIndex;
	}

	return -1;
} 

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns the Index of ColName
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
function Field(Name) {  

	var Index;
	Index = Name;

	if (isNaN(Index))
		Index = FieldIndex(Index);

	return(Items[Index])
}
  
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Returns data record
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
function Item(Name) {  

	var Index;

	if (Name == null)
		return Items;
		
	Index = Name;

	if (isNaN(Index))
		Index = FieldIndex(Index);

	if (Index != -1)
		return(Items[Index])
	else
		return null;

}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Returns column name array
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Columns() {
	return colNames;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Returns EOF status
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function EOF() {
	return adoConn.RecordSet.EOF;
}
  
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Reads all the records in the specified sheet
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function OpenTestDataSheet() { 

	try {
	
		var colIndex;

		if ((adoConn.Connection == null) || (adoConn.Connection.State == 0))
			ConnectTestDataFile();
		
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//Validating existance of the data sheet
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		adoConn.RecordSet = adoConn.Connection.OpenSchema(20);

		while(! adoConn.RecordSet.EOF)
		{    
			if(adoConn.RecordSet.Fields("TABLE_NAME").Value.toUpperCase() == sheetName.toUpperCase())
				break;

			adoConn.RecordSet.MoveNext;
		}

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
		//Log error and Exit, data sheet is not found
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		if(adoConn.RecordSet.EOF)
		{
			throw {
				name: "DataPooler Exception",
				description: "Error at DataPool.OpenTestDataSheet method.",
				message: "The specified testdata sheet " + (sheetName) + " not found. " 
			}
		}

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//Read all the records in the data sheet and update column name property
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		adoConn.RecordSet = adoConn.Connection.Execute("Select * from [" + sheetName + "]");
		colCount = adoConn.RecordSet.Fields.Count;

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//Copy values to array items from record set
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		if (! adoConn.RecordSet.EOF)
		{
			colNames = [];
			Items = [];
			for(colIndex = 0; colIndex < colCount; colIndex++)
			{
			  colNames.push(adoConn.RecordSet.Fields(colIndex).Name);
			  Items.push(adoConn.RecordSet.Fields(colIndex).Value);
			}
		}
	}

	catch(e) {

		Log.Warning("Exception at Script Extension->NewDataPool.New() [OpenTestDataSet] : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
		
		throw e;
	}

} //OpenTestDataSheet
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // Moves recordset pointer to next record
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  function GetNextTestData() {
    
	try
    {
		var colIndex;
		adoConn.RecordSet.MoveNext();

		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~                            
		//Copy items from recordset  
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
		if (! adoConn.RecordSet.EOF)
		{    
			for(colIndex = 0; colIndex < colCount; colIndex++)
				Items[colIndex] = adoConn.RecordSet.Fields(colIndex).Value;
		} 
     
    }
	
	catch(e) {

		Log.Warning("Exception at Script Extension->DataPool.NextItem() : " + e.description, 
		"\nName :  " + e.name +
		"\nLine Number : " + e.linenumber + 
		"\n\nDescription : " + e.description + 
		"\n\nMessage : " + e.message)
		
		throw e;
	}
	
} //MoveNext  
  
//~~~~~~~~~~~~~~~~~~
// Closes recordset 
//~~~~~~~~~~~~~~~~~~
function closeRecordSet() {

	if (adoConn.RecordSet !== null && adoConn.RecordSet.State == 1)
		adoConn.RecordSet.Close();
		
	adoConn.RecordSet = null;
}
  
//~~~~~~~~~~~~~~~~~~
// Closes ADO connection 
//~~~~~~~~~~~~~~~~~~

function closeConnection() {
	
	if (adoConn.RecordSet !== null && adoConn.RecordSet.State == 1)
		adoConn.RecordSet.Close();

	if (adoConn.Connection !== null && adoConn.Connection.State == 1)
		adoConn.Connection.Close();
		
	adoConn.RecordSet = null;
	adoConn.Connection = null;

}