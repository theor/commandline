Properties {
	$apikey = $null # call nuget.bat with your Nuget API key as parameter
	$BIN_PATH = ".\build"
  $NUGET_EXE = ".\.nuget\nuget.exe"
	$NUGET_OUTPUT = (Join-Path $BIN_PATH "nuget")
}

Framework "4.0x86"
FormatTaskName "-------- {0} --------"

task default -depends Cleanup-Binaries, Restore-Packages, Build-Solution

# TODO: update assembly infos from build server ; see https://gist.github.com/toddb/1133511

# cleans up the binaries output folder
task Cleanup-Binaries {
	Write-Host "Removing $BIN_PATH"
	if (Test-Path $BIN_PATH) {
		Remove-Item $BIN_PATH -Force -Recurse
	}
}

# restores nuget packages
task Restore-Packages {
	Write-Host "Restoring NuGet packages"
	& $NUGET_EXE restore CommandLine.sln
}

# builds the solution
task Build-Solution -depends Cleanup-Binaries, Restore-Packages {
	Write-Host "Building solution"
	Exec {
		msbuild "CommandLine.sln" /t:Build /p:Configuration=Release /p:Platform="Any CPU" /p:Warnings=true /v:Normal /nologo /clp:WarningsOnly`;ErrorsOnly`;Summary`;PerformanceSummary
	}
}

# generates a Nuget package
task Generate-Package -depends Build-Solution {
	if ($apikey -eq $null -or $apikey -eq "") {
		throw New-Object [System.ArgumentException] "If you want to build a Nuget package, please provide your API key as the batch parameter"
	} else {
		Write-Host "Generating a Nuget package"
		& $NUGET_EXE setApiKey $apikey
		
		# Nuget doesn't create the output dir automatically...
		if (-not (Test-Path $NUGET_OUTPUT)) {
			mkdir $NUGET_OUTPUT | Out-Null
		}
		
		# Package the nuget
		& $NUGET_EXE Pack ".\nuget\CommandLine.nuspec" -OutputDirectory $NUGET_OUTPUT
		
		# Send the nuget
		Get-ChildItem "$NUGET_OUTPUT\*.nupkg" | % {
			& $NUGET_EXE Push $_
		}
	}
}