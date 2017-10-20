#Chestplate = 5 nuggets in shape hopper 3 ingots in shape upside down bucket
#Leggings = 3 ingots, 4 nuggets
#Boots = 2 ingots, 2 nuggets
#Helmet = 2 ingots, 3 nuggets

#start of the armour processing minetweaker script

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	import minetweaker.liquid.ILiquidStack;
	
	import mods.immersiveengineering.ArcFurnace;
	import mods.railcraft.BlastFurnace;
	import mods.tconstruct.Smeltery;
	import mods.thermalexpansion.Crucible;
	import mods.thermalexpansion.Smelter as ISmelter;
	
#Item lists
	#in the rest of this document, some lists of items are used.
	#These lists will have the following order:
	#0 -> Iron
	#1 -> Gold
	#2 -> Copper
	#3 -> Tin
	#4 -> Silver
	#5 -> Lead
	#6 -> Nickel (Ferrous)
	#7 -> Platinum (Shiny)
	#8 -> Bronze
	#9 -> Osmium
	#10 -> Steel (Refined Iron)
	#11 -> Boron
	#12 -> Thaumium
	#13 -> Void metal
	#14 -> Electrum
	
	var oreDictIngots = [ 
		<ore:ingotIron>,
		<ore:ingotGold>,
		<ore:ingotCopper>,
		<ore:ingotTin>,
		<ore:ingotSilver>,
		<ore:ingotLead>,
		<ore:ingotNickel>,
		<ore:ingotPlatinum>,
		<ore:ingotBronze>,
		<ore:ingotOsmium>,
		<ore:ingotSteel>,
		<ore:ingotThaumium>,
		<ore:ingotVoid>,
		<ore:ingotElectrum>
		#bronze?
		#bronze?
	] as IIngredient[];
	
	var oreDictNuggets = [ 
		<ore:nuggetIron>,
		<ore:nuggetGold>,
		<ore:nuggetCopper>,
		<ore:nuggetTin>,
		<ore:nuggetSilver>,
		<ore:nuggetLead>,
		<ore:nuggetNickel>,
		<ore:nuggetPlatinum>,
		<ore:nuggetBronze>,
		<ore:nuggetOsmium>,
		<ore:nuggetSteel>,
		<ore:nuggetThaumium>,
		<ore:nuggetVoid>,
		<ore:nuggetElectrum>
		#bronze?
		#bronze?
	] as IIngredient[];
	
	var helmets = [ 
		<minecraft:iron_helmet>,
		<minecraft:golden_helmet>,
		<ThermalFoundation:armor.helmetCopper>,
		<ThermalFoundation:armor.helmetTin>,
		<ThermalFoundation:armor.helmetSilver>,
		<ThermalFoundation:armor.helmetLead>,
		<ThermalFoundation:armor.helmetNickel>,
		<ThermalFoundation:armor.helmetPlatinum>,
		<IC2:itemArmorBronzeHelmet>,
		<MekanismTools:OsmiumHelmet>,
		<MekanismTools:SteelHelmet>,
		<Thaumcraft:ItemHelmetThaumium>,
		<Thaumcraft:ItemHelmetVoid>,
		<ThermalFoundation:armor.helmetElectrum>,
		<ThermalFoundation:armor.helmetBronze>, #Extra Bronze 1
		<MekanismTools:BronzeHelmet> #Extra Bronze 2
	] as IItemStack[];
	
	var chestplates = [ 
		<minecraft:iron_chestplate>,
		<minecraft:golden_chestplate>,
		<ThermalFoundation:armor.plateCopper>,
		<ThermalFoundation:armor.plateTin>,
		<ThermalFoundation:armor.plateSilver>,
		<ThermalFoundation:armor.plateLead>,
		<ThermalFoundation:armor.plateNickel>,
		<ThermalFoundation:armor.platePlatinum>,
		<IC2:itemArmorBronzeChestplate>,
		<MekanismTools:OsmiumChestplate>,
		<MekanismTools:SteelChestplate>,
		<Thaumcraft:ItemChestplateThaumium>,
		<Thaumcraft:ItemChestplateVoid>,
		<ThermalFoundation:armor.plateElectrum>,
		<ThermalFoundation:armor.plateBronze>, #Extra Bronze 1
		<MekanismTools:BronzeChestplate> #Extra Bronze 2
	] as IItemStack[];
	
	var leggings = [ 
		<minecraft:iron_leggings>,
		<minecraft:golden_leggings>,
		<ThermalFoundation:armor.legsCopper>,
		<ThermalFoundation:armor.legsTin>,
		<ThermalFoundation:armor.legsSilver>,
		<ThermalFoundation:armor.legsLead>,
		<ThermalFoundation:armor.legsNickel>,
		<ThermalFoundation:armor.legsPlatinum>,
		<IC2:itemArmorBronzeLegs>,
		<MekanismTools:OsmiumLeggings>,
		<MekanismTools:SteelLeggings>,
		<Thaumcraft:ItemLeggingsThaumium>,
		<Thaumcraft:ItemLeggingsVoid>,
		<ThermalFoundation:armor.legsElectrum>,
		<ThermalFoundation:armor.legsBronze>, #Extra Bronze 1
		<MekanismTools:BronzeLeggings> #Extra Bronze 2
	] as IItemStack[];
	
	var boots = [ 
		<minecraft:iron_boots>,
		<minecraft:golden_boots>,
		<ThermalFoundation:armor.bootsCopper>,
		<ThermalFoundation:armor.bootsTin>,
		<ThermalFoundation:armor.bootsSilver>,
		<ThermalFoundation:armor.bootsLead>,
		<ThermalFoundation:armor.bootsNickel>,
		<ThermalFoundation:armor.bootsPlatinum>,
		<IC2:itemArmorBronzeBoots>,
		<MekanismTools:OsmiumBoots>,
		<MekanismTools:SteelBoots>,
		<Thaumcraft:ItemBootsThaumium>,
		<Thaumcraft:ItemBootsVoid>,
		<ThermalFoundation:armor.bootsElectrum>,
		<ThermalFoundation:armor.bootsBronze>, #Extra Bronze 1
		<MekanismTools:BronzeBoots> #Extra Bronze 2
	] as IItemStack[];
	
	#for removal only
	#these need to be exactly the arc furnace's output, I guess
	var outputIngots = [ 
		<minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<ImmersiveEngineering:metal>, #copper
		<ThermalFoundation:material:65>, #tin
		<ImmersiveEngineering:metal:3>, #silver
		<ImmersiveEngineering:metal:2>, #lead
		<ImmersiveEngineering:metal:4>, #nickel
		<ThermalFoundation:material:69>, #platinum
		<minecraft:iron_ingot>, #no recipe to smelt these down exists yet
		<minecraft:iron_ingot>, #no recipe to smelt these down exists yet
		<minecraft:iron_ingot>, #no recipe to smelt these down exists yet
		<Thaumcraft:ItemResource:2>, #thaumium
		<Thaumcraft:ItemResource:16>, #void
		<ImmersiveEngineering:metal:6>, #electrum
		<ThermalFoundation:material:73>, #Extra Bronze 1
		<minecraft:iron_ingot> #no recipe to smelt these down exists yet
	] as IItemStack[];
	
	#for creation only
	#These need not be specific
	var outputNuggets = [ 
		<ThermalFoundation:material:8>, #iron
		<minecraft:gold_nugget>,
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:105>, #bronze
		<aobd:nuggetOsmium>,
		<ImmersiveEngineering:metal:29>, #steel
		<Thaumcraft:ItemNugget:6>, #thaumium
		<Thaumcraft:ItemNugget:7>, #void
		<ThermalFoundation:material:103>, #Electrum
		<ThermalFoundation:material:105>, #Extra Bronze 1
		<ThermalFoundation:material:105> #Extra Bronze 2
	] as IItemStack[];
	
	var moltenMetals = [ <liquid:iron.molten>, #iron
		<liquid:gold.molten>, #gold
		<liquid:copper.molten>, #copper
		<liquid:tin.molten>, #tin
		<liquid:silver.molten>, #silver
		<liquid:lead.molten>, #lead
		<liquid:nickel.molten>, #nickel
		<liquid:platinum.molten>, #platinum
		<liquid:bronze.molten>, #bronze
		<liquid:osmium.molten>, #osmium
		<liquid:steel.molten>, #steel
		<liquid:glue>,
		<liquid:glue>,
		<liquid:electrum.molten>, #electrum
		<liquid:bronze.molten>, #bronze
		<liquid:bronze.molten> #bronze
	] as ILiquidStack[];
	
	var smeltingTemperatures = [ 600, #iron
		400, #gold
		550, #copper
		350, #tin
		550, #silver
		500, #lead
		500, #nickel
		550, #platinum
		500, #bronze
		1200, #osmium
		610, #steel
		2000, #thaumium
		2000, #void
		400, #electrum
		500, #bronze
		500 #bronze
	] as int[];
	
	var renderBlocks = [ 
		<minecraft:iron_block>,
		<minecraft:gold_block>,
		<ThermalFoundation:Storage>, #copper
		<ThermalFoundation:Storage:1>, #tin
		<ThermalFoundation:Storage:2>, #silver
		<ThermalFoundation:Storage:3>, #lead
		<ThermalFoundation:Storage:4>, #nickel
		<ThermalFoundation:Storage:5>, #platinum
		<ThermalFoundation:Storage:9>, #bronze
		<Mekanism:BasicBlock>, #osmium
		<Metallurgy:base.block:7>, #steel
		<Thaumcraft:blockCosmeticSolid:4>, #thaumium
		<WitchingGadgets:WG_MetalDevice:7>, #void
		<ThermalFoundation:Storage:7>, #Electrum
		<ThermalFoundation:Storage:9>, #Extra Bronze 1
		<ThermalFoundation:Storage:9> #Extra Bronze 2
	] as IItemStack[];
	
#Recipe removal
	#all
		for i, headpan in helmets {
			recipes.remove(headpan);
			recipes.remove(chestplates[i]);
			recipes.remove(leggings[i]);
			recipes.remove(boots[i]);
			
			ArcFurnace.removeRecipe(outputIngots[i] * 4); #IE Arc Furnace
			ArcFurnace.removeRecipe(outputIngots[i] * 8); #IE Arc Furnace
			ArcFurnace.removeRecipe(outputIngots[i] * 7); #IE Arc Furnace
			ArcFurnace.removeRecipe(outputIngots[i] * 5); #IE Arc Furnace
			
			ISmelter.removeRecipe(headpan, <minecraft:sand>); #TE Induction smelter Sand
			ISmelter.removeRecipe(chestplates[i], <minecraft:sand>);
			ISmelter.removeRecipe(leggings[i], <minecraft:sand>);
			ISmelter.removeRecipe(boots[i], <minecraft:sand>);
			
			Smeltery.removeMelting(headpan); #TiC Smeltery
			Smeltery.removeMelting(chestplates[i]);
			Smeltery.removeMelting(leggings[i]);
			Smeltery.removeMelting(boots[i]);
		}
		
		BlastFurnace.removeRecipe(<Railcraft:ingot> * 5);
		BlastFurnace.removeRecipe(<Railcraft:ingot> * 8);
		BlastFurnace.removeRecipe(<Railcraft:ingot> * 7);
		BlastFurnace.removeRecipe(<Railcraft:ingot> * 4);
		
