Properties {
	$BIN_PATH = ".\build"
}

Framework "4.0x86"
FormatTaskName "-------- {0} --------"

task default -depends Cleanup-Binaries, Restore-Packages, Build-Solution

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
	& nuget restore
}

# builds the solution
task Build-Solution {
	Write-Host "Building solution"
	Exec {
		msbuild "CommandLine.sln" /t:Build /p:Configuration=Release /p:Platform="Any CPU" /p:Warnings=true /v:Normal /nologo /clp:WarningsOnly`;ErrorsOnly`;Summary`;PerformanceSummary
	}
}