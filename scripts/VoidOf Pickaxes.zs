#start of the pickaxe processing minetweaker script

#Imports
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;

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
	#8 -> Manasteel (Mithril)
	#9 -> Elementium
	#10 -> Osmium
	#11 -> Steel (Refined Iron)
	#12 -> Boron
	#13 -> Thaumium
	#14 -> Void metal
	#15 -> Electrum
	#16 -> Aluminum	

	var oreDictIngots = [ <ore:ingotIron>,
		<ore:ingotGold>,
		<ore:ingotCopper>,
		<ore:ingotTin>,
		<ore:ingotSilver>,
		<ore:ingotLead>,
		<ore:ingotNickel>,
		<ore:ingotPlatinum>,
		<ore:ingotManasteel>,
		<ore:ingotElvenElementium>,
		<ore:ingotBronze>,
		<ore:ingotOsmium>,
		<ore:ingotSteel>,
		<ore:ingotThaumium>,
		<ore:ingotVoid>,
		<ore:ingotElectrum>,
		<ore:nuggetBronze>,
		<ore:ingotBronze>,
		<ore:ingotAluminum>
	] as IIngredient[];

	var oreDictNuggets = [ <ore:nuggetIron>,
		<ore:nuggetGold>,
		<ore:nuggetCopper>,
		<ore:nuggetTin>,
		<ore:nuggetSilver>,
		<ore:nuggetLead>,
		<ore:nuggetNickel>,
		<ore:nuggetPlatinum>,
		<ore:nuggetManasteel>,
		<ore:nuggetElvenElementium>,
		<ore:nuggetBronze>,
		<ore:nuggetOsmium>,
		<ore:nuggetSteel>,
		<ore:nuggetThaumium>,
		<ore:nuggetVoid>,
		<ore:nuggetElectrum>,
		<ore:ingotBronze>,
		<ore:ingotBronze>,
		<ore:nuggetAluminum>
	] as IIngredient[];
	
	var pickaxes = [ <minecraft:iron_pickaxe>,
		<minecraft:golden_pickaxe>,
		<ThermalFoundation:tool.pickaxeCopper>,
		<ThermalFoundation:tool.pickaxeTin>,
		<ThermalFoundation:tool.pickaxeSilver>,
		<ThermalFoundation:tool.pickaxeLead>,
		<ThermalFoundation:tool.pickaxeNickel>,
		<ThermalFoundation:tool.pickaxePlatinum>,
		<Botania:manasteelPick>,
		<Botania:elementiumPick>,
		<IC2:itemToolBronzePickaxe>, #250 Durability
		<MekanismTools:OsmiumPickaxe>,
		<MekanismTools:SteelPickaxe>,
		<Thaumcraft:ItemPickThaumium>,
		<Thaumcraft:ItemPickVoid>,
		<ThermalFoundation:tool.pickaxeElectrum>,
		<ThermalFoundation:tool.pickaxeBronze>, #500 Durability.
		<MekanismTools:BronzePickaxe>, #800 Durability.
		<minecraft:iron_pickaxe>, #aluminium
	] as IItemStack[];

#Recipe removal
	#pickaxes
		for output in pickaxes {
			recipes.remove(output);
		}

#Recipe creation	
	#pickaxes
		for i, nugget in oreDictNuggets {
			recipes.addShaped(pickaxes[i], 
				[[nugget, oreDictIngots[i], nugget],
				[null, <ore:stickWood>, null],
				[null, <ore:stickWood>, null]]);
		}
#Bronze Pickaxe is a triplicate and has three different stages of durability that are determined by the crafting ingredients.
#Aluminium can be used to craft iron pickaxes.