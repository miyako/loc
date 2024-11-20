![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/loc)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/loc/total)

# loc
"lines of code" for 4D

## dependencies.json

 ```json
{
	"dependencies": {
		"loc": {
			"github": "miyako/loc",
			"version": "*"
		}
	}
}
```

## macOS (`wc -l`)

<img src="https://github.com/user-attachments/assets/10c42ee4-4ca2-4874-952c-d329f8c04cd9" width=600 height=auto />

## Windows (`findstr /r/n/s "^"` + `find /c ":"`)

<img src="https://github.com/user-attachments/assets/5cd9f418-9bfd-43d7-8a3f-765e002f5fb2" width=600 height=auto />

* on Mac the final line is not counted if it doesn't have a line terminator character.  
* on Windows the all files in a directory and its subdirectories are evidently concatenated. when a file does not end with a line terminator, the first line of the next file is added to its end, which results in a lower total line count. 

```
TEST_form.4dm:1://%attributes = {}
TEST_form.4dm:2:#DECLARE($params : Object)
TEST_form.4dm:3:If (Count parameters:C259=0)
TEST_form.4dm:4:        CALL WORKER:C1389(1; Current method name:C684; {})
TEST_form.4dm:5:Else
TEST_form.4dm:6:        $form:=cs:C1710._locForm.new()
TEST_form.4dm:7:End if TEST_sync.4dm:1://%attributes = {}
TEST_sync.4dm:2:#DECLARE($params : Object)
```

in this example, the line count from each file totals `7`+`2`=`9`, but the command reports `8`.