#Recipe creation	
	#all
		for i, nugget in oreDictNuggets {
			#helmets
			recipes.addShaped(helmets[i], 
				[[oreDictIngots[i], nugget, oreDictIngots[i]],
				[nugget, null, nugget]]);
			#chestplates
				recipes.addShaped(chestplates[i], 
				[[nugget, null, nugget],
				[oreDictIngots[i], nugget, oreDictIngots[i]], 
				[oreDictIngots[i], nugget, oreDictIngots[i]]]);
			#leggings
				recipes.addShaped(leggings[i], 
				[[oreDictIngots[i], oreDictIngots[i], oreDictIngots[i]],
				[nugget, null, nugget], 
				[nugget, null, nugget]]);
			#boots
				recipes.addShaped(boots[i], 
				[[nugget, null, nugget],
				[oreDictIngots[i], null, oreDictIngots[i]]]);
			
			ArcFurnace.addRecipe(outputNuggets[i] * 21, helmets[i], <ImmersiveEngineering:material:13>, 300, 256, [], "Recycling"); #IE Arc Furnace
			ArcFurnace.addRecipe(outputNuggets[i] * 40, chestplates[i], <ImmersiveEngineering:material:13>, 600, 256, [], "Recycling");
			ArcFurnace.addRecipe(outputNuggets[i] * 31, leggings[i], <ImmersiveEngineering:material:13>, 450, 256, [], "Recycling");
			ArcFurnace.addRecipe(outputNuggets[i] * 20, boots[i], <ImmersiveEngineering:material:13>, 300, 256, [], "Recycling");
			
			ISmelter.addRecipe(3000, <minecraft:sand>, helmets[i], outputNuggets[i] * 21, <ThermalExpansion:material:514> , 20 ); #TE Induction smelter Sand
			ISmelter.addRecipe(6000, <minecraft:sand>, chestplates[i], outputNuggets[i] * 40, <ThermalExpansion:material:514> , 20 );
			ISmelter.addRecipe(4500, <minecraft:sand>, leggings[i], outputNuggets[i] * 31, <ThermalExpansion:material:514> , 20 );
			ISmelter.addRecipe(3000, <minecraft:sand>, boots[i], outputNuggets[i] * 20, <ThermalExpansion:material:514> , 20 );
			
			Smeltery.addMelting(helmets[i], moltenMetals[i] * 336, smeltingTemperatures[i], renderBlocks[i]); #TiC Smeltery
			Smeltery.addMelting(chestplates[i], moltenMetals[i] * 640, smeltingTemperatures[i], renderBlocks[i]);
			Smeltery.addMelting(leggings[i], moltenMetals[i] * 496, smeltingTemperatures[i], renderBlocks[i]);
			Smeltery.addMelting(boots[i], moltenMetals[i] * 320, smeltingTemperatures[i], renderBlocks[i]);
			
			Crucible.addRecipe(30000, helmets[i], moltenMetals[i] * 336); #TE Crucible
			Crucible.addRecipe(60000, chestplates[i], moltenMetals[i] * 640);
			Crucible.addRecipe(45000, leggings[i], moltenMetals[i] * 176);
			Crucible.addRecipe(30000, boots[i], moltenMetals[i] * 320);
		}
		
		BlastFurnace.addRecipe(<minecraft:iron_helmet>, false, false, 300, <ImmersiveEngineering:metal:29> * 21); #Iron armour to tools
		BlastFurnace.addRecipe(<minecraft:iron_chestplate>, false, false, 600, <ImmersiveEngineering:metal:29> * 40); #Iron armour to tools
		BlastFurnace.addRecipe(<minecraft:iron_leggings>, false, false, 450, <ImmersiveEngineering:metal:29> * 31); #Iron armour to tools		
		BlastFurnace.addRecipe(<minecraft:iron_boots>, false, false, 300, <ImmersiveEngineering:metal:29> * 20); #Iron armour to tools

		ArcFurnace.addRecipe(<ThermalFoundation:material:8> * 39, <OpenBlocks:sonicglasses>, <ImmersiveEngineering:material:13>, 600, 256, [], "Recycling"); #IE Arc Furnace
