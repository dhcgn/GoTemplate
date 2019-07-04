$appName = "MyProgram"
$version = "0.0.0"
$goCodeFile = "main.go"
$publishFolder = "publish"
$debugFolder = "debug"
$compressPublish = $true

$rootFolder = Split-Path -parent $PSCommandPath
$upx = [System.IO.Path]::Combine($rootFolder, "build", "tools", "upx.exe" )

$env:GOPATH = $rootFolder

Write-Host $env:GOPATH 

$envs = @()
$envs += @{GOOS = "windows"; GOARCH = "amd64"; }
$envs += @{GOOS = "windows"; GOARCH = "386"; }
$envs += @{GOOS = "linux"; GOARCH = "amd64"; }
$envs += @{GOOS = "linux"; GOARCH = "386"; }
$envs += @{GOOS = "linux"; GOARCH = "arm"; }
$envs += @{GOOS = "linux"; GOARCH = "arm64"; }
$envs += @{GOOS = "darwin"; GOARCH = "amd64"; }

foreach ($item in $envs ) {
    Write-Host "Build" $item.GOOS $item.GOARCH  -ForegroundColor Green
    
    $env:GOOS = $item.GOOS
    $env:GOARCH = $item.GOARCH

    if ($item.GOOS -eq "windows") {
        $extension = ".exe"
    }
    else {
        $extension = $null
    }
        
    $buildCode = (Join-Path -Path $rootFolder $goCodeFile)
   
    $buildOutput = ([System.IO.Path]::Combine( $rootFolder, "build", $publishFolder, ("{0}_{1}_{2}{3}" -f $appName, $item.GOOS, $item.GOARCH, $extension)))
    $executeExpression = "go build -ldflags ""-s -w -X main.version={0}"" -o {1} {2}" -f $version, $buildOutput, $buildCode 
    Write-Host "Execute", $executeExpression -ForegroundColor Green
    Invoke-Expression $executeExpression

    if ($compressPublish) {
        Invoke-Expression "$upx --lzma $buildOutput"
    }

    $buildOutput = ([System.IO.Path]::Combine( $rootFolder, "build", $debugFolder, ("{0}_{1}_{2}{3}" -f $appName, $item.GOOS, $item.GOARCH, $extension)))
    $executeExpression = "go build -ldflags ""-X main.version={0}"" -o {1} {2}" -f $version, $buildOutput, $buildCode 
    Write-Host "Execute", $executeExpression -ForegroundColor Green
    Invoke-Expression $executeExpression
}