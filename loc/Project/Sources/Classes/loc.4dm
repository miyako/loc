property data : Collection

Class extends _CLI

Class constructor($currentDirectory : 4D:C1709.Folder; $controller : 4D:C1709.Class)
	
	Super:C1705(""; $currentDirectory; $controller)
	
Function get worker() : 4D:C1709.SystemWorker
	
	return This:C1470.controller.worker
	
Function terminate()
	
	This:C1470.controller.terminate()
	
Function _parse() : Collection
	
	$response:=This:C1470.worker.response
	
	$data:=[]
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	$i:=1
	
	Case of 
		: (Is macOS:C1572)
			
			While (Match regex:C1019("(?m)(^.+$)(?:\\s*^\\s*)(\\d+)\\s*"; $response; $i; $pos; $len))
				$path:=Substring:C12($response; $pos{1}; $len{1})
				$count:=Num:C11(Substring:C12($response; $pos{2}; $len{2}))
				$data.push({path: $path; count: $count})
				$i:=$pos{0}+$len{0}
			End while 
			
		: (Is Windows:C1573)
			
			While (Match regex:C1019("(?m)(?:.+)(?:>findstr \\/r\\/n\\/s)\\s+(?:\"\\^\")(.*)(?:\\s\\|\\s*)(?:find \\/c \":\"\\s*)(^\\d+)"; $response; $i; $pos; $len))
				$i:=$pos{0}+$len{0}
				$path:=Substring:C12($response; $pos{1}; $len{1})
				$count:=Num:C11(Substring:C12($response; $pos{2}; $len{2}))
				If (Match regex:C1019("\\s*\"(.+)\\\\\\*\\.4dm\"\\s*"; $path; 1; $pos; $len))
					$path:=Substring:C12($path; $pos{1}; $len{1})
				End if 
				$data.push({path: $path; count: $count})
			End while 
			
	End case 
	
	This:C1470.data:=$data
	
Function count() : cs:C1710.loc
	
	If (This:C1470.currentDirectory#Null:C1517) && (This:C1470.currentDirectory.exists)
		
		Case of 
			: (Is macOS:C1572)
				
				$command:="/bin/sh"
				$message:="for dir in `ls`; do echo $dir; find $dir -name '*.4dm' -print0 | xargs -0 wc -l  | grep total; done;\n"
				
			: (Is Windows:C1573)
				
				$command:="cmd.exe /c for /d %d in (*) do findstr /r/n/s \"^\" \"%d\\*.4dm\" | find /c \":\""
				
		End case 
		
		
		Case of 
			: (Is macOS:C1572)
				This:C1470.controller.execute($command)
				This:C1470.worker.postMessage($message)
				This:C1470.worker.closeInput()
			: (Is Windows:C1573)
				This:C1470.controller.execute($command)
		End case 
		
		If (OB Instance of:C1731(This:C1470.controller; cs:C1710._loc_Controller))
			This:C1470.worker.wait()
		End if 
		
	End if 
	
	return This:C1470