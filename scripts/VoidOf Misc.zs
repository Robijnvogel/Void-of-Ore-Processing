#dependencies
	#Actually Additions
	#Applied Energistics
	#Gravity Gun by iChun
	#All imports

#Imports
	import mods.railcraft.BlastFurnace;
	import mods.tconstruct.Smeltery;
	import mods.thermalexpansion.Smelter;

#Recipe removal

	#Buckets
		Smelter.removeRecipe(<minecraft:bucket>, <minecraft:sand>);
		Smeltery.removeMelting(<minecraft:bucket>);
	#Shears
		Smelter.removeRecipe(<minecraft:shears>, <minecraft:sand>);
		Smeltery.removeMelting(<minecraft:shears>);
		BlastFurnace.removeRecipe(<Railcraft:ingot> * 2);
		
	#CraftingtableOnAStick
		recipes.remove(<ActuallyAdditions:itemCrafterOnAStick>);
	
	#Gravity Gun
		recipes.remove(<GraviGun:GraviGun>);
		recipes.remove(<GraviGun:GraviGun:1>);
	
#Recipe creation

	#Gravity Gun
		recipes.addShaped(<GraviGun:GraviGun>,
			[[<ore:gemDiamond>, <ore:pearlEnder>, <ore:ingotIron>],
			[<ore:pearlEnder>, <ore:crystalCertusQuartz>, <ore:pearlEnder>],
			[<ore:ingotIron>, <ore:pearlEnder>, <ore:obsidian>]]);
		recipes.addShaped(<GraviGun:GraviGun:1>,
			[[<ore:gemDiamond>, <ore:pearlEnder>, <ore:ingotIron>],
			[<ore:pearlEnder>, <ore:crystalChargedCertusQuartz>, <ore:pearlEnder>],
			[<ore:ingotIron>, <ore:pearlEnder>, <ore:obsidian>]]);
		
	#Factorization Steam Turbine
		recipes.addShaped(<factorization:FzBlock:21>,
			[[<ore:ingotIron>, <ore:barsIron>, <ore:ingotIron>],
			[<ore:paneGlass>, <factorization:fan>, <ore:paneGlass>],
			[<ore:ingotLead>, <factorization:motor>, <ore:ingotLead>]]);