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
			"version": "latest"
		}
	}
}
```

## [boyter/scc](https://github.com/boyter/scc)

```4d
var $folder : 4D.Folder
$folder:=Folder("/SOURCES/")

var $scc : cs.loc.scc
$data:=cs.loc.scc.new($folder).count().data

ALERT(JSON Stringify($data; *))
```

<img src="https://github.com/user-attachments/assets/f0bdbcfd-8daa-490d-bfbc-b176eddae3c6" width=400 height=auto />

CLI options are

```
 --count-as 4dm:pascal,4dsettings:xml,4dcatalog:xml,4dform:json
 --format csv
 --uloc
```

## Native Option

```4d
var $folder : 4D.Folder
$folder:=Folder("/SOURCES/")

var $loc : cs.loc.loc
$data:=cs.loc.loc.new($folder).count().data

ALERT([JSON Stringify($data; *); "-"*36; $data.sum("count")].join("\r"))
```

### macOS (`wc -l`)

<img src="https://github.com/user-attachments/assets/10c42ee4-4ca2-4874-952c-d329f8c04cd9" width=400 height=auto />

### Windows (`findstr /r/n/s "^"` + `find /c ":"`)

<img src="https://github.com/user-attachments/assets/5cd9f418-9bfd-43d7-8a3f-765e002f5fb2" width=400 height=auto />

### remarks

the last line of a `.4dm` typically doesn't end with `\n` or `\r\n`. this has an impact on how lines are counted on each platform.

* on Mac the final line is excluded regardless of its content.  
* on Windows, the final line is excluded except for the last file in a directory. this is because all files in a directory and its subdirectories are evidently concatenated before processing, which means the first line of a file is added to the last line of the previous file in sequence.

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
