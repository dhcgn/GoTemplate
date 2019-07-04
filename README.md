#  Go template for simple tools

A template to create executables for different plattforms with optional UPX compression.

Every command will be written to console to every step can be reproduced.

The script can be speeded up by uncommenting the platforms which are not needed.

```powershell
# Just uncomment the platfoms you don't need
$platforms = @()
$platforms += @{GOOS = "windows"; GOARCH = "amd64"; }
$platforms += @{GOOS = "windows"; GOARCH = "386"; }
$platforms += @{GOOS = "linux"; GOARCH = "amd64"; }
$platforms += @{GOOS = "linux"; GOARCH = "386"; }
$platforms += @{GOOS = "linux"; GOARCH = "arm"; }
$platforms += @{GOOS = "linux"; GOARCH = "arm64"; }
$platforms += @{GOOS = "darwin"; GOARCH = "amd64"; }
```

Between `debug` and `publish` is great improvment in file size.

```
FullName                                                    Length in MB
--------                                                    ------------
C:\Dev\GoTemplate\build\debug\MyProgram_windows_amd64.exe   1,965
C:\Dev\GoTemplate\build\publish\MyProgram_windows_amd64.exe 0,417
```

## Files

```plain
Project root
│   build.ps1
│   main.go
│
└───build
    ├───debug
    │       MyProgram_darwin_amd64
    │       MyProgram_linux_386
    │       MyProgram_linux_amd64
    │       MyProgram_linux_arm
    │       MyProgram_linux_arm64
    │       MyProgram_windows_386.exe
    │       MyProgram_windows_amd64.exe
    │
    ├───publish
    │       MyProgram_darwin_amd64
    │       MyProgram_linux_386
    │       MyProgram_linux_amd64
    │       MyProgram_linux_arm
    │       MyProgram_linux_arm64
    │       MyProgram_windows_386.exe
    │       MyProgram_windows_amd64.exe
    │
    └───tools
            upx.exe
```
