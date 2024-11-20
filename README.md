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
* on Windows the total doesn't match the line count of each files (in the above example, 2 files with `8` and `12` lines resulted in `19`). seems like the number of folders has an impact.
