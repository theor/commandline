[![Build status](https://ci.appveyor.com/api/projects/status/45x7s2101mpfjmhp/branch/master)](https://ci.appveyor.com/project/cosmo0/commandline/branch/master)

Command Line Parser Library
===

The Command Line Parser Library offers to CLR applications a clean and concise API for manipulating command line arguments and related tasks defining switches, options and verb commands.  
It allows you to display an help screen with an high degree of customization and a simple way to report syntax errors to the end user. Everything that is boring and repetitive to be programmed stands up on library shoulders, letting developers concentrate on core logic.  
__This library provides _hassle free_ command line parsing with a constantly updated API since 2005.__

There are two versions available via nuget, the current 2.0 branch that tracks master, and a maintenance branch of 1.9 to provide bugfixes for anyone using the older api.

  - 2.0
    - nuget package: https://www.nuget.org/packages/CommandLineParser20
    - branch: master
  - 1.9
    - nuget package: https://www.nuget.org/packages/CommandLineParser19
    - branch: stable-1.9

Project status and future
---
This fork contains the latest pull requests from the original project (since the original developer seems to have vanished).  
I will not, however, actively develop it. You can make pull requests, I will merge pull requests to the original project, and I will fix bugs as I come across them, but I will not add new features.

You can take a look at alternative libraries like [ManyConsoles](https://github.com/fschwiet/ManyConsole) (c++ style) and [clipr](https://github.com/nemec/clipr) (python style).

Compatibility:
---
  - .NET Framework 4.0+ Client Profile
  - Mono 2.1+ Profile

Current Release:
---
  - For documentation please read the appropriate [wiki section](https://github.com/cosmo0/commandline/wiki/Latest-Beta).

At a glance:
---
  - One line parsing using default singleton: ``CommandLine.Parser.Default.ParseArguments<Options>(args)``.
  - One line help screen generator: ``HelpText.AutoBuild(...)``.
  - Map command line arguments to sequences (``IEnumerable<T>``), enum or standard scalar types.
  - __Plug-In friendly__ architecture as explained [here](https://github.com/cosmo0/commandline/wiki/Plug-in-Friendly-Architecture).
  - Define [verb commands](https://github.com/cosmo0/commandline/wiki/Verb-Commands) as ``git commit -a``.
  - Most of features applies with a [Convention over Configuration (CoC)](http://en.wikipedia.org/wiki/Convention_over_configuration) philosophy.
  - F# specific API (work in progress).

To install:
---
  - NuGet way (latest stable): ``Install-Package CommandLineParser20``
  - NuGet way (latest version): ``Install-Package CommandLineParser20 -pre``
  - XCOPY way: ``cp -r src\CommandLine To/Your/Project/Dir``

To build:
---
You must have any flavor of MSBuild (Xamarin, Visual Studio, or simply a .Net version including it, which are most of them) installed to build the project, but Visual Studio 2010+ or Xamarin is required to modify the project.

If you use the FSharp solution, you will also need the F# 3.1 compiler tools, linked [from fsharp.org](http://fsharp.org/use/windows/).

A [PSake](https://github.com/psake/psake) build script is provided. You can run `build.bat` to build the project and run the unit tests.

Public API:
---
Public API documentation available at http://cosmo0.github.io/commandline

Notes:
---
The project is well suited to be included in your application. If you don't merge it to your project tree, you must reference ``CommandLine.dll`` and import ``CommandLine`` and ``CommandLine.Text`` namespaces (or install via NuGet).

The help text builder and its support types lives in ``CommandLine.Text`` namespace that is loosely coupled with the parser. However is good to know that ``HelpText`` class will avoid a lot of repetitive coding.

Define a class to receive parsed values:

```csharp
class Options {
  [Option('r', "read", Required = true,
    HelpText = "Input files to be processed.")]
  public IEnumerable<string> InputFiles { get; set; }

  // omitting long name, default --verbose
  [Option(DefaultValue = true,
    HelpText = "Prints all messages to standard output.")]
  public bool Verbose { get; set; }

  [Value(0)]
  public int Offset { get; set;}
  }
}
```

Consume them:

```csharp
static void Main(string[] args) {
  var result = CommandLine.Parser.Default.ParseArguments<Options>(args);
  if (!result.Errors.Any()) {
    // Values are available here
    if (result.Value.Verbose) Console.WriteLine("Filenames: {0}", string.Join(",", result.Value.InputFiles.ToArray()));
  }
}
```

Acknowledgements:
---
Thanks to JetBrains for providing an open source license for [ReSharper](http://www.jetbrains.com/resharper/).

Main Contributors (alphabetical order):
- Alexander Fast (@mizipzor)
- Dan Nemec (@nemec)
- Kevin Moore (@gimmemoore)
- Steven Evans

Resources for newcomers:
---
  - [CodePlex](http://commandline.codeplex.com)
  - [Quickstart](https://github.com/gsscoder/commandline/wiki/Quickstart)
  - [Wiki](https://github.com/gsscoder/commandline/wiki)
  - [GNU getopt](http://www.gnu.org/software/libc/manual/html_node/Getopt.html)

Contacts:
---
Giacomo Stelluti Scala
  - gsscoder AT gmail DOT com
  - [Blog](http://gsscoder.blogspot.it)
  - [Twitter](http://twitter.com/gsscoder)
