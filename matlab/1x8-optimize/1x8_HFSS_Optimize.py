import os
import sys
installPath = "C:\Program Files\AnsysEM\\v241\Win64" # Location of HFSS installation
pluginLoc = "C:\Program Files\AnsysEM\\v241\Win64\PythonFiles\DesktopPlugin" # Location of ScriptEnv.py file
sys.path.append(installPath)
sys.path.append(pluginLoc)
import ScriptEnv
import csv
import HfssScriptUtil as hfss

ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Patch")
oDesign = oProject.SetActiveDesign("10GHz_1x8_Array")
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:PatchW",
					"Value:="		, sys.argv[1] + "mm"
				]
			]
		]
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:PatchL",
					"Value:="		, sys.argv[2] + "mm"
				]
			]
		]
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:LineW",
					"Value:="		, sys.argv[3] + "mm"
				]
			]
		]
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:ArrayL",
					"Value:="		, sys.argv[4] + "mm"
				]
			]
		]
	])
oProject.Save()
oDesign.AnalyzeAll()
oModule = oDesign.GetModule("ReportSetup")
oModule.ExportToFile("S11", "C:/Users/Ali Mosallaei/Desktop/Desktop/Radlab/rotman/matlab/1x8-optimize/S11.csv", False)
oDesign.DeleteFullVariation("All", False)
