property data : Collection

Class extends _CLI

Class constructor($currentDirectory : 4D:C1709.Folder; $controller : 4D:C1709.Class)
	
	If ($controller=Null:C1517)
		$controller:=cs:C1710._scc_Controller
	End if 
	
	Super:C1705("scc"; $currentDirectory; $controller)
	
Function get worker() : 4D:C1709.SystemWorker
	
	return This:C1470.controller.worker
	
Function terminate()
	
	This:C1470.controller.terminate()
	
Function _parse() : Collection
	
	$response:=This:C1470.worker.response
	
	$lines:=Split string:C1554($response; This:C1470.EOL; sk ignore empty strings:K86:1)
	
	$data:=[]
	
	If ($lines.length>0)
		$headers:=Split string:C1554($lines[0]; ",")
		$lines.shift()
		For each ($line; $lines)
			$values:=Split string:C1554($line; ",")
			$datum:={}
			$data.push($datum)
			For each ($header; $headers)
				If ($header="Language")
					$datum[$header]:=$values.shift()
					If ($datum.Language="Pascal")
						$datum.Language:="4D"
					End if 
				Else 
					$datum[$header]:=Num:C11($values.shift())
				End if 
			End for each 
		End for each 
	End if 
	
	This:C1470.data:=$data
	
Function count() : cs:C1710.loc
	
	$command:=This:C1470.escape(This:C1470.executablePath)
	$command+=" --count-as 4dm:pascal,4dsettings:xml,4dcatalog:xml,4dform:json"
	$command+=" --format csv"  //file counts missing in json output
	$command+=" "+This:C1470.quote(This:C1470.currentDirectory.path)
	
	If (This:C1470.currentDirectory#Null:C1517) && (This:C1470.currentDirectory.exists)
		
		This:C1470.controller.execute($command)
		
		If (OB Instance of:C1731(This:C1470.controller; cs:C1710._scc_Controller))
			This:C1470.worker.wait()
		End if 
		
	End if 
	
	return This:C1470