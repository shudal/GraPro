// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.IO;
public class GraPro : ModuleRules
{
	protected void AddSPUD()
	{
		// Linker
		//PrivateDependencyModuleNames.AddRange(new string[] { "SPUD" });
		// Headers
		PublicIncludePaths.Add(Path.Combine(PluginsPath, "SPUD", "Source", "SPUD", "Public"));
	}
	private string PluginsPath
	{
		get { return Path.GetFullPath(Path.Combine(ModuleDirectory, "../../Plugins/")); }
	}
	public GraPro(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

		//PublicAdditionalLibraries.Add(Path.Combine(ModuleDirectory, "Extra/Lua/MyLuaSql/Libs/sqlite3.lib"));
		//PublicAdditionalLibraries.Add(Path.Combine(ModuleDirectory, "Extra/Lua/MyLuaSql/Libs/luqsqlsqlite3.lib"));
		//PublicIncludePaths.Add(Path.Combine(ModuleDirectory,"Extra/Lua/MyLuaSql/Libs/Includes"));
		
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "HeadMountedDisplay", "SUQS", "StevesUEHelpers","Lua","UnLua","SPUD","Slate","SlateCore",
				"GameplayAbilities",
				"GameplayTags",
				"GameplayTasks", });
		//PrivateDependencyModuleNames.AddRange(new string[] { "SUQS","StevesUEHelpers","Lua","UnLua" });
		//bEnableUndefinedIdentifierWarnings = false;
		AddSPUD();
	}
}
