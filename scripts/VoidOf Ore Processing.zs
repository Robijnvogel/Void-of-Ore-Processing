#Document title: VoidOf Ore Processing.zs
#Author: Robijnvogel
#Version:
#Date:
#Licence: Copying from this script is allowed, however it would be nice if you notified the author.

#List of mod dependencies:
	#Everything in the imports and the dependencies of those mods
	#ActuallyAdditions
	#Applied Energistics
	#Metallurgy
	#Steamcraft
	
	#List is not finished


#Imports
	import minetweaker.data.IData;
	import minetweaker.item.IItemStack;
	import minetweaker.item.IIngredient;
	import minetweaker.liquid.ILiquidStack;
	import modtweaker.gas.IGasStack;

	import mods.botania.ManaInfusion;
	import mods.extraUtils.QED;
	import mods.factorization.Crystallizer as FZCrystallizer;
	import mods.factorization.Lacerator;
	import mods.factorization.SlagFurnace;
	import mods.ic2.Macerator;
	import mods.ic2.OreWasher;
	import mods.ic2.ThermalCentrifuge;
	import mods.immersiveengineering.ArcFurnace;
	import mods.immersiveengineering.Crusher as IECrusher;
	import mods.mekanism.chemical.Crystallizer as MKCrystallizer;
	import mods.mekanism.chemical.Injection;
	import mods.mekanism.chemical.Dissolution;
	import mods.mekanism.Combiner;
	import mods.mekanism.Crusher as MKCrusher;
	import mods.mekanism.Enrichment;
	import mods.mekanism.Purification;
	import mods.tconstruct.Casting;
	import mods.tconstruct.Smeltery;
	import mods.thermalexpansion.Crucible;
	import mods.thermalexpansion.Furnace as RSFurnace;
	import mods.thermalexpansion.Pulverizer;
	import mods.thermalexpansion.Smelter as ISmelter;
	import mods.thaumcraft.Aspects;
	import mods.witchinggadgets.InfernalBlastfurnace;

#Item lists
	#in the rest of this document, some lists of items are used.
	#These lists will have the following order:
	#0 -> Iron
	#1 -> Gold
	#2 -> Copper
	#3 -> Tin
	#4 -> Silver (Galena)
	#5 -> Lead
	#6 -> Nickel (Ferrous)
	#7 -> Platinum (Shiny)
	#8 -> Mithril (ManaSteel)
	#9 -> Aluminium
	#10 -> Osmium
	#11 -> Zinc
	#12 -> Cobalt
	#13 -> Ardite
	#14 -> Yellorite
	#15 -> Manganese
	#16 -> Eximite
	#17 -> Meutoite
	#18 -> Prometheum
	#19 -> Deep Iron
	#20 -> Infuscolium
	#21 -> Oureclase
	#22 -> Astral Silver
	#23 -> Carmot
	#24 -> Rubracium (skip mithril)
	#25 -> Orichalcum
	#26 -> Adamantine
	#27 -> Atlarus
	#28 -> Ignatius
	#29 -> Shadow Iron
	#30 -> Lemurite
	#31 -> Midasium
	#32 -> Vyroxeres
	#33 -> Ceruclase
	#34 -> Alduorite
	#35 -> Kalendrite
	#36 -> Vulcanite
	#37 -> Sanguinite
	#38 -> Dark Iron (always last)

	var oredictOres = [ <ore:oreIron>,
		<ore:oreGold>,
		<ore:oreCopper>,
		<ore:oreTin>,
		<ore:oreSilver>,
		<ore:oreLead>,
		<ore:oreNickel>,
		<ore:orePlatinum>,
		<ore:oreMithril>,
		<ore:oreAluminum>,
		<ore:oreOsmium>,
		<ore:oreZinc>,
		<ore:oreCobalt>,
		<ore:oreArdite>,
		<ore:oreYellorium>,
		<ore:oreManganese>,
		<ore:oreEximite>,
		<ore:oreMeutoite>,
		<ore:orePrometheum>,
		<ore:oreDeepIron>,
		<ore:oreInfuscolium>,
		<ore:oreOureclase>,
		<ore:oreAstralSilver>,
		<ore:oreCarmot>,
		<ore:oreRubracium>,
		<ore:oreOrichalcum>,
		<ore:oreAdamantine>,
		<ore:oreAtlarus>,
		<ore:oreIgnatius>,
		<ore:oreShadowIron>,
		<ore:oreLemurite>,
		<ore:oreMidasium>,
		<ore:oreVyroxeres>,
		<ore:oreCeruclase>,
		<ore:oreAlduorite>,
		<ore:oreKalendrite>,
		<ore:oreVulcanite>,
		<ore:oreSanguinite>,
		<ore:oreFzDarkIron>
	] as IIngredient[];

	var oredictDusts = [ <ore:dustIron>,
		<ore:dustGold>,
		<ore:dustCopper>,
		<ore:dustTin>,
		<ore:dustSilver>,
		<ore:dustLead>,
		<ore:dustNickel>,
		<ore:dustPlatinum>,
		<ore:dustMithril>,
		<ore:dustAluminum>,
		<ore:dustOsmium>,
		<ore:dustZinc>,
		<ore:dustCobalt>,
		<ore:dustArdite>,
		<ore:dustYellorium>,
		<ore:dustManganese>,
		<ore:dustEximite>,
		<ore:dustMeutoite>,
		<ore:dustPrometheum>,
		<ore:dustDeepIron>,
		<ore:dustInfuscolium>,
		<ore:dustOureclase>,
		<ore:dustAstralSilver>,
		<ore:dustCarmot>,
		<ore:dustRubracium>,
		<ore:dustOrichalcum>,
		<ore:dustAdamantine>,
		<ore:dustAtlarus>,
		<ore:dustIgnatius>,
		<ore:dustShadowIron>,
		<ore:dustLemurite>,
		<ore:dustMidasium>,
		<ore:dustVyroxeres>,
		<ore:dustCeruclase>,
		<ore:dustAlduorite>,
		<ore:dustKalendrite>,
		<ore:dustVulcanite>,
		<ore:dustSanguinite>,
		<ore:dustFzDarkIron>
	] as IIngredient[];

	var oredictIngots = [ <ore:ingotIron>,
		<ore:ingotGold>,
		<ore:ingotCopper>,
		<ore:ingotTin>,
		<ore:ingotSilver>,
		<ore:ingotLead>,
		<ore:ingotNickel>,
		<ore:ingotPlatinum>,
		<ore:ingotMithril>,
		<ore:ingotAluminum>,
		<ore:ingotOsmium>,
		<ore:ingotZinc>,
		<ore:ingotCobalt>,
		<ore:ingotArdite>,
		<ore:ingotYellorium>,
		<ore:ingotManganese>,
		<ore:ingotEximite>,
		<ore:ingotMeutoite>,
		<ore:ingotPrometheum>,
		<ore:ingotDeepIron>,
		<ore:ingotInfuscolium>,
		<ore:ingotOureclase>,
		<ore:ingotAstralSilver>,
		<ore:ingotCarmot>,
		<ore:ingotRubracium>,
		<ore:ingotOrichalcum>,
		<ore:ingotAdamantine>,
		<ore:ingotAtlarus>,
		<ore:ingotIgnatius>,
		<ore:ingotShadowIron>,
		<ore:ingotLemurite>,
		<ore:ingotMidasium>,
		<ore:ingotVyroxeres>,
		<ore:ingotCeruclase>,
		<ore:ingotAlduorite>,
		<ore:ingotKalendrite>,
		<ore:ingotVulcanite>,
		<ore:ingotSanguinite>,
		<ore:ingotFzDarkIron>
	] as IIngredient[];

	var oredictNuggets = [ <ore:nuggetIron>,
		<ore:nuggetGold>,
		<ore:nuggetCopper>,
		<ore:nuggetTin>,
		<ore:nuggetSilver>,
		<ore:nuggetLead>,
		<ore:nuggetNickel>,
		<ore:nuggetPlatinum>,
		<ore:nuggetMithril>,
		<ore:nuggetAluminum>,
		<ore:nuggetOsmium>,
		<ore:nuggetZinc>,
		<ore:nuggetCobalt>,
		<ore:nuggetArdite>,
		<ore:nuggetYellorium>,
		<ore:nuggetManganese>,
		<ore:nuggetEximite>,
		<ore:nuggetMeutoite>,
		<ore:nuggetPrometheum>,
		<ore:nuggetDeepIron>,
		<ore:nuggetInfuscolium>,
		<ore:nuggetOureclase>,
		<ore:nuggetAstralSilver>,
		<ore:nuggetCarmot>,
		<ore:nuggetRubracium>,
		<ore:nuggetOrichalcum>,
		<ore:nuggetAdamantine>,
		<ore:nuggetAtlarus>,
		<ore:nuggetIgnatius>,
		<ore:nuggetShadowIron>,
		<ore:nuggetLemurite>,
		<ore:nuggetMidasium>,
		<ore:nuggetVyroxeres>,
		<ore:nuggetCeruclase>,
		<ore:nuggetAlduorite>,
		<ore:nuggetKalendrite>,
		<ore:nuggetVulcanite>,
		<ore:nuggetSanguinite>,
		<ore:nuggetFzDarkIron>
	] as IIngredient[];
	
	var oredictBlocks = [ <ore:blockIron>,
		<ore:blockGold>,
		<ore:blockCopper>,
		<ore:blockTin>,
		<ore:blockSilver>,
		<ore:blockLead>,
		<ore:blockNickel>,
		<ore:blockPlatinum>,
		<ore:blockMithril>,
		<ore:blockAluminum>,
		<ore:blockOsmium>,
		<ore:blockZinc>,
		<ore:blockCobalt>,
		<ore:blockArdite>,
		<ore:blockYellorium>,
		<ore:blockManganese>,
		<ore:blockEximite>,
		<ore:blockMeutoite>,
		<ore:blockPrometheum>,
		<ore:blockDeepIron>,
		<ore:blockInfuscolium>,
		<ore:blockOureclase>,
		<ore:blockAstralSilver>,
		<ore:blockCarmot>,
		<ore:blockRubracium>,
		<ore:blockOrichalcum>,
		<ore:blockAdamantine>,
		<ore:blockAtlarus>,
		<ore:blockIgnatius>,
		<ore:blockShadowIron>,
		<ore:blockLemurite>,
		<ore:blockMidasium>,
		<ore:blockVyroxeres>,
		<ore:blockCeruclase>,
		<ore:blockAlduorite>,
		<ore:blockKalendrite>,
		<ore:blockVulcanite>,
		<ore:blockSanguinite>,
		<ore:blockFzDarkIron>
	] as IIngredient[];
	
	var oredictDenseOres = [ <ore:denseoreIron>, #iron
		<ore:denseoreGold>, #gold
		<ore:denseoreCopper>, #copper
		<ore:denseoreTin>, #tin
		<ore:denseoreSilver>, #silver
		<ore:denseoreLead>, #lead
		<ore:denseoreNickel>, #nickel
		<ore:denseorePlatinum>, #platinum
		<ore:denseoreMithril>, #mithril
		<ore:denseoreAluminium>, #aluminium
		<ore:denseoreOsmium>, #osmium
		<ore:denseoreZinc>, #zinc
		<ore:denseoreCobalt>, #cobalt
		<ore:denseoreArdite>, #ardite
		<ore:denseoreYellorium>, #yellorium
		<ore:denseoreManganese>, #manganese
		<ore:denseoreEximite>, #eximite
		<ore:denseoreMeutoite>, #meutoite
		<ore:denseorePrometheum>, #prometheum
		<ore:denseoreDeepIron>, #deep iron
		<ore:denseoreInfuscolium>, #infuscolium
		<ore:denseoreOureclase>, #oureclase
		<ore:denseoreAstralSilver>, #astral silver
		<ore:denseoreCarmot>, #carmot
		<ore:denseoreRubracium>, #rubracium
		<ore:denseoreOrichalcum>, #orichalcum
		<ore:denseoreAdamantine>, #adamantine
		<ore:denseoreAtlarus>, #atlarus
		<ore:denseoreIgnatius>, #ignatius
		<ore:denseoreShadowIron>, #shadow iron
		<ore:denseoreLemurite>, #lemurite
		<ore:denseoreMidasium>, #midasium
		<ore:denseoreVyroxeres>, #vyroxeres
		<ore:denseoreCeruclase>, #ceruclase
		<ore:denseoreAlduorite>, #alduorite
		<ore:denseoreKalendrite>, #kalendrite
		<ore:denseoreVulcanite>, #vulcanite
		<ore:denseoreSanguinite>, #sanguinite
		<ore:denseoreFzDarkIron> #dark iron
	] as IIngredient[];
	
	var oredictOreBerries = [ <ore:oreberryIron>,
		<ore:oreberryGold>,
		<ore:oreberryCopper>,
		<ore:oreberryTin>,
		<ore:oreberrySilver>,
		<ore:oreberryLead>,
		<ore:oreberryNickel>,
		<ore:oreberryPlatinum>,
		<ore:oreberryMithril>,
		<ore:oreberryAluminum>,
		<ore:oreberryOsmium>,
		<ore:oreberryZinc>,
		<ore:oreberryCobalt>,
		<ore:oreberryArdite>,
		<ore:oreberryYellorium>,
		<ore:oreberryManganese>,
		<ore:oreberryEximite>,
		<ore:oreberryMeutoite>,
		<ore:oreberryPrometheum>,
		<ore:oreberryDeepIron>,
		<ore:oreberryInfuscolium>,
		<ore:oreberryOureclase>,
		<ore:oreberryAstralSilver>,
		<ore:oreberryCarmot>,
		<ore:oreberryRubracium>,
		<ore:oreberryOrichalcum>,
		<ore:oreberryAdamantine>,
		<ore:oreberryAtlarus>,
		<ore:oreberryIgnatius>,
		<ore:oreberryShadowIron>,
		<ore:oreberryLemurite>,
		<ore:oreberryMidasium>,
		<ore:oreberryVyroxeres>,
		<ore:oreberryCeruclase>,
		<ore:oreberryAlduorite>,
		<ore:oreberryKalendrite>,
		<ore:oreberryVulcanite>,
		<ore:oreberrySanguinite>,
		<ore:oreberryFzDarkIron>
	] as IIngredient[];

	var tfOres = [ <minecraft:iron_ore>,
		<minecraft:gold_ore>,
		<ThermalFoundation:Ore>, #copper
		<ThermalFoundation:Ore:1>, #tin
		<ThermalFoundation:Ore:2>, #silver
		<ThermalFoundation:Ore:3>, #lead
		<ThermalFoundation:Ore:4>, #nickel
		<ThermalFoundation:Ore:5>, #platinum
		<ThermalFoundation:Ore:6>, #mithril
		<TConstruct:SearedBrick:5>, #aluminium
		<Mekanism:OreBlock>, #osmium
		<Steamcraft:steamcraftOre:1>, #zinc
		<TConstruct:SearedBrick:1>, #cobalt
		<TConstruct:SearedBrick:2>, #ardite
		<BigReactors:YelloriteOre>, #yellorite
		<Metallurgy:base.ore:2>, #manganese
		<Metallurgy:ender.ore:0>, #eximite
		<Metallurgy:ender.ore:1>, #meutoite
		<Metallurgy:fantasy.ore:0>, #prometheum
		<Metallurgy:fantasy.ore:1>, #deep Iron
		<Metallurgy:fantasy.ore:2>, #infuscolium
		<Metallurgy:fantasy.ore:4>, #oureclase
		<Metallurgy:fantasy.ore:5>, #astralSilver
		<Metallurgy:fantasy.ore:6>, #carmot
		<Metallurgy:fantasy.ore:8>, #rubracium
		<Metallurgy:fantasy.ore:11>, #orichalcum
		<Metallurgy:fantasy.ore:13>, #adamantine
		<Metallurgy:fantasy.ore:14>, #atlarus
		<Metallurgy:nether.ore:0>, #ignatius
		<Metallurgy:nether.ore:1>, #shadowIron
		<Metallurgy:nether.ore:2>, #lemurite
		<Metallurgy:nether.ore:3>, #midasium
		<Metallurgy:nether.ore:4>, #vyroxeres
		<Metallurgy:nether.ore:5>, #ceruclase
		<Metallurgy:nether.ore:6>, #alduorite
		<Metallurgy:nether.ore:7>, #kalendrite
		<Metallurgy:nether.ore:8>, #vulcanite
		<Metallurgy:nether.ore:9>, #sanguinite
		<factorization:DarkIronOre>
	] as IItemStack[];

	var tfNuggets = [ <ThermalFoundation:material:8>, #iron
		<minecraft:gold_nugget>,
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:102>, #mithril
		<TConstruct:materials:22>, #aluminium
		<aobd:nuggetOsmium>,
		<Steamcraft:steamcraftNugget:1>, #zinc
		<TConstruct:materials:28>, #cobalt
		<TConstruct:materials:29>, #ardite
		<aobd:nuggetYellorium>, #yellorite
		<Metallurgy:base.nugget:2>, #manganese
		<Metallurgy:ender.nugget>, #eximite
		<Metallurgy:ender.nugget:1>, #meutoite
		<Metallurgy:fantasy.nugget>, #prometheum
		<Metallurgy:fantasy.nugget:1>, #deep Iron
		<Metallurgy:fantasy.nugget:2>, #infuscolium
		<Metallurgy:fantasy.nugget:4>, #oureclase
		<Metallurgy:fantasy.nugget:5>, #astralSilver
		<Metallurgy:fantasy.nugget:6>, #carmot
		<Metallurgy:fantasy.nugget:8>, #rubracium
		<Metallurgy:fantasy.nugget:11>, #orichalcum
		<Metallurgy:fantasy.nugget:13>, #adamantine
		<Metallurgy:fantasy.nugget:14>, #atlarus
		<Metallurgy:nether.nugget>, #ignatius
		<Metallurgy:nether.nugget:1>, #shadowIron
		<Metallurgy:nether.nugget:2>, #lemurite
		<Metallurgy:nether.nugget:3>, #midasium
		<Metallurgy:nether.nugget:4>, #vyroxeres
		<Metallurgy:nether.nugget:5>, #ceruclase
		<Metallurgy:nether.nugget:6>, #alduorite
		<Metallurgy:nether.nugget:7>, #kalendrite
		<Metallurgy:nether.nugget:8>, #vulcanite
		<Metallurgy:nether.nugget:9>, #sanguinite
		<aobd:nuggetFzDarkIron>
	] as IItemStack[];

	var ic2Ingots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<IC2:itemIngot>, #copper
		<IC2:itemIngot:1>, #tin
		<IC2:itemIngot:6>, #silver
		<IC2:itemIngot:5>, #lead
		<ThermalFoundation:material:68>, #nickel
		<ThermalFoundation:material:69>, #platinum
		<ThermalFoundation:material:70>, #mithril
		<TConstruct:materials:11>, #aluminium
		<Mekanism:Ingot:1>, #osmium
		<Steamcraft:steamcraftIngot:1>, #zinc
		<TConstruct:materials:3>, #cobalt
		<TConstruct:materials:4>, #ardite
		<BigReactors:BRIngot>, #yellorite
		<Metallurgy:manganese.ingot>,
		<Metallurgy:eximite.ingot>,
		<Metallurgy:meutoite.ingot>,
		<Metallurgy:prometheum.ingot>,
		<Metallurgy:deep.iron.ingot>,
		<Metallurgy:infuscolium.ingot>,
		<Metallurgy:oureclase.ingot>,
		<Metallurgy:astral.silver.ingot>,
		<Metallurgy:carmot.ingot>,
		<Metallurgy:rubracium.ingot>,
		<Metallurgy:orichalcum.ingot>,
		<Metallurgy:adamantine.ingot>,
		<Metallurgy:atlarus.ingot>,
		<Metallurgy:ignatius.ingot>,
		<Metallurgy:shadow.iron.ingot>,
		<Metallurgy:lemurite.ingot>,
		<Metallurgy:midasium.ingot>,
		<Metallurgy:vyroxeres.ingot>,
		<Metallurgy:ceruclase.ingot>,
		<Metallurgy:alduorite.ingot>,
		<Metallurgy:kalendrite.ingot>,
		<Metallurgy:vulcanite.ingot>,
		<Metallurgy:sanguinite.ingot>,
		<factorization:dark_iron_ingot>
	] as IItemStack[];

	var ieIngots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<ImmersiveEngineering:metal>, #copper
		<ThermalFoundation:material:65>, #tin
		<ImmersiveEngineering:metal:3>, #silver
		<ImmersiveEngineering:metal:2>, #lead
		<ImmersiveEngineering:metal:4>, #nickel
		<ThermalFoundation:material:69>, #platinum
		<ThermalFoundation:material:70>, #mithril
		<ImmersiveEngineering:metal:1>, #aluminium
		<Mekanism:Ingot:1>, #osmium
		<Steamcraft:steamcraftIngot:1>, #zinc
		<TConstruct:materials:3>, #cobalt
		<TConstruct:materials:4>, #ardite
		<BigReactors:BRIngot>, #yellorite
		<Metallurgy:manganese.ingot>,
		<Metallurgy:eximite.ingot>,
		<Metallurgy:meutoite.ingot>,
		<Metallurgy:prometheum.ingot>,
		<Metallurgy:deep.iron.ingot>,
		<Metallurgy:infuscolium.ingot>,
		<Metallurgy:oureclase.ingot>,
		<Metallurgy:astral.silver.ingot>,
		<Metallurgy:carmot.ingot>,
		<Metallurgy:rubracium.ingot>,
		<Metallurgy:orichalcum.ingot>,
		<Metallurgy:adamantine.ingot>,
		<Metallurgy:atlarus.ingot>,
		<Metallurgy:ignatius.ingot>,
		<Metallurgy:shadow.iron.ingot>,
		<Metallurgy:lemurite.ingot>,
		<Metallurgy:midasium.ingot>,
		<Metallurgy:vyroxeres.ingot>,
		<Metallurgy:ceruclase.ingot>,
		<Metallurgy:alduorite.ingot>,
		<Metallurgy:kalendrite.ingot>,
		<Metallurgy:vulcanite.ingot>,
		<Metallurgy:sanguinite.ingot>,
		<factorization:dark_iron_ingot> #dark iron
	] as IItemStack[];

	var tfBlocks = [ <minecraft:iron_block>,
		<minecraft:gold_block>,
		<ThermalFoundation:Storage>, #copper
		<ThermalFoundation:Storage:1>, #tin
		<ThermalFoundation:Storage:2>, #silver
		<ThermalFoundation:Storage:3>, #lead
		<ThermalFoundation:Storage:4>, #nickel
		<ThermalFoundation:Storage:5>, #platinum
		<ThermalFoundation:Storage:6>, #mithril
		<TConstruct:MetalBlock:6>, #aluminium
		<Mekanism:BasicBlock>, #osmium
		<Steamcraft:blockZinc>, #zinc
		<TConstruct:MetalBlock>, #cobalt
		<TConstruct:MetalBlock:1>, #ardite
		<BigReactors:BRMetalBlock>, #yellorite
		<Metallurgy:base.block:2>, #manganese
		<Metallurgy:ender.block:0>, #eximite
		<Metallurgy:ender.block:1>, #meutoite
		<Metallurgy:fantasy.block:0>, #prometheum
		<Metallurgy:fantasy.block:1>, #deep Iron
		<Metallurgy:fantasy.block:2>, #infuscolium
		<Metallurgy:fantasy.block:4>, #oureclase
		<Metallurgy:fantasy.block:5>, #astralSilver
		<Metallurgy:fantasy.block:6>, #carmot
		<Metallurgy:fantasy.block:8>, #rubracium
		<Metallurgy:fantasy.block:11>, #orichalcum
		<Metallurgy:fantasy.block:13>, #adamantine
		<Metallurgy:fantasy.block:14>, #atlarus
		<Metallurgy:nether.block:0>, #ignatius
		<Metallurgy:nether.block:1>, #shadowIron
		<Metallurgy:nether.block:2>, #lemurite
		<Metallurgy:nether.block:3>, #midasium
		<Metallurgy:nether.block:4>, #vyroxeres
		<Metallurgy:nether.block:5>, #ceruclase
		<Metallurgy:nether.block:6>, #alduorite
		<Metallurgy:nether.block:7>, #kalendrite
		<Metallurgy:nether.block:8>, #vulcanite
		<Metallurgy:nether.block:9>, #sanguinite
		<factorization:ResourceBlock:3> #dark iron
	] as IItemStack[];
	
	var tfDenseOres = [ <denseores:block0>, #iron
		<denseores:block0:1>, #gold
		<denseores:block1:14>, #copper
		<denseores:block1:15>, #tin
		<denseores:block2>, #silver
		<denseores:block2:1>, #lead
		<denseores:block2:2>, #nickel
		<denseores:block2:3>, #platinum
		<denseores:block2:4>, #mithril
		<denseores:block2:9>, #aluminium
		<denseores:block5:13>, #osmium
		<denseores:block8:11>, #zinc
		<denseores:block2:5>, #cobalt
		<denseores:block2:6>, #ardite
		<denseores:block0:8>, #yellorium
		<denseores:block6:2>, #manganese
		<denseores:block6:3>, #eximite
		<denseores:block6:4>, #meutoite
		<denseores:block6:5>, #prometheum
		<denseores:block6:6>, #deep iron
		<denseores:block6:7>, #infuscolium
		<denseores:block6:8>, #oureclase
		<denseores:block6:9>, #astral silver
		<denseores:block6:10>, #carmot
		<denseores:block6:12>, #rubracium
		<denseores:block6:13>, #orichalcum
		<denseores:block6:14>, #adamantine
		<denseores:block6:15>, #atlarus
		<denseores:block7>, #ignatius
		<denseores:block7:1>, #shadow iron
		<denseores:block7:2>, #lemurite
		<denseores:block7:3>, #midasium
		<denseores:block7:4>, #vyroxeres
		<denseores:block7:5>, #ceruclase
		<denseores:block7:6>, #alduorite
		<denseores:block7:7>, #kalendrite
		<denseores:block7:8>, #vulcanite
		<denseores:block7:9>, #sanguinite
		<denseores:block0:10> #dark iron
	] as IItemStack[];

	var ic2Dusts = [ <IC2:itemDust:5>, #iron
		<IC2:itemDust:4>, #gold
		<IC2:itemDust:3>, #copper
		<IC2:itemDust:7>, #tin
		<IC2:itemDust:6>, #silver
		<IC2:itemDust:10>, #lead
		<ThermalFoundation:material:36>, #nickel
		<ThermalFoundation:material:37>, #platinum
		<ThermalFoundation:material:38>, #mithril
		<TConstruct:materials:40>, #aluminium
		<Mekanism:Dust:2>, #osmium
		<Metallurgy:precious.dust>, #zinc
		<TConstruct:materials:39>, #cobalt
		<TConstruct:materials:38>, #ardite
		<BigReactors:BRIngot:4>, #yellorite
		<Metallurgy:base.dust:2>, #manganese
		<Metallurgy:ender.dust:0>, #eximite
		<Metallurgy:ender.dust:1>, #meutoite
		<Metallurgy:fantasy.dust:0>, #prometheum
		<Metallurgy:fantasy.dust:1>, #deep Iron
		<Metallurgy:fantasy.dust:2>, #infuscolium
		<Metallurgy:fantasy.dust:4>, #oureclase
		<Metallurgy:fantasy.dust:5>, #astralSilver
		<Metallurgy:fantasy.dust:6>, #carmot
		<Metallurgy:fantasy.dust:8>, #rubracium
		<Metallurgy:fantasy.dust:11>, #orichalcum
		<Metallurgy:fantasy.dust:13>, #adamantine
		<Metallurgy:fantasy.dust:14>, #atlarus
		<Metallurgy:nether.dust:0>, #ignatius
		<Metallurgy:nether.dust:1>, #shadowIron
		<Metallurgy:nether.dust:2>, #lemurite
		<Metallurgy:nether.dust:3>, #midasium
		<Metallurgy:nether.dust:4>, #vyroxeres
		<Metallurgy:nether.dust:5>, #ceruclase
		<Metallurgy:nether.dust:6>, #alduorite
		<Metallurgy:nether.dust:7>, #kalendrite
		<Metallurgy:nether.dust:8>, #vulcanite
		<Metallurgy:nether.dust:9>, #sanguinite
		<aobd:dustFzDarkIron>
	] as IItemStack[];

	#used for removal of IE ore + hammer -> dust recipes
	var ieDusts = [ <ImmersiveEngineering:metal:8>, #iron
		<ImmersiveEngineering:metal:9>, #gold
		<ImmersiveEngineering:metal:10>, #copper
		<ThermalFoundation:material:33>, #tin
		<ImmersiveEngineering:metal:13>, #silver
		<ImmersiveEngineering:metal:12>, #lead
		<ImmersiveEngineering:metal:14>, #nickel
		<ThermalFoundation:material:37>, #platinum
		<ThermalFoundation:material:38>, #mithril
		<ImmersiveEngineering:metal:11>, #aluminium
		<Mekanism:Dust:2>, #osmium
		<Metallurgy:precious.dust>, #zinc
		<TConstruct:materials:39>, #cobalt
		<TConstruct:materials:38>, #ardite
		<BigReactors:BRIngot:4>, #yellorite
		<Metallurgy:base.dust:2>, #manganese
		<Metallurgy:ender.dust>, #eximite
		<Metallurgy:ender.dust:1>, #meutoite
		<Metallurgy:fantasy.dust:0>, #prometheum
		<Metallurgy:fantasy.dust:1>, #deep Iron
		<Metallurgy:fantasy.dust:2>, #infuscolium
		<Metallurgy:fantasy.dust:4>, #oureclase
		<Metallurgy:fantasy.dust:5>, #astralSilver
		<Metallurgy:fantasy.dust:6>, #carmot
		<Metallurgy:fantasy.dust:8>, #rubracium
		<Metallurgy:fantasy.dust:11>, #orichalcum
		<Metallurgy:fantasy.dust:13>, #adamantine
		<Metallurgy:fantasy.dust:14>, #atlarus
		<Metallurgy:nether.dust:0>, #ignatius
		<Metallurgy:nether.dust:1>, #shadowIron
		<Metallurgy:nether.dust:2>, #lemurite
		<Metallurgy:nether.dust:3>, #midasium
		<Metallurgy:nether.dust:4>, #vyroxeres
		<Metallurgy:nether.dust:5>, #ceruclase
		<Metallurgy:nether.dust:6>, #alduorite
		<Metallurgy:nether.dust:7>, #kalendrite
		<Metallurgy:nether.dust:8>, #vulcanite
		<Metallurgy:nether.dust:9>, #sanguinite
		<aobd:dustFzDarkIron> #dark iron
	] as IItemStack[];
	
	#used for removal of wg infernal blastfurnace cluster -> ingot recipes
	var wgIngots = [ <minecraft:iron_ingot>,
		<minecraft:gold_ingot>,
		<ThermalFoundation:material:64>, #copper
		<ThermalFoundation:material:65>, #tin
		<ThermalFoundation:material:66>, #silver
		<ThermalFoundation:material:67>, #lead
		<ThermalFoundation:material:68>, #nickel
		<ThermalFoundation:material:69>, #platinum
		<ThermalFoundation:material:70>, #mithril
		<TConstruct:materials:11>, #aluminium
		<Mekanism:Ingot:1>, #osmium
		<Metallurgy:zinc.ingot>, #zinc
		<TConstruct:materials:3>, #cobalt
		<TConstruct:materials:4>, #ardite
		<BigReactors:BRIngot>, #yellorite
		<Metallurgy:manganese.ingot>,
		<Metallurgy:eximite.ingot>,
		<Metallurgy:meutoite.ingot>,
		<Metallurgy:prometheum.ingot>,
		<Metallurgy:deep.iron.ingot>,
		<Metallurgy:infuscolium.ingot>,
		<Metallurgy:oureclase.ingot>,
		<Metallurgy:astral.silver.ingot>,
		<Metallurgy:carmot.ingot>,
		<Metallurgy:rubracium.ingot>,
		<Metallurgy:orichalcum.ingot>,
		<Metallurgy:adamantine.ingot>,
		<Metallurgy:atlarus.ingot>,
		<Metallurgy:ignatius.ingot>,
		<Metallurgy:shadow.iron.ingot>,
		<Metallurgy:lemurite.ingot>,
		<Metallurgy:midasium.ingot>,
		<Metallurgy:vyroxeres.ingot>,
		<Metallurgy:ceruclase.ingot>,
		<Metallurgy:alduorite.ingot>,
		<Metallurgy:kalendrite.ingot>,
		<Metallurgy:vulcanite.ingot>,
		<Metallurgy:sanguinite.ingot>,
		<factorization:dark_iron_ingot>
	] as IItemStack[];

	var ic2TinyDusts = [ <IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>,
		<aobd:dustTinyPlatinum>,
		<aobd:dustTinyMithril>,
		<aobd:dustTinyAluminium>, #aluminium
		<aobd:dustTinyOsmium>,
		<aobd:dustTinyZinc>,
		<aobd:dustTinyCobalt>,
		<aobd:dustTinyArdite>,
		<aobd:dustTinyYellorium>,
		<aobd:dustTinyManganese>,
		<aobd:dustTinyEximite>,
		<aobd:dustTinyMeutoite>,
		<aobd:dustTinyPrometheum>,
		<aobd:dustTinyDeepIron>,
		<aobd:dustTinyInfuscolium>,
		<aobd:dustTinyOureclase>,
		<aobd:dustTinyAstralSilver>,
		<aobd:dustTinyCarmot>,
		<aobd:dustTinyRubracium>,
		<aobd:dustTinyOrichalcum>,
		<aobd:dustTinyAdamantine>,
		<aobd:dustTinyAtlarus>,
		<aobd:dustTinyIgnatius>,
		<aobd:dustTinyShadowIron>,
		<aobd:dustTinyLemurite>,
		<aobd:dustTinyMidasium>,
		<aobd:dustTinyVyroxeres>,
		<aobd:dustTinyCeruclase>,
		<aobd:dustTinyAlduorite>,
		<aobd:dustTinyKalendrite>,
		<aobd:dustTinyVulcanite>,
		<aobd:dustTinySanguinite>,
		<aobd:dustTinyFzDarkIron>
	] as IItemStack[];

	var ic2Crushed = [ <IC2:itemCrushedOre>, #iron
		<IC2:itemCrushedOre:2>, #gold
		<IC2:itemCrushedOre:1>, #copper
		<IC2:itemCrushedOre:3>, #tin
		<IC2:itemCrushedOre:5>, #silver
		<IC2:itemCrushedOre:6>, #lead
		<aobd:crushedNickel>, #nickel
		<aobd:crushedPlatinum>, #platinum
		<aobd:crushedMithril>, #mithril
		<aobd:crushedAluminium>, #aluminium
		<aobd:crushedOsmium>, #osmium
		<aobd:crushedZinc>,
		<aobd:crushedCobalt>,
		<aobd:crushedArdite>,
		<aobd:crushedYellorium>,
		<aobd:crushedManganese>,
		<aobd:crushedEximite>,
		<aobd:crushedMeutoite>,
		<aobd:crushedPrometheum>,
		<aobd:crushedDeepIron>,
		<aobd:crushedInfuscolium>,
		<aobd:crushedOureclase>,
		<aobd:crushedAstralSilver>,
		<aobd:crushedCarmot>,
		<aobd:crushedRubracium>,
		<aobd:crushedOrichalcum>,
		<aobd:crushedAdamantine>,
		<aobd:crushedAtlarus>,
		<aobd:crushedIgnatius>,
		<aobd:crushedShadowIron>,
		<aobd:crushedLemurite>,
		<aobd:crushedMidasium>,
		<aobd:crushedVyroxeres>,
		<aobd:crushedCeruclase>,
		<aobd:crushedAlduorite>,
		<aobd:crushedKalendrite>,
		<aobd:crushedVulcanite>,
		<aobd:crushedSanguinite>,
		<aobd:crushedFzDarkIron>
	] as IItemStack[];

	var ic2CrushedPurified = [ <IC2:itemPurifiedCrushedOre>, #iron
		<IC2:itemPurifiedCrushedOre:2>, #gold
		<IC2:itemPurifiedCrushedOre:1>, #copper
		<IC2:itemPurifiedCrushedOre:3>, #tin
		<IC2:itemPurifiedCrushedOre:5>, #silver
		<IC2:itemPurifiedCrushedOre:6>, #lead
		<aobd:crushedPurifiedNickel>, #nickel
		<aobd:crushedPurifiedPlatinum>, #platinum
		<aobd:crushedPurifiedMithril>, #mithril
		<aobd:crushedPurifiedAluminium>, #aluminium
		<aobd:crushedPurifiedOsmium>, #osmium
		<aobd:crushedPurifiedZinc>,
		<aobd:crushedPurifiedCobalt>,
		<aobd:crushedPurifiedArdite>,
		<aobd:crushedPurifiedYellorium>,
		<aobd:crushedPurifiedManganese>,
		<aobd:crushedPurifiedEximite>,
		<aobd:crushedPurifiedMeutoite>,
		<aobd:crushedPurifiedPrometheum>,
		<aobd:crushedPurifiedDeepIron>,
		<aobd:crushedPurifiedInfuscolium>,
		<aobd:crushedPurifiedOureclase>,
		<aobd:crushedPurifiedAstralSilver>,
		<aobd:crushedPurifiedCarmot>,
		<aobd:crushedPurifiedRubracium>,
		<aobd:crushedPurifiedOrichalcum>,
		<aobd:crushedPurifiedAdamantine>,
		<aobd:crushedPurifiedAtlarus>,
		<aobd:crushedPurifiedIgnatius>,
		<aobd:crushedPurifiedShadowIron>,
		<aobd:crushedPurifiedLemurite>,
		<aobd:crushedPurifiedMidasium>,
		<aobd:crushedPurifiedVyroxeres>,
		<aobd:crushedPurifiedCeruclase>,
		<aobd:crushedPurifiedAlduorite>,
		<aobd:crushedPurifiedKalendrite>,
		<aobd:crushedPurifiedVulcanite>,
		<aobd:crushedPurifiedSanguinite>,
		<aobd:crushedPurifiedFzDarkIron>
	] as IItemStack[];

	var mkClumps = [ <Mekanism:Clump>, #iron
		<Mekanism:Clump:1>, #gold
		<Mekanism:Clump:3>, #copper
		<Mekanism:Clump:4>, #tin
		<Mekanism:Clump:5>, #silver
		<Mekanism:Clump:6>, #lead
		<aobd:clumpNickel>, #nickel
		<aobd:clumpPlatinum>, #platinum
		<aobd:clumpMithril>, #mithril
		<aobd:clumpAluminium>, #aluminium
		<Mekanism:Clump:2>, #osmium
		<aobd:clumpZinc>,
		<aobd:clumpCobalt>,
		<aobd:clumpArdite>,
		<aobd:clumpYellorium>,
		<aobd:clumpManganese>,
		<aobd:clumpEximite>,
		<aobd:clumpMeutoite>,
		<aobd:clumpPrometheum>,
		<aobd:clumpDeepIron>,
		<aobd:clumpInfuscolium>,
		<aobd:clumpOureclase>,
		<aobd:clumpAstralSilver>,
		<aobd:clumpCarmot>,
		<aobd:clumpRubracium>,
		<aobd:clumpOrichalcum>,
		<aobd:clumpAdamantine>,
		<aobd:clumpAtlarus>,
		<aobd:clumpIgnatius>,
		<aobd:clumpShadowIron>,
		<aobd:clumpLemurite>,
		<aobd:clumpMidasium>,
		<aobd:clumpVyroxeres>,
		<aobd:clumpCeruclase>,
		<aobd:clumpAlduorite>,
		<aobd:clumpKalendrite>,
		<aobd:clumpVulcanite>,
		<aobd:clumpSanguinite>,
		<aobd:clumpFzDarkIron>
	] as IItemStack[];

	var mkCrystals = [<Mekanism:Crystal>, #iron
		<Mekanism:Crystal:1>, #gold
		<Mekanism:Crystal:3>, #copper
		<Mekanism:Crystal:4>, #tin
		<Mekanism:Crystal:5>, #silver
		<Mekanism:Crystal:6>, #lead
		<aobd:crystalNickel>, #nickel
		<aobd:crystalPlatinum>, #platinum
		<aobd:crystalMithril>, #mithril
		<aobd:crystalAluminium>, #aluminium
		<Mekanism:Crystal:2>, #osmium
		<aobd:crystalZinc>,
		<aobd:crystalCobalt>,
		<aobd:crystalArdite>,
		<aobd:crystalYellorium>,
		<aobd:crystalManganese>,
		<aobd:crystalEximite>,
		<aobd:crystalMeutoite>,
		<aobd:crystalPrometheum>,
		<aobd:crystalDeepIron>,
		<aobd:crystalInfuscolium>,
		<aobd:crystalOureclase>,
		<aobd:crystalAstralSilver>,
		<aobd:crystalCarmot>,
		<aobd:crystalRubracium>,
		<aobd:crystalOrichalcum>,
		<aobd:crystalAdamantine>,
		<aobd:crystalAtlarus>,
		<aobd:crystalIgnatius>,
		<aobd:crystalShadowIron>,
		<aobd:crystalLemurite>,
		<aobd:crystalMidasium>,
		<aobd:crystalVyroxeres>,
		<aobd:crystalCeruclase>,
		<aobd:crystalAlduorite>,
		<aobd:crystalKalendrite>,
		<aobd:crystalVulcanite>,
		<aobd:crystalSanguinite>,
		<aobd:crystalFzDarkIron>
	] as IItemStack[];

	var mkShards = [ <Mekanism:Shard>, #iron
		<Mekanism:Shard:1>, #gold
		<Mekanism:Shard:3>, #copper
		<Mekanism:Shard:4>, #tin
		<Mekanism:Shard:5>, #silver
		<Mekanism:Shard:6>, #lead
		<aobd:shardNickel>, #nickel
		<aobd:shardPlatinum>, #platinum
		<aobd:shardMithril>, #mithril
		<aobd:shardAluminium>, #aluminium
		<Mekanism:Shard:2>, #osmium
		<aobd:shardZinc>,
		<aobd:shardCobalt>,
		<aobd:shardArdite>,
		<aobd:shardYellorium>,
		<aobd:shardManganese>,
		<aobd:shardEximite>,
		<aobd:shardMeutoite>,
		<aobd:shardPrometheum>,
		<aobd:shardDeepIron>,
		<aobd:shardInfuscolium>,
		<aobd:shardOureclase>,
		<aobd:shardAstralSilver>,
		<aobd:shardCarmot>,
		<aobd:shardRubracium>,
		<aobd:shardOrichalcum>,
		<aobd:shardAdamantine>,
		<aobd:shardAtlarus>,
		<aobd:shardIgnatius>,
		<aobd:shardShadowIron>,
		<aobd:shardLemurite>,
		<aobd:shardMidasium>,
		<aobd:shardVyroxeres>,
		<aobd:shardCeruclase>,
		<aobd:shardAlduorite>,
		<aobd:shardKalendrite>,
		<aobd:shardVulcanite>,
		<aobd:shardSanguinite>,
		<aobd:shardFzDarkIron>
	] as IItemStack[];

	var mkDirtyDusts = [ <Mekanism:DirtyDust>, #iron
		<Mekanism:DirtyDust:1>, #gold
		<Mekanism:DirtyDust:3>, #copper
		<Mekanism:DirtyDust:4>, #tin
		<Mekanism:DirtyDust:5>, #silver
		<Mekanism:DirtyDust:6>, #lead
		<aobd:dustDirtyNickel>, #nickel
		<aobd:dustDirtyPlatinum>, #platinum
		<aobd:dustDirtyMithril>, #mithril
		<aobd:dustDirtyAluminium>, #aluminium
		<Mekanism:DirtyDust:2>, #osmium
		<aobd:dustDirtyZinc>,
		<aobd:dustDirtyCobalt>,
		<aobd:dustDirtyArdite>,
		<aobd:dustDirtyYellorium>,
		<aobd:dustDirtyManganese>,
		<aobd:dustDirtyEximite>,
		<aobd:dustDirtyMeutoite>,
		<aobd:dustDirtyPrometheum>,
		<aobd:dustDirtyDeepIron>,
		<aobd:dustDirtyInfuscolium>,
		<aobd:dustDirtyOureclase>,
		<aobd:dustDirtyAstralSilver>,
		<aobd:dustDirtyCarmot>,
		<aobd:dustDirtyRubracium>,
		<aobd:dustDirtyOrichalcum>,
		<aobd:dustDirtyAdamantine>,
		<aobd:dustDirtyAtlarus>,
		<aobd:dustDirtyIgnatius>,
		<aobd:dustDirtyShadowIron>,
		<aobd:dustDirtyLemurite>,
		<aobd:dustDirtyMidasium>,
		<aobd:dustDirtyVyroxeres>,
		<aobd:dustDirtyCeruclase>,
		<aobd:dustDirtyAlduorite>,
		<aobd:dustDirtyKalendrite>,
		<aobd:dustDirtyVulcanite>,
		<aobd:dustDirtySanguinite>,
		<aobd:dustDirtyFzDarkIron>
	] as IItemStack[];

	var mkSlurries = [ <gas:iron>,
		<gas:gold>,
		<gas:copper>,
		<gas:tin>,
		<gas:silver>,
		<gas:lead>,
		<gas:Nickel>,
		<gas:Platinum>,
		<gas:Mithril>,
		<gas:Aluminium>,
		<gas:osmium>,
		<gas:Zinc>,
		<gas:Cobalt>,
		<gas:Ardite>,
		<gas:Yellorium>,
		<gas:Manganese>,
		<gas:Eximite>,
		<gas:Meutoite>,
		<gas:Prometheum>,
		<gas:DeepIron>,
		<gas:Infuscolium>,
		<gas:Oureclase>,
		<gas:AstralSilver>,
		<gas:Carmot>,
		<gas:Rubracium>,
		<gas:Orichalcum>,
		<gas:Adamantine>,
		<gas:Atlarus>,
		<gas:Ignatius>,
		<gas:ShadowIron>,
		<gas:Lemurite>,
		<gas:Midasium>,
		<gas:Vyroxeres>,
		<gas:Ceruclase>,
		<gas:Alduorite>,
		<gas:Kalendrite>,
		<gas:Vulcanite>,
		<gas:Sanguinite>,
		<gas:FzDarkIron>
	] as IGasStack[];

	var mkCleanSlurries = [ <gas:cleanIron>,
		<gas:cleanGold>,
		<gas:cleanCopper>,
		<gas:cleanTin>,
		<gas:cleanSilver>,
		<gas:cleanLead>,
		<gas:cleanNickel>,
		<gas:cleanPlatinum>,
		<gas:cleanMithril>,
		<gas:cleanAluminium>,
		<gas:cleanOsmium>,
		<gas:cleanZinc>,
		<gas:cleanCobalt>,
		<gas:cleanArdite>,
		<gas:cleanYellorium>,
		<gas:cleanManganese>,
		<gas:cleanEximite>,
		<gas:cleanMeutoite>,
		<gas:cleanPrometheum>,
		<gas:cleanDeepIron>,
		<gas:cleanInfuscolium>,
		<gas:cleanOureclase>,
		<gas:cleanAstralSilver>,
		<gas:cleanCarmot>,
		<gas:cleanRubracium>,
		<gas:cleanOrichalcum>,
		<gas:cleanAdamantine>,
		<gas:cleanAtlarus>,
		<gas:cleanIgnatius>,
		<gas:cleanShadowIron>,
		<gas:cleanLemurite>,
		<gas:cleanMidasium>,
		<gas:cleanVyroxeres>,
		<gas:cleanCeruclase>,
		<gas:cleanAlduorite>,
		<gas:cleanKalendrite>,
		<gas:cleanVulcanite>,
		<gas:cleanSanguinite>,
		<gas:cleanFzDarkIron>
	] as IGasStack[];

	#chance of getting Rich slag when induction smelting this ore with sand
	var tfISmelterRichChances = [ 5, #iron
		20, #gold
		5, #copper
		5, #tin
		5, #silver
		5, #lead
		15, #nickel
		30, #platinum
		15, #mithril
		5, #aluminium
		15, #osmium
		5, #zinc
		30, #cobalt
		20, #ardite
		5, #yellorite
		5, #manganese
		15, #eximite
		15, #meutoite
		5, #prometheum
		5, #deep Iron
		10, #infuscolium
		10, #oureclase
		10, #astralSilver
		10, #carmot
		15, #rubracium
		20, #orichalcum
		25, #adamantine
		30, #atlarus
		10, #ignatius
		10, #shadowIron
		10, #lemurite
		15, #midasium
		15, #vyroxeres
		20, #ceruclase
		20, #alduorite
		25, #kalendrite
		30, #vulcanite
		30, #sanguinite
		5 #dark iron
	] as int[];

	var tfISmelterSecondaries = [ <ThermalFoundation:material:100>, #iron -> nickel
		<ThermalExpansion:material:515>, #gold -> rich slag
		<minecraft:gold_nugget>, #copper -> gold
		<ThermalExpansion:material:8>, #tin -> iron
		<ThermalFoundation:material:99>, #silver -> lead
		<ThermalFoundation:material:98>, #lead -> silver
		<ThermalFoundation:material:101>, #nickel -> platinum
		<ThermalExpansion:material:515>, #platinum -> rich slag
		<ThermalExpansion:material:515>, #mithril -> rich slag
		<TConstruct:materials:22>, #aluminium -> aluminium
		<aobd:nuggetOsmium>, #osmium -> osmium
		<Steamcraft:steamcraftNugget:1>, #zinc
		<TConstruct:materials:29>, #cobalt -> ardite
		<TConstruct:materials:28>, #ardite -> cobalt
		<aobd:nuggetYellorium>, #yellorite
		<Metallurgy:base.nugget:2>, #manganese
		<Metallurgy:ender.nugget>, #eximite
		<Metallurgy:ender.nugget:1>, #meutoite
		<Metallurgy:fantasy.nugget>, #prometheum
		<Metallurgy:fantasy.nugget:1>, #deep Iron
		<Metallurgy:fantasy.nugget:2>, #infuscolium
		<Metallurgy:fantasy.nugget:4>, #oureclase
		<Metallurgy:fantasy.nugget:5>, #astralSilver
		<Metallurgy:fantasy.nugget:6>, #carmot
		<Metallurgy:fantasy.nugget:8>, #rubracium
		<Metallurgy:fantasy.nugget:11>, #orichalcum
		<Metallurgy:fantasy.nugget:13>, #adamantine
		<Metallurgy:fantasy.nugget:14>, #atlarus
		<Metallurgy:nether.nugget>, #ignatius
		<Metallurgy:nether.nugget:1>, #shadowIron
		<Metallurgy:nether.nugget:2>, #lemurite
		<Metallurgy:nether.nugget:3>, #midasium
		<Metallurgy:nether.nugget:4>, #vyroxeres
		<Metallurgy:nether.nugget:5>, #ceruclase
		<Metallurgy:nether.nugget:6>, #alduorite
		<Metallurgy:nether.nugget:7>, #kalendrite
		<Metallurgy:nether.nugget:8>, #vulcanite
		<Metallurgy:nether.nugget:9>, #sanguinite
		<ThermalFoundation:material:98> #dark iron -> silver
	] as IItemStack[];
	
	var tfISmelterSecChances = [ 100, #iron
		75, #gold
		100, #copper
		100, #tin
		100, #silver
		100, #lead
		100, #nickel
		75, #platinum
		75, #mithril
		100, #aluminium
		100, #osmium
		100, #zinc
		100, #cobalt
		100, #ardite
		100, #yellorite
		100, #manganese
		100, #eximite
		100, #meutoite
		100, #prometheum
		100, #deep Iron
		100, #infuscolium
		100, #oureclase
		100, #astralSilver
		100, #carmot
		100, #rubracium
		100, #orichalcum
		100, #adamantine
		100, #atlarus
		100, #ignatius
		100, #shadowIron
		100, #lemurite
		100, #midasium
		100, #vyroxeres
		100, #ceruclase
		100, #alduorite
		100, #kalendrite
		100, #vulcanite
		100, #sanguinite
		100 #dark iron
	] as int[];
	
	var ieCrusherSecondaries = [ <aobd:dustTinyNickel>, #iron -> ferrous
		<IC2:itemDustSmall:2>, #gold -> gold
		<minecraft:cobblestone>, #copper -> stone
		<IC2:itemDustSmall>, #tin -> iron
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4>, #lead -> silver
		<aobd:dustTinyPlatinum>, #nickel -> platinum
		<aobd:dustTinyPlatinum>, #platinum
		<IC2:itemDustSmall:4>, #mithril -> silver
		<aobd:dustTinyAluminium>, #aluminium
		<aobd:dustTinyOsmium>, #osmium
		<aobd:dustTinyZinc>,
		<aobd:dustTinyArdite>, #cobalt -> ardite
		<aobd:dustTinyCobalt>, #ardite -> cobalt
		<aobd:dustTinyYellorium>,
		<aobd:dustTinyManganese>,
		<aobd:dustTinyEximite>,
		<aobd:dustTinyMeutoite>,
		<aobd:dustTinyPrometheum>,
		<aobd:dustTinyDeepIron>,
		<aobd:dustTinyInfuscolium>,
		<aobd:dustTinyOureclase>,
		<aobd:dustTinyAstralSilver>,
		<aobd:dustTinyCarmot>,
		<aobd:dustTinyRubracium>,
		<aobd:dustTinyOrichalcum>,
		<aobd:dustTinyAdamantine>,
		<aobd:dustTinyAtlarus>,
		<aobd:dustTinyIgnatius>,
		<aobd:dustTinyShadowIron>,
		<aobd:dustTinyLemurite>,
		<aobd:dustTinyMidasium>,
		<aobd:dustTinyVyroxeres>,
		<aobd:dustTinyCeruclase>,
		<aobd:dustTinyAlduorite>,
		<aobd:dustTinyKalendrite>,
		<aobd:dustTinyVulcanite>,
		<aobd:dustTinySanguinite>,
		<IC2:itemDustSmall> #dark iron -> iron
	] as IItemStack[];
	
	var tfPulvSecondaries = [ <aobd:dustTinyNickel>, #iron -> nickel
		<ThermalFoundation:material:20>, #gold -> cinnabar
		<IC2:itemDustSmall:2>, #copper -> gold
		<IC2:itemDustSmall>, #tin -> iron
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4>, #lead -> silver
		<aobd:dustTinyPlatinum>, #nickel -> platinum
		<ThermalFoundation:material:20>, #platinum -> cinnabar
		<ThermalFoundation:material:20>, #mithril -> cinnabar
		<aobd:dustTinyAluminium>, #aluminium -> aluminium
		<aobd:dustTinyOsmium>, #osmium -> osmium
		<aobd:dustTinyZinc>,
		<aobd:dustTinyArdite>, #cobalt -> ardite
		<aobd:dustTinyCobalt>, #ardite -> cobalt
		<aobd:dustTinyYellorium>,
		<aobd:dustTinyManganese>,
		<aobd:dustTinyEximite>,
		<aobd:dustTinyMeutoite>,
		<aobd:dustTinyPrometheum>,
		<aobd:dustTinyDeepIron>,
		<aobd:dustTinyInfuscolium>,
		<aobd:dustTinyOureclase>,
		<aobd:dustTinyAstralSilver>,
		<aobd:dustTinyCarmot>,
		<aobd:dustTinyRubracium>,
		<aobd:dustTinyOrichalcum>,
		<aobd:dustTinyAdamantine>,
		<aobd:dustTinyAtlarus>,
		<aobd:dustTinyIgnatius>,
		<aobd:dustTinyShadowIron>,
		<aobd:dustTinyLemurite>,
		<aobd:dustTinyMidasium>,
		<aobd:dustTinyVyroxeres>,
		<aobd:dustTinyCeruclase>,
		<aobd:dustTinyAlduorite>,
		<aobd:dustTinyKalendrite>,
		<aobd:dustTinyVulcanite>,
		<aobd:dustTinySanguinite>,
		<IC2:itemDustSmall:4> #dark iron -> silver
	] as IItemStack[];
	
	var tfPulvSecondaryChances = [ 10, #iron
		5, #gold
		10, #copper
		10, #tin
		10, #silver
		10, #lead
		10, #nickel
		10, #platinum
		5, #mithril
		10, #aluminium
		10, #osmium
		10, #zinc
		10, #cobalt
		10, #ardite
		10, #yellorite
		10, #manganese
		10, #eximite
		10, #meutoite
		10, #prometheum
		10, #deep Iron
		10, #infuscolium
		10, #oureclase
		10, #astralSilver
		10, #carmot
		10, #rubracium
		10, #orichalcum
		10, #adamantine
		10, #atlarus
		10, #ignatius
		10, #shadowIron
		10, #lemurite
		10, #midasium
		10, #vyroxeres
		10, #ceruclase
		10, #alduorite
		10, #kalendrite
		10, #vulcanite
		10, #sanguinite
		10 #dark iron
	] as int[];
	
	var ic2ThermCentSecondaries = [ <aobd:dustTinyNickel>, #iron -> ferrous
		<IC2:itemDustSmall:4>, #gold -> silver
		<IC2:itemDustSmall:3>, #copper -> tin
		<IC2:itemDustSmall:1>, #tin -> copper
		<IC2:itemDustSmall:5>, #silver -> lead
		<IC2:itemDustSmall:4>, #lead -> silver
		<aobd:dustTinyPlatinum>, #ferrous -> shiny
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<IC2:itemDustSmall:3>, #aluminium -> tin
		<aobd:dustTinyOsmium>, #osmium
		<aobd:dustTinyZinc>,
		<aobd:dustTinyArdite>, #cobalt -> ardite
		<aobd:dustTinyCobalt>, #ardite -> cobalt
		<aobd:dustTinyYellorium>,
		<aobd:dustTinyManganese>,
		<aobd:dustTinyEximite>,
		<aobd:dustTinyMeutoite>,
		<aobd:dustTinyPrometheum>,
		<aobd:dustTinyDeepIron>,
		<aobd:dustTinyInfuscolium>,
		<aobd:dustTinyOureclase>,
		<aobd:dustTinyAstralSilver>,
		<aobd:dustTinyCarmot>,
		<aobd:dustTinyRubracium>,
		<aobd:dustTinyOrichalcum>,
		<aobd:dustTinyAdamantine>,
		<aobd:dustTinyAtlarus>,
		<aobd:dustTinyIgnatius>,
		<aobd:dustTinyShadowIron>,
		<aobd:dustTinyLemurite>,
		<aobd:dustTinyMidasium>,
		<aobd:dustTinyVyroxeres>,
		<aobd:dustTinyCeruclase>,
		<aobd:dustTinyAlduorite>,
		<aobd:dustTinyKalendrite>,
		<aobd:dustTinyVulcanite>,
		<aobd:dustTinySanguinite>,
		<aobd:dustTinyFzDarkIron> #dark iron
	] as IItemStack[];

	var tcClusters = [ <Thaumcraft:ItemNugget:16>, #Iron
		<Thaumcraft:ItemNugget:31>, #gold
		<Thaumcraft:ItemNugget:17>, #copper
		<Thaumcraft:ItemNugget:18>, #tin
		<Thaumcraft:ItemNugget:19>, #silver
		<Thaumcraft:ItemNugget:20>, #lead
		<WitchingGadgets:item.WG_Cluster:3>, #nickel
		<WitchingGadgets:item.WG_Cluster:7>, #platinum
		<WitchingGadgets:item.WG_Cluster:24>, #mithril
		<aobd:clusterAluminium>, #aluminium
		<aobd:clusterOsmium>, #osmium
		<WitchingGadgets:item.WG_Cluster:6>, #zinc
		<WitchingGadgets:item.WG_Cluster:1>, #cobalt
		<WitchingGadgets:item.WG_Cluster:2>, #ardite
		<aobd:clusterYellorium>, #yellorium
		<WitchingGadgets:item.WG_Cluster:5>, #manganese
		<WitchingGadgets:item.WG_Cluster:29>, #eximite
		<WitchingGadgets:item.WG_Cluster:30>, #meutoite
		<WitchingGadgets:item.WG_Cluster:18>, #prometheum
		<WitchingGadgets:item.WG_Cluster:19>, #deep Iron
		<WitchingGadgets:item.WG_Cluster:20>, #infuscolium
		<WitchingGadgets:item.WG_Cluster:21>, #oureclase
		<WitchingGadgets:item.WG_Cluster:22>, #astralSilver
		<WitchingGadgets:item.WG_Cluster:23>, #carmot
		<WitchingGadgets:item.WG_Cluster:25>, #rubracium
		<WitchingGadgets:item.WG_Cluster:26>, #orichalcum
		<WitchingGadgets:item.WG_Cluster:27>, #adamantine
		<WitchingGadgets:item.WG_Cluster:28>, #atlarus
		<WitchingGadgets:item.WG_Cluster:8>, #ignatius
		<WitchingGadgets:item.WG_Cluster:9>, #shadowIron
		<WitchingGadgets:item.WG_Cluster:10>, #lemurite
		<WitchingGadgets:item.WG_Cluster:11>, #midasium
		<WitchingGadgets:item.WG_Cluster:12>, #vyroxeres
		<WitchingGadgets:item.WG_Cluster:13>, #ceruclase
		<WitchingGadgets:item.WG_Cluster:14>, #alduorite
		<WitchingGadgets:item.WG_Cluster:15>, #kalendrite
		<WitchingGadgets:item.WG_Cluster:16>, #vulcanite
		<WitchingGadgets:item.WG_Cluster:17>, #sanguinite
		<aobd:clusterFzDarkIron> #dark iron
	] as IItemStack[];

	var fzCrystallines = [ <factorization:ore/crystal>, #Iron
		<factorization:ore/crystal:1>, #gold
		<factorization:ore/crystal:4>, #copper
		<factorization:ore/crystal:3>, #tin
		<factorization:ore/crystal:5>, #silver
		<factorization:ore/crystal:2>, #lead
		<aobd:crystallineNickel>, #nickel
		<aobd:crystallinePlatinum>, #platinum
		<aobd:crystallineMithril>, #mithril
		<aobd:crystallineAluminium>, #aluminium
		<aobd:crystallineOsmium>, #osmium
		<aobd:crystallineZinc>,
		<factorization:ore/crystal:8>, #cobalt
		<factorization:ore/crystal:9>, #ardite
		<aobd:crystallineYellorium>,
		<aobd:crystallineManganese>,
		<aobd:crystallineEximite>,
		<aobd:crystallineMeutoite>,
		<aobd:crystallinePrometheum>,
		<aobd:crystallineDeepIron>,
		<aobd:crystallineInfuscolium>,
		<aobd:crystallineOureclase>,
		<aobd:crystallineAstralSilver>,
		<aobd:crystallineCarmot>,
		<aobd:crystallineRubracium>,
		<aobd:crystallineOrichalcum>,
		<aobd:crystallineAdamantine>,
		<aobd:crystallineAtlarus>,
		<aobd:crystallineIgnatius>,
		<aobd:crystallineShadowIron>,
		<aobd:crystallineLemurite>,
		<aobd:crystallineMidasium>,
		<aobd:crystallineVyroxeres>,
		<aobd:crystallineCeruclase>,
		<aobd:crystallineAlduorite>,
		<aobd:crystallineKalendrite>,
		<aobd:crystallineVulcanite>,
		<aobd:crystallineSanguinite>,
		<factorization:ore/crystal:10> #dark iron
	] as IItemStack[];

	var fzCleanGravels = [ <factorization:ore/clean>, #Iron
		<factorization:ore/clean:1>, #gold
		<factorization:ore/clean:4>, #copper
		<factorization:ore/clean:3>, #tin
		<factorization:ore/clean:6>, #silver
		<factorization:ore/clean:2>, #lead
		<aobd:cleanGravelNickel>, #nickel
		<aobd:cleanGravelPlatinum>, #platinum
		<aobd:cleanGravelMithril>, #mithril
		<aobd:cleanGravelAluminium>, #aluminium
		<aobd:cleanGravelOsmium>, #osmium
		<aobd:cleanGravelZinc>,
		<factorization:ore/clean:8>, #cobalt
		<factorization:ore/clean:9>, #ardite
		<aobd:cleanGravelYellorium>,
		<aobd:cleanGravelManganese>,
		<aobd:cleanGravelEximite>,
		<aobd:cleanGravelMeutoite>,
		<aobd:cleanGravelPrometheum>,
		<aobd:cleanGravelDeepIron>,
		<aobd:cleanGravelInfuscolium>,
		<aobd:cleanGravelOureclase>,
		<aobd:cleanGravelAstralSilver>,
		<aobd:cleanGravelCarmot>,
		<aobd:cleanGravelRubracium>,
		<aobd:cleanGravelOrichalcum>,
		<aobd:cleanGravelAdamantine>,
		<aobd:cleanGravelAtlarus>,
		<aobd:cleanGravelIgnatius>,
		<aobd:cleanGravelShadowIron>,
		<aobd:cleanGravelLemurite>,
		<aobd:cleanGravelMidasium>,
		<aobd:cleanGravelVyroxeres>,
		<aobd:cleanGravelCeruclase>,
		<aobd:cleanGravelAlduorite>,
		<aobd:cleanGravelKalendrite>,
		<aobd:cleanGravelVulcanite>,
		<aobd:cleanGravelSanguinite>,
		<factorization:ore/clean:10> #dark iron
	] as IItemStack[];

	var fzReducedChunks = [ <factorization:ore/reduced>, #Iron
		<factorization:ore/reduced:1>, #gold
		<factorization:ore/reduced:4>, #copper
		<factorization:ore/reduced:3>, #tin
		<factorization:ore/reduced:5>, #silver
		<factorization:ore/reduced:2>, #lead
		<aobd:reducedNickel>, #nickel
		<aobd:reducedPlatinum>, #platinum
		<aobd:reducedMithril>, #mithril
		<aobd:reducedAluminium>, #aluminium
		<aobd:reducedOsmium>, #osmium
		<aobd:reducedZinc>,
		<factorization:ore/reduced:8>, #cobalt
		<factorization:ore/reduced:9>, #ardite
		<aobd:reducedYellorium>,
		<aobd:reducedManganese>,
		<aobd:reducedEximite>,
		<aobd:reducedMeutoite>,
		<aobd:reducedPrometheum>,
		<aobd:reducedDeepIron>,
		<aobd:reducedInfuscolium>,
		<aobd:reducedOureclase>,
		<aobd:reducedAstralSilver>,
		<aobd:reducedCarmot>,
		<aobd:reducedRubracium>,
		<aobd:reducedOrichalcum>,
		<aobd:reducedAdamantine>,
		<aobd:reducedAtlarus>,
		<aobd:reducedIgnatius>,
		<aobd:reducedShadowIron>,
		<aobd:reducedLemurite>,
		<aobd:reducedMidasium>,
		<aobd:reducedVyroxeres>,
		<aobd:reducedCeruclase>,
		<aobd:reducedAlduorite>,
		<aobd:reducedKalendrite>,
		<aobd:reducedVulcanite>,
		<aobd:reducedSanguinite>,
		<factorization:ore/reduced:10> #dark iron
	] as IItemStack[];

	var fzDirtyGravels = [ <factorization:ore/gravel>, #Iron
		<factorization:ore/gravel:1>, #gold
		<factorization:ore/gravel:4>, #copper
		<factorization:ore/gravel:3>, #tin
		<factorization:ore/gravel:6>, #silver
		<factorization:ore/gravel:2>, #lead
		<aobd:dirtyGravelNickel>, #nickel
		<aobd:dirtyGravelPlatinum>, #platinum
		<aobd:dirtyGravelMithril>, #mithril
		<aobd:dirtyGravelAluminium>, #aluminium
		<aobd:dirtyGravelOsmium>, #osmium
		<aobd:dirtyGravelZinc>,
		<factorization:ore/gravel:8>, #cobalt
		<factorization:ore/gravel:9>, #ardite
		<aobd:dirtyGravelYellorium>,
		<aobd:dirtyGravelManganese>,
		<aobd:dirtyGravelEximite>,
		<aobd:dirtyGravelMeutoite>,
		<aobd:dirtyGravelPrometheum>,
		<aobd:dirtyGravelDeepIron>,
		<aobd:dirtyGravelInfuscolium>,
		<aobd:dirtyGravelOureclase>,
		<aobd:dirtyGravelAstralSilver>,
		<aobd:dirtyGravelCarmot>,
		<aobd:dirtyGravelRubracium>,
		<aobd:dirtyGravelOrichalcum>,
		<aobd:dirtyGravelAdamantine>,
		<aobd:dirtyGravelAtlarus>,
		<aobd:dirtyGravelIgnatius>,
		<aobd:dirtyGravelShadowIron>,
		<aobd:dirtyGravelLemurite>,
		<aobd:dirtyGravelMidasium>,
		<aobd:dirtyGravelVyroxeres>,
		<aobd:dirtyGravelCeruclase>,
		<aobd:dirtyGravelAlduorite>,
		<aobd:dirtyGravelKalendrite>,
		<aobd:dirtyGravelVulcanite>,
		<aobd:dirtyGravelSanguinite>,
		<factorization:ore/gravel:10> #dark iron
	] as IItemStack[];

	var tmPurified1 = [ <technom:pureIron>,
		<technom:pureGold>,
		<technom:pureCopper>,
		<technom:pureTin>,
		<technom:pureSilver>,
		<technom:pureLead>,
		<technom:pureNickel>,
		<technom:purePlatinum>,
		<technom:pureMithril>,
		<technom:pureAluminum>,
		<technom:pureOsmium>,
		<technom:pureZinc>,
		<contenttweaker:cobalt_pure_1>,
		<contenttweaker:ardite_pure_1>,
		<technom:pureYellorium>,
		<technom:pureManganese>,
		<technom:pureEximite>,
		<technom:pureMeutoite>,
		<technom:purePrometheum>,
		<technom:pureDeepIron>,
		<technom:pureInfuscolium>,
		<technom:pureOureclase>,
		<technom:pureAstralSilver>,
		<technom:pureCarmot>,
		<technom:pureRubracium>,
		<technom:pureOrichalcum>,
		<technom:pureAdamantine>,
		<technom:pureAtlarus>,
		<technom:pureIgnatius>,
		<technom:pureShadowIron>,
		<technom:pureLemurite>,
		<technom:pureMidasium>,
		<technom:pureVyroxeres>,
		<technom:pureCeruclase>,
		<technom:pureAlduorite>,
		<technom:pureKalendrite>,
		<technom:pureVulcanite>,
		<technom:pureSanguinite>,
		<technom:pureFzDarkIron>
	] as IItemStack[];
	
	var tmPurified2 = [ <technom:pureIron:1>,
		<technom:pureGold:1>,
		<technom:pureCopper:1>,
		<technom:pureTin:1>,
		<technom:pureSilver:1>,
		<technom:pureLead:1>,
		<technom:pureNickel:1>,
		<technom:purePlatinum:1>,
		<technom:pureMithril:1>,
		<technom:pureAluminum:1>,
		<technom:pureOsmium:1>,
		<technom:pureZinc:1>,
		<contenttweaker:cobalt_pure_2>,
		<contenttweaker:ardite_pure_2>,
		<technom:pureYellorium:1>,
		<technom:pureManganese:1>,
		<technom:pureEximite:1>,
		<technom:pureMeutoite:1>,
		<technom:purePrometheum:1>,
		<technom:pureDeepIron:1>,
		<technom:pureInfuscolium:1>,
		<technom:pureOureclase:1>,
		<technom:pureAstralSilver:1>,
		<technom:pureCarmot:1>,
		<technom:pureRubracium:1>,
		<technom:pureOrichalcum:1>,
		<technom:pureAdamantine:1>,
		<technom:pureAtlarus:1>,
		<technom:pureIgnatius:1>,
		<technom:pureShadowIron:1>,
		<technom:pureLemurite:1>,
		<technom:pureMidasium:1>,
		<technom:pureVyroxeres:1>,
		<technom:pureCeruclase:1>,
		<technom:pureAlduorite:1>,
		<technom:pureKalendrite:1>,
		<technom:pureVulcanite:1>,
		<technom:pureSanguinite:1>,
		<technom:pureFzDarkIron:1>
	] as IItemStack[];
	
	var tmPurified3 = [ <technom:pureIron:2>,
		<technom:pureGold:2>,
		<technom:pureCopper:2>,
		<technom:pureTin:2>,
		<technom:pureSilver:2>,
		<technom:pureLead:2>,
		<technom:pureNickel:2>,
		<technom:purePlatinum:2>,
		<technom:pureMithril:2>,
		<technom:pureAluminum:2>,
		<technom:pureOsmium:2>,
		<technom:pureZinc:2>,
		<contenttweaker:cobalt_pure_3>,
		<contenttweaker:ardite_pure_3>,
		<technom:pureYellorium:2>,
		<technom:pureManganese:2>,
		<technom:pureEximite:2>,
		<technom:pureMeutoite:2>,
		<technom:purePrometheum:2>,
		<technom:pureDeepIron:2>,
		<technom:pureInfuscolium:2>,
		<technom:pureOureclase:2>,
		<technom:pureAstralSilver:2>,
		<technom:pureCarmot:2>,
		<technom:pureRubracium:2>,
		<technom:pureOrichalcum:2>,
		<technom:pureAdamantine:2>,
		<technom:pureAtlarus:2>,
		<technom:pureIgnatius:2>,
		<technom:pureShadowIron:2>,
		<technom:pureLemurite:2>,
		<technom:pureMidasium:2>,
		<technom:pureVyroxeres:2>,
		<technom:pureCeruclase:2>,
		<technom:pureAlduorite:2>,
		<technom:pureKalendrite:2>,
		<technom:pureVulcanite:2>,
		<technom:pureSanguinite:2>,
		<technom:pureFzDarkIron:2>
	] as IItemStack[];
	
	var tmPurified4 = [ <technom:pureIron:3>,
		<technom:pureGold:3>,
		<technom:pureCopper:3>,
		<technom:pureTin:3>,
		<technom:pureSilver:3>,
		<technom:pureLead:3>,
		<technom:pureNickel:3>,
		<technom:purePlatinum:3>,
		<technom:pureMithril:3>,
		<technom:pureAluminum:3>,
		<technom:pureOsmium:3>,
		<technom:pureZinc:3>,
		<contenttweaker:cobalt_pure_4>,
		<contenttweaker:ardite_pure_4>,
		<technom:pureYellorium:3>,
		<technom:pureManganese:3>,
		<technom:pureEximite:3>,
		<technom:pureMeutoite:3>,
		<technom:purePrometheum:3>,
		<technom:pureDeepIron:3>,
		<technom:pureInfuscolium:3>,
		<technom:pureOureclase:3>,
		<technom:pureAstralSilver:3>,
		<technom:pureCarmot:3>,
		<technom:pureRubracium:3>,
		<technom:pureOrichalcum:3>,
		<technom:pureAdamantine:3>,
		<technom:pureAtlarus:3>,
		<technom:pureIgnatius:3>,
		<technom:pureShadowIron:3>,
		<technom:pureLemurite:3>,
		<technom:pureMidasium:3>,
		<technom:pureVyroxeres:3>,
		<technom:pureCeruclase:3>,
		<technom:pureAlduorite:3>,
		<technom:pureKalendrite:3>,
		<technom:pureVulcanite:3>,
		<technom:pureSanguinite:3>,
		<technom:pureFzDarkIron:3>
	] as IItemStack[];
	
	var tmPurified5 = [ <technom:pureIron:4>,
		<technom:pureGold:4>,
		<technom:pureCopper:4>,
		<technom:pureTin:4>,
		<technom:pureSilver:4>,
		<technom:pureLead:4>,
		<technom:pureNickel:4>,
		<technom:purePlatinum:4>,
		<technom:pureMithril:4>,
		<technom:pureAluminum:4>,
		<technom:pureOsmium:4>,
		<technom:pureZinc:4>,
		<contenttweaker:cobalt_pure_5>,
		<contenttweaker:ardite_pure_5>,
		<technom:pureYellorium:4>,
		<technom:pureManganese:4>,
		<technom:pureEximite:4>,
		<technom:pureMeutoite:4>,
		<technom:purePrometheum:4>,
		<technom:pureDeepIron:4>,
		<technom:pureInfuscolium:4>,
		<technom:pureOureclase:4>,
		<technom:pureAstralSilver:4>,
		<technom:pureCarmot:4>,
		<technom:pureRubracium:4>,
		<technom:pureOrichalcum:4>,
		<technom:pureAdamantine:4>,
		<technom:pureAtlarus:4>,
		<technom:pureIgnatius:4>,
		<technom:pureShadowIron:4>,
		<technom:pureLemurite:4>,
		<technom:pureMidasium:4>,
		<technom:pureVyroxeres:4>,
		<technom:pureCeruclase:4>,
		<technom:pureAlduorite:4>,
		<technom:pureKalendrite:4>,
		<technom:pureVulcanite:4>,
		<technom:pureSanguinite:4>,
		<technom:pureFzDarkIron:4>
	] as IItemStack[];
	
	var tmPurified6 = [ <technom:pureIron:5>,
		<technom:pureGold:5>,
		<technom:pureCopper:5>,
		<technom:pureTin:5>,
		<technom:pureSilver:5>,
		<technom:pureLead:5>,
		<technom:pureNickel:5>,
		<technom:purePlatinum:5>,
		<technom:pureMithril:5>,
		<technom:pureAluminum:5>,
		<technom:pureOsmium:5>,
		<technom:pureZinc:5>,
		<contenttweaker:cobalt_pure_6>,
		<contenttweaker:ardite_pure_6>,
		<technom:pureYellorium:5>,
		<technom:pureManganese:5>,
		<technom:pureEximite:5>,
		<technom:pureMeutoite:5>,
		<technom:purePrometheum:5>,
		<technom:pureDeepIron:5>,
		<technom:pureInfuscolium:5>,
		<technom:pureOureclase:5>,
		<technom:pureAstralSilver:5>,
		<technom:pureCarmot:5>,
		<technom:pureRubracium:5>,
		<technom:pureOrichalcum:5>,
		<technom:pureAdamantine:5>,
		<technom:pureAtlarus:5>,
		<technom:pureIgnatius:5>,
		<technom:pureShadowIron:5>,
		<technom:pureLemurite:5>,
		<technom:pureMidasium:5>,
		<technom:pureVyroxeres:5>,
		<technom:pureCeruclase:5>,
		<technom:pureAlduorite:5>,
		<technom:pureKalendrite:5>,
		<technom:pureVulcanite:5>,
		<technom:pureSanguinite:5>,
		<technom:pureFzDarkIron:5>
	] as IItemStack[];
	
	var moltenMetals = [ <liquid:iron.molten>, #iron
		<liquid:gold.molten>, #gold
		<liquid:copper.molten>, #copper
		<liquid:tin.molten>, #tin
		<liquid:silver.molten>, #silver
		<liquid:lead.molten>, #lead
		<liquid:nickel.molten>, #nickel
		<liquid:platinum.molten>, #platinum
		<liquid:mithril.molten>, #mithril
		<liquid:aluminum.molten>, #aluminium
		<liquid:osmium.molten>, #osmium
		<liquid:zinc.molten>, #zinc
		<liquid:cobalt.molten>, #cobalt
		<liquid:ardite.molten>, #ardite
		<liquid:yellorium>, #yellorium
		<liquid:manganese.molten>, #manganese
		<liquid:eximite.molten>, #eximite
		<liquid:meutoite.molten>, #meutoite
		<liquid:prometheum.molten>, #prometheum
		<liquid:deep.iron.molten>, #deep iron
		<liquid:infuscolium.molten>, #infuscolium
		<liquid:oureclase.molten>, #oureclase
		<liquid:astral.silver.molten>, #astral silver
		<liquid:carmot.molten>, #carmot
		<liquid:rubracium.molten>, #rubracium
		<liquid:orichalcum.molten>, #orichalcum
		<liquid:adamantine.molten>, #adamantine
		<liquid:atlarus.molten>, #atlarus
		<liquid:ignatius.molten>, #ignatius
		<liquid:shadow.iron.molten>, #shadow iron
		<liquid:lemurite.molten>, #lemurite
		<liquid:midasium.molten>, #midasium
		<liquid:vyroxeres.molten>, #vyroxeres
		<liquid:ceruclase.molten>, #ceruclase
		<liquid:alduorite.molten>, #alduorite
		<liquid:kalendrite.molten>, #kalendrite
		<liquid:vulcanite.molten>, #vulcanite
		<liquid:sanguinite.molten>, #sanguinite
		<liquid:fzdarkiron> #fzdarkiron
	] as ILiquidStack[];
	
	var smeltingTemperatures = [ 600, #iron
		400, #gold
		550, #copper
		350, #tin
		550, #silver
		500, #lead
		500, #nickel
		550, #platinum
		550, #mithril
		350, #aluminium
		1200, #osmium
		550, #zinc
		650, #cobalt
		650, #ardite
		600, #yellorite
		700, #manganese
		550, #eximite
		550, #meutoite
		550, #prometheum
		550, #deep Iron
		550, #infuscolium
		600, #oureclase
		950, #astralSilver
		600, #carmot
		600, #rubracium
		600, #orichalcum
		1100, #adamantine
		800, #atlarus
		1000, #ignatius
		850, #shadowIron
		900, #lemurite
		450, #midasium
		900, #vyroxeres
		1000, #ceruclase
		1100, #alduorite
		1400, #kalendrite
		2200, #vulcanite
		1500, #sanguinite
		1800 #dark iron
	] as int[];
	
	var oreAspects = [ "metallum 3, terra 1", #iron
		"metallum 2, terra 1, lucrum 1", #gold
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 4, perditio 2, lucrum 2", #silver
		"metallum 5, perditio 2, ordo 1, tutamen 1", #lead
		"metallum 2, perditio 1, vacuos 1", #nickel
		"metallum 3, perditio 1, lucrum 1", #platinum
		"metallum 2, perditio 1, praecantatio 1", #mithril
		"metallum 2, terra 1", #aluminium
		"metallum 4, fabrico 1", #osmium
		"metallum 3, terra 2", #zinc
		"metallum 4, ignis 1, praecantatio 1", #cobalt
		"metallum 4, ignis 1, aqua 1", #ardite
		"metallum 2, venenum 2, potentia 2", #yellorium
		"metallum 2, permutatio 1", #manganese
		"metallum 3, alienis 1, praecantatio 1", #eximite
		"metallum 3, alienis 1", #meutoite
		"metallum 2, terra 1", #prometheum
		"metallum 2, aqua 1", #deep iron
		"metallum 3, praecantatio 1", #infuscolium
		"metallum 3, corpus 1", #oureclase
		"metallum 3, tenebrae 1, lucrum 1", #astral silver
		"metallum 3, lux 1, aer 1", #carmot
		"metallum 4, telum 2", #rubracium
		"metallum 4, permutatio 3", #orichalcum
		"metallum 4, victus 1, sano 1", #adamantine
		"metallum 4, lucrum 3", #atlarus
		"metallum 2, ignis 1", #ignatius
		"metallum 2, ignis 1, terra 1", #shadow iron
		"metallum 3, ignis 1, spiritus 1", #lemurite
		"metallum 3, ignis 2, lucrum 2", #midasium
		"metallum 3, ignis 2, herba 1", #vyroxeres
		"metallum 3, ignis 2, sensus 3", #ceruclase
		"metallum 4, ignis 2, gelum 2", #alduorite
		"metallum 3, ignis 3, auram 1", #kalendrite
		"metallum 4, ignis 10", #vulcanite
		"metallum 4, ignis 3, telum 3", #sanguinite
		"metallum 4, machina 1, terra 1" #dark iron
	] as string[];
	
#Additional lists:
	#used for additional removal of IE ore crusher recipes
	var ieDusts2 = [ <IC2:itemDust:7> #tin
	] as IItemStack[];
	
	#used for FZ slag furnace and Mekanism recipes as input and for setting Thaumcraft Aspects
	var allOres = [ 
		<minecraft:iron_ore>,
		<minecraft:gold_ore>,
		<IC2:blockOreCopper>,
		<IC2:blockOreTin>,
		<IC2:blockOreLead>,
		<ImmersiveEngineering:ore>, #copper
		<ImmersiveEngineering:ore:1>, #aluminium
		<ImmersiveEngineering:ore:2>, #lead
		<ImmersiveEngineering:ore:3>, #silver
		<ImmersiveEngineering:ore:4>, #nickel
		<Mekanism:OreBlock>, #osmium
		<Mekanism:OreBlock:1>, #copper
		<Mekanism:OreBlock:2>, #tin
		<ThermalFoundation:Ore>, #copper
		<ThermalFoundation:Ore:1>, #tin
		<ThermalFoundation:Ore:2>, #silver
		<ThermalFoundation:Ore:3>, #lead
		<ThermalFoundation:Ore:4>, #nickel
		<ThermalFoundation:Ore:5>, #platinum
		<ThermalFoundation:Ore:6>, #mithril
		<factorization:DarkIronOre>,
		<factorization:ResourceBlock>, #silver
		<Metallurgy:base.ore>, #copper
		<Metallurgy:base.ore:1>, #tin
		<Metallurgy:base.ore:2>, #manganese
		<Metallurgy:ender.ore>, #eximite
		<Metallurgy:ender.ore:1>, #meutoite
		<Metallurgy:fantasy.ore>, #prometheum
		<Metallurgy:fantasy.ore:1>, #deep Iron
		<Metallurgy:fantasy.ore:2>, #infuscolium
		<Metallurgy:fantasy.ore:4>, #oureclase
		<Metallurgy:fantasy.ore:5>, #astralSilver
		<Metallurgy:fantasy.ore:6>, #carmot
		<Metallurgy:fantasy.ore:7>, #mithril
		<Metallurgy:fantasy.ore:8>, #rubracium
		<Metallurgy:fantasy.ore:11>, #orichalcum
		<Metallurgy:fantasy.ore:13>, #adamantine
		<Metallurgy:fantasy.ore:14>, #atlarus
		<Metallurgy:nether.ore>, #ignatius
		<Metallurgy:nether.ore:1>, #shadowIron
		<Metallurgy:nether.ore:2>, #lemurite
		<Metallurgy:nether.ore:3>, #midasium
		<Metallurgy:nether.ore:4>, #vyroxeres
		<Metallurgy:nether.ore:5>, #ceruclase
		<Metallurgy:nether.ore:6>, #alduorite
		<Metallurgy:nether.ore:7>, #kalendrite
		<Metallurgy:nether.ore:8>, #vulcanite
		<Metallurgy:nether.ore:9>, #sanguinite
		<Metallurgy:precious.ore>, #zinc
		<Metallurgy:precious.ore:1>, #silver
		<Metallurgy:precious.ore:2>, #platinum
		<ProjRed|Exploration:projectred.exploration.ore:3>, #copper
		<ProjRed|Exploration:projectred.exploration.ore:4>, #tin
		<ProjRed|Exploration:projectred.exploration.ore:5>, #silver
		<Steamcraft:steamcraftOre>, #copper
		<Steamcraft:steamcraftOre:1>, #zinc
		<TConstruct:SearedBrick:1>, #cobalt
		<TConstruct:SearedBrick:2>, #ardite
		<TConstruct:SearedBrick:3>, #copper
		<TConstruct:SearedBrick:4>, #tin
		<TConstruct:SearedBrick:5>, #aluminium
		<TConstruct:GravelOre:0>, #iron
		<TConstruct:GravelOre:1>, #gold
		<TConstruct:GravelOre:2>, #copper
		<TConstruct:GravelOre:3>, #tin
		<TConstruct:GravelOre:4>, #aluminium
		<TConstruct:GravelOre:5>, #cobalt
		<BigReactors:YelloriteOre>
	] as IItemStack[];
	
	var allOreAspects = [ 
		"metallum 3, terra 1", #iron
		"metallum 2, terra 1, lucrum 1", #gold
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 5, perditio 2, ordo 1, tutamen 1", #lead
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 2, terra 1", #aluminium
		"metallum 5, perditio 2, ordo 1, tutamen 1", #lead
		"metallum 4, perditio 2, lucrum 2", #silver
		"metallum 2, perditio 1, vacuos 1", #nickel
		"metallum 4, fabrico 1", #osmium
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 4, perditio 2, lucrum 2", #silver
		"metallum 5, perditio 2, ordo 1, tutamen 1", #lead
		"metallum 2, perditio 1, vacuos 1", #nickel
		"metallum 3, perditio 1, lucrum 1", #platinum
		"metallum 2, perditio 1, praecantatio 1", #mithril
		"metallum 4, machina 1, terra 1", #dark iron
		"metallum 4, perditio 2, lucrum 2", #silver
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 2, permutatio 1", #manganese
		"metallum 3, alienis 1, praecantatio 1", #eximite
		"metallum 3, alienis 1", #meutoite
		"metallum 2, terra 1", #prometheum
		"metallum 2, aqua 1", #deep iron
		"metallum 3, praecantatio 1", #infuscolium
		"metallum 3, corpus 1", #oureclase
		"metallum 3, tenebrae 1, lucrum 1", #astral silver
		"metallum 3, lux 1, aer 1", #carmot
		"metallum 2, perditio 1, praecantatio 1", #mithril
		"metallum 4, telum 2", #rubracium
		"metallum 4, permutatio 3", #orichalcum
		"metallum 4, victus 1, sano 1", #adamantine
		"metallum 4, lucrum 3", #atlarus
		"metallum 2, ignis 1", #ignatius
		"metallum 2, ignis 1, terra 1", #shadow iron
		"metallum 3, ignis 1, spiritus 1", #lemurite
		"metallum 3, ignis 2, lucrum 2", #midasium
		"metallum 3, ignis 2, herba 1", #vyroxeres
		"metallum 3, ignis 2, sensus 3", #ceruclase
		"metallum 4, ignis 2, gelum 2", #alduorite
		"metallum 3, ignis 3, auram 1", #kalendrite
		"metallum 4, ignis 10", #vulcanite
		"metallum 4, ignis 3, telum 3", #sanguinite
		"metallum 3, terra 2", #zinc
		"metallum 4, perditio 2, lucrum 2", #silver
		"metallum 3, perditio 1, lucrum 1", #platinum
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 4, perditio 2, lucrum 2", #silver
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, terra 2", #zinc
		"metallum 4, ignis 1, praecantatio 1", #cobalt
		"metallum 4, ignis 1, aqua 1", #ardite
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 2, terra 1", #aluminium
		"metallum 3, terra 1", #iron
		"metallum 2, terra 1, lucrum 1", #gold
		"metallum 2, terra 1, permutatio 1", #copper
		"metallum 3, perditio 1, vitreus 1", #tin
		"metallum 2, terra 1", #aluminium
		"metallum 4, ignis 1, praecantatio 1", #cobalt
		"metallum 2, venenum 2, potentia 2" #yellorium
	] as string[];
	
	var allDenseOres = [ <denseores:block0>, #iron
		<denseores:block0:1>, #gold
		<denseores:block4:10>, #copper
		<denseores:block4:11>, #tin
		<denseores:block4:13>, #lead
		<denseores:block5:8>, #copper
		<denseores:block5:9>, #aluminium
		<denseores:block5:10>, #lead
		<denseores:block5:11>, #silver
		<denseores:block5:12>, #nickel
		<denseores:block5:13>, #osmium
		<denseores:block5:14>, #copper
		<denseores:block5:15>, #tin
		<denseores:block1:14>, #copper
		<denseores:block1:15>, #tin
		<denseores:block2>, #silver
		<denseores:block2:1>, #lead
		<denseores:block2:2>, #nickel
		<denseores:block2:3>, #platinum
		<denseores:block2:4>, #mithril
		<denseores:block0:10>, #dark iron
		<denseores:block0:9>, #silver
		<denseores:block6>, #copper
		<denseores:block6:1>, #tin
		<denseores:block6:2>, #manganese
		<denseores:block6:3>, #eximite
		<denseores:block6:4>, #meutoite
		<denseores:block6:5>, #prometheum
		<denseores:block6:6>, #deep iron
		<denseores:block6:7>, #infuscolium
		<denseores:block6:8>, #oureclase
		<denseores:block6:9>, #astral silver
		<denseores:block6:10>, #carmot
		<denseores:block6:11>, #mithril
		<denseores:block6:12>, #rubracium
		<denseores:block6:13>, #orichalcum
		<denseores:block6:14>, #adamantine
		<denseores:block6:15>, #atlarus
		<denseores:block7>, #ignatius
		<denseores:block7:1>, #shadow iron
		<denseores:block7:2>, #lemurite
		<denseores:block7:3>, #midasium
		<denseores:block7:4>, #vyroxeres
		<denseores:block7:5>, #ceruclase
		<denseores:block7:6>, #alduorite
		<denseores:block7:7>, #kalendrite
		<denseores:block7:8>, #vulcanite
		<denseores:block7:9>, #sanguinite
		<denseores:block7:10>, #zinc
		<denseores:block7:11>, #silver
		<denseores:block7:12>, #platinum
		<denseores:block8:6>, #copper
		<denseores:block8:7>, #tin
		<denseores:block8:8>, #silver
		<denseores:block8:10>, #copper
		<denseores:block8:11>, #zinc
		<denseores:block2:5>, #cobalt
		<denseores:block2:6>, #ardite
		<denseores:block2:7>, #copper
		<denseores:block2:8>, #tin
		<denseores:block2:9>, #aluminium
		<denseores:block5>, #iron
		<denseores:block5:1>, #gold
		<denseores:block5:2>, #copper
		<denseores:block5:3>, #tin
		<denseores:block5:4>, #aluminium
		<denseores:block5:5>, #cobalt
		<denseores:block0:8> #yellorium
	] as IItemStack[];
	
	#used for FZ slag furnace and Mekanism recipes as output
	var allNuggets = [ <ThermalFoundation:material:8>, #iron
		<minecraft:gold_nugget>, #gold
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:96>, #copper
		<ImmersiveEngineering:metal:23>, #aluminium
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:100>, #nickel
		<aobd:nuggetOsmium>, #osmium
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #nickel
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:102>, #mithril
		<aobd:nuggetFzDarkIron>, #dark iron
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<Metallurgy:base.nugget:2>, #manganese
		<Metallurgy:ender.nugget>, #eximite
		<Metallurgy:ender.nugget:1>, #meutoite
		<Metallurgy:fantasy.nugget>, #prometheum
		<Metallurgy:fantasy.nugget:1>, #deep Iron
		<Metallurgy:fantasy.nugget:2>, #infuscolium
		<Metallurgy:fantasy.nugget:4>, #oureclase
		<Metallurgy:fantasy.nugget:5>, #astralSilver
		<Metallurgy:fantasy.nugget:6>, #carmot
		<Metallurgy:fantasy.nugget:7>, #mithril
		<Metallurgy:fantasy.nugget:8>, #rubracium
		<Metallurgy:fantasy.nugget:11>, #orichalcum
		<Metallurgy:fantasy.nugget:13>, #adamantine
		<Metallurgy:fantasy.nugget:14>, #atlarus
		<Metallurgy:nether.nugget>, #ignatius
		<Metallurgy:nether.nugget:1>, #shadowIron
		<Metallurgy:nether.nugget:2>, #lemurite
		<Metallurgy:nether.nugget:3>, #midasium
		<Metallurgy:nether.nugget:4>, #vyroxeres
		<Metallurgy:nether.nugget:5>, #ceruclase
		<Metallurgy:nether.nugget:6>, #alduorite
		<Metallurgy:nether.nugget:7>, #kalendrite
		<Metallurgy:nether.nugget:8>, #vulcanite
		<Metallurgy:nether.nugget:9>, #sanguinite
		<Steamcraft:steamcraftNugget:1>, #zinc
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:96>, #copper
		<Steamcraft:steamcraftNugget:1>, #zinc
		<TConstruct:materials:28>, #cobalt
		<TConstruct:materials:29>, #ardite
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ImmersiveEngineering:metal:23>, #aluminium
		<ThermalFoundation:material:8>, #iron
		<minecraft:gold_nugget>, #gold
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ImmersiveEngineering:metal:23>, #aluminium
		<TConstruct:materials:28>, #cobalt
		<aobd:nuggetYellorium> #yellorite
	] as IItemStack[];
	
	#used for Mekanism recipes as output
	var allTinyDusts = [ <IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:1>, #copper
		<aobd:dustTinyAluminium>, #aluminium
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyNickel>, #nickel		
		<aobd:dustTinyOsmium>, #osmium
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>, #nickel
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<aobd:dustTinyFzDarkIron>, #dark iron
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyManganese>,
		<aobd:dustTinyEximite>,
		<aobd:dustTinyMeutoite>,
		<aobd:dustTinyPrometheum>,
		<aobd:dustTinyDeepIron>,
		<aobd:dustTinyInfuscolium>,
		<aobd:dustTinyOureclase>,
		<aobd:dustTinyAstralSilver>,
		<aobd:dustTinyCarmot>,
		<aobd:dustTinyMithril>,
		<aobd:dustTinyRubracium>,
		<aobd:dustTinyOrichalcum>,
		<aobd:dustTinyAdamantine>,
		<aobd:dustTinyAtlarus>,
		<aobd:dustTinyIgnatius>,
		<aobd:dustTinyShadowIron>,
		<aobd:dustTinyLemurite>,
		<aobd:dustTinyMidasium>,
		<aobd:dustTinyVyroxeres>,
		<aobd:dustTinyCeruclase>,
		<aobd:dustTinyAlduorite>,
		<aobd:dustTinyKalendrite>,
		<aobd:dustTinyVulcanite>,
		<aobd:dustTinySanguinite>,
		<aobd:dustTinyZinc>, #zinc
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyPlatinum>, #platinum
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:1>, #copper
		<aobd:dustTinyZinc>, #zinc
		<aobd:dustTinyCobalt>, #cobalt
		<aobd:dustTinyArdite>, #ardite
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyAluminium>, #aluminium
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyAluminium>, #aluminium
		<aobd:dustTinyCobalt>, #cobalt
		<aobd:dustTinyYellorium> #yellorium
	] as IItemStack[];
	
	#used for Mekanism Crusher Nugget recipes as input
	var allMKCNuggets = [ <minecraft:gold_nugget>, #gold
		<ImmersiveEngineering:metal:21>, #iron
		<ImmersiveEngineering:metal:22>, #copper
		<ImmersiveEngineering:metal:23>, #aluminium
		<ImmersiveEngineering:metal:24>, #lead
		<ImmersiveEngineering:metal:25>, #silver
		<ImmersiveEngineering:metal:26>, #nickel
		<Metallurgy:base.nugget>, #copper
		<Metallurgy:base.nugget:1>, #tin
		<Metallurgy:base.nugget:2>, #manganese
		<Metallurgy:ender.nugget>, #eximite
		<Metallurgy:ender.nugget:1>, #meutoite
		<Metallurgy:fantasy.nugget>, #prometheum
		<Metallurgy:fantasy.nugget:1>, #deep iron
		<Metallurgy:fantasy.nugget:2>, #infuscolium
		<Metallurgy:fantasy.nugget:4>, #oureclase
		<Metallurgy:fantasy.nugget:5>, #astral silver
		<Metallurgy:fantasy.nugget:6>, #carmot
		<Metallurgy:fantasy.nugget:7>, #mithril
		<Metallurgy:fantasy.nugget:8>, #rubracium
		<Metallurgy:fantasy.nugget:11>, #orichalcum
		<Metallurgy:fantasy.nugget:13>, #adamantine
		<Metallurgy:fantasy.nugget:14>, #atlarus
		<Metallurgy:nether.nugget>, #ignatius
		<Metallurgy:nether.nugget:1>, #shadow iron
		<Metallurgy:nether.nugget:2>, #lemurite
		<Metallurgy:nether.nugget:3>, #midasium
		<Metallurgy:nether.nugget:4>, #vyroxeres
		<Metallurgy:nether.nugget:5>, #ceruclase
		<Metallurgy:nether.nugget:6>, #alduorite
		<Metallurgy:nether.nugget:7>, #kalendrite
		<Metallurgy:nether.nugget:8>, #vulcanite
		<Metallurgy:nether.nugget:9>, #sanguinite
		<Metallurgy:precious.nugget>, #zinc
		<Metallurgy:precious.nugget:1>, #silver
		<Metallurgy:precious.nugget:2>, #platinum
		<Railcraft:nugget>, #iron
		<Railcraft:nugget:2>, #copper
		<Railcraft:nugget:3>, #tin
		<Railcraft:nugget:4>, #lead
		<Steamcraft:steamcraftNugget>, #copper
		<Steamcraft:steamcraftNugget:1>, #zinc
		<Steamcraft:steamcraftNugget:2>, #iron
		<TConstruct:materials:19>, #iron
		<TConstruct:materials:20>, #copper
		<TConstruct:materials:21>, #tin
		<TConstruct:materials:22>, #aluminum
		<TConstruct:materials:27>, #obsidian
		<TConstruct:materials:28>, #cobalt
		<TConstruct:materials:29>, #ardite
		<TConstruct:materials:31>, #bronze
		<Thaumcraft:ItemResource:18>, #gold
		<Thaumcraft:ItemNugget>, #iron
		<Thaumcraft:ItemNugget:1>, #copper
		<Thaumcraft:ItemNugget:2>, #tin
		<Thaumcraft:ItemNugget:3>, #silver
		<Thaumcraft:ItemNugget:4>, #lead
		<ThermalFoundation:material:8>, #iron
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<ThermalFoundation:material:100>, #ferrous
		<ThermalFoundation:material:101>, #shiny
		<ThermalFoundation:material:102>, #mana infused
		<aobd:nuggetYellorium>, #yellorium
		<aobd:nuggetFzDarkIron>, #dark iron
		<aobd:nuggetOsmium> #osmium
	] as IItemStack[];
	
	#used for Mekanism Crusher Nugget recipes as output
	var allMKCTinyDusts = [ <IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<aobd:dustTinyAluminium>, #aluminium
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyNickel>, #nickel
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyManganese>, #manganese
		<aobd:dustTinyEximite>, #eximite
		<aobd:dustTinyMeutoite>, #meutoite
		<aobd:dustTinyPrometheum>, #prometheum
		<aobd:dustTinyDeepIron>, #deep iron
		<aobd:dustTinyInfuscolium>, #infuscolium
		<aobd:dustTinyOureclase>, #oureclase
		<aobd:dustTinyAstralSilver>, #astral silver
		<aobd:dustTinyCarmot>, #carmot
		<aobd:dustTinyMithril>, #mithril
		<aobd:dustTinyRubracium>, #rubracium
		<aobd:dustTinyOrichalcum>, #orichalcum
		<aobd:dustTinyAdamantine>, #adamantine
		<aobd:dustTinyAtlarus>, #atlarus
		<aobd:dustTinyIgnatius>, #ignatius
		<aobd:dustTinyShadowIron>, #shadow iron
		<aobd:dustTinyLemurite>, #lemurite
		<aobd:dustTinyMidasium>, #midasium
		<aobd:dustTinyVyroxeres>, #vyroxeres
		<aobd:dustTinyCeruclase>, #ceruclase
		<aobd:dustTinyAlduorite>, #alduorite
		<aobd:dustTinyKalendrite>, #kalendrite
		<aobd:dustTinyVulcanite>, #vulcanite
		<aobd:dustTinySanguinite>, #sanguinite
		<aobd:dustTinyZinc>, #zinc
		<IC2:itemDustSmall:4>, #silver
		<aobd:dustTinyPlatinum>, #platinum
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall:1>, #copper
		<aobd:dustTinyZinc>, #zinc
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<aobd:dustTinyAluminium>, #aluminium
		<IC2:itemDustSmall:10>, #obsidian
		<aobd:dustTinyCobalt>, #cobalt
		<aobd:dustTinyArdite>, #ardite
		<IC2:itemDustSmall:8>, #bronze
		<IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyNickel>, #nickel
		<aobd:dustTinyPlatinum>, #platinum
		<aobd:dustTinyMithril>, #mithril
		<aobd:dustTinyYellorium>, #yellorium
		<aobd:dustTinyFzDarkIron>, #dark iron
		<aobd:dustTinyOsmium> #osmium
	] as IItemStack[];
	
	#used for Nether ore recipes
	var netherOres = [ <NetherOres:tile.netherores.ore.0:2>, #gold
		<NetherOres:tile.netherores.ore.0:3>, #iron
		<NetherOres:tile.netherores.ore.0:6>, #copper
		<NetherOres:tile.netherores.ore.0:7>, #tin
		<NetherOres:tile.netherores.ore.0:9>, #silver
		<NetherOres:tile.netherores.ore.0:10>, #lead
		<NetherOres:tile.netherores.ore.0:11>, #uranium
		<NetherOres:tile.netherores.ore.1>, #platinum
		<NetherOres:tile.netherores.ore.1:1>, #nickel
		<NetherOres:tile.netherores.ore.1:4>, #osmium
		<NetherOres:tile.netherores.ore.1:7> #mithril
	] as IItemStack[];
	
	var denseNetherOres = [ <denseores:block2:12>, #gold
		<denseores:block2:13>, #iron
		<denseores:block3>, #copper
		<denseores:block3:1>, #tin
		<denseores:block3:3>, #silver
		<denseores:block3:4>, #lead
		<denseores:block3:5>, #uranium
		<denseores:block3:10>, #platinum
		<denseores:block3:11>, #nickel
		<denseores:block3:14>, #osmium
		<denseores:block4:1> #mithril
	] as IItemStack[];
	
	#no = NetherOres
	var noNuggets = [ <minecraft:gold_nugget>,
		<ThermalFoundation:material:8>, #iron
		<ThermalFoundation:material:96>, #copper
		<ThermalFoundation:material:97>, #tin
		<ThermalFoundation:material:98>, #silver
		<ThermalFoundation:material:99>, #lead
		<aobd:nuggetYellorium>,
		<ThermalFoundation:material:101>, #platinum
		<ThermalFoundation:material:100>, #nickel
		<aobd:nuggetOsmium>,
		<ThermalFoundation:material:102> #mithril
	] as IItemStack[];
	
	var noTinyDusts = [ <IC2:itemDustSmall:2>, #gold
		<IC2:itemDustSmall>, #iron
		<IC2:itemDustSmall:1>, #copper
		<IC2:itemDustSmall:3>, #tin
		<IC2:itemDustSmall:4>, #silver
		<IC2:itemDustSmall:5>, #lead
		<aobd:dustTinyYellorium>,
		<aobd:dustTinyPlatinum>,
		<aobd:dustTinyNickel>,
		<aobd:dustTinyOsmium>,
		<aobd:dustTinyMithril>
	] as IItemStack[];
	
	
#Global functions
	
#Recipe removal
	#ore smelting and pulverizing
		for i, ore in oredictOres {
			furnace.remove(<*>, ore); #Furnace
			recipes.removeShapeless(wgIngots[i],
				[<ThermalFoundation:material:512>,
				ore ]); #Pyrotheum
			#IC2 macerator can only be overwritten, not removed, done in recipe creation step.
			Enrichment.removeRecipe(ore); #MK Enrichment chamber			
			Purification.removeRecipe(mkClumps[i], ore, <gas:oxygen>); #MK purification chamber
			Injection.removeRecipe(mkShards[i], ore, <gas:hydrogenchloride>); #MK injection chamber
			#MK dissolution chamber can only be overwritten, not removed, done in recipe creation step.
			#IE hammer crushing recipes disabled in IE config
			IECrusher.removeRecipe(ieDusts[i]); #IE crusher
			RSFurnace.removeRecipe(ore); #TE Redstone furnace
			Pulverizer.removeRecipe(ore); #TE Pulverizer
			ISmelter.removeRecipe(<minecraft:sand>, ore); #TE Induction smelter Sand
			ISmelter.removeRecipe(<ThermalFoundation:material:20>, ore); #TE Induction smelter Cinnabar
			ISmelter.removeRecipe(<ThermalFoundation:material:512>, ore); #TE Induction smelter Pyrotheum
			ISmelter.removeRecipe(<ThermalExpansion:material:515>, ore); #TE Induction smelter Rich Slag
			ArcFurnace.removeRecipe(ieIngots[i]); #IE Arc Furnace
			
			Smeltery.removeMelting(ore); #TiC Smeltery
			
			QED.removeRecipe(oredictIngots[i]);
			
			#ore crafting
			Combiner.removeRecipe(ore);
		}
		for dust in ieDusts2 {
			IECrusher.removeRecipe(dust); #IE crusher
		}
		for ore in allOres {
			SlagFurnace.removeRecipe(ore); #Fz Slag Furnace
		}
		#IC2 Blast Furnace recipes are done in the configs
		#uranium
			SlagFurnace.removeRecipe(<IC2:blockOreUran>); #Fz Slag Furnace
			Enrichment.removeRecipe(<ore:oreUranium>); #MK Enrichment chamber			
			Purification.removeRecipe(<aobd:clumpUranium>, <ore:oreUranium>, <gas:oxygen>); #MK purification chamber
			Injection.removeRecipe(<aobd:shardUranium>, <ore:oreUranium>, <gas:hydrogenchloride>); #MK injection chamber
			#MK dissolution chamber can only be overwritten, not removed, done in recipe creation step.
			Pulverizer.removeRecipe(<ore:oreUranium>); #TE Pulverizer
			ISmelter.removeRecipe(<minecraft:sand>, <ore:oreUranium>); #TE Induction smelter Sand
			ISmelter.removeRecipe(<ThermalFoundation:material:20>, <ore:oreUranium>); #TE Induction smelter Cinnabar
			ISmelter.removeRecipe(<ThermalFoundation:material:512>, <ore:oreUranium>); #TE Induction smelter Pyrotheum
			ISmelter.removeRecipe(<ThermalExpansion:material:515>, <ore:oreUranium>); #TE Induction smelter Rich Slag
			Smeltery.removeMelting(<ore:oreUranium>); #TiC Smeltery
		#aluminium
			recipes.removeShapeless(<ImmersiveEngineering:metal:1>,
				[<ThermalFoundation:material:512>,
				<ore:oreAluminum> ]); #Pyrotheum
			
	#blocks
		#uranium
			Smeltery.removeMelting(<IC2:blockMetal:3>); #TiC Smeltery
			Casting.removeBasinRecipe(<IC2:blockMetal:3>);

	#nuggets
		for i, nugget in oredictNuggets {
			Smeltery.removeMelting(nugget); #TiC Smeltery
			Casting.removeTableRecipe(nugget);
		}
		#uranium
			Smeltery.removeMelting(<aobd:nuggetUranium>); #TiC Smeltery
		
	#dense ores
		for i, ore in oredictDenseOres {
			furnace.remove(<*>, ore); #Furnace
			#IC2 macerator can only be overwritten, not removed, done in recipe creation step.
			RSFurnace.removeRecipe(ore); #TE Redstone furnace
			Pulverizer.removeRecipe(ore); #TE Pulverizer
			ISmelter.removeRecipe(<minecraft:sand>, ore); #TE Induction smelter Sand
			ISmelter.removeRecipe(<ThermalFoundation:material:20>, ore); #TE Induction smelter Cinnabar
			ISmelter.removeRecipe(<ThermalFoundation:material:512>, ore); #TE Induction smelter Pyrotheum
			
			Smeltery.removeMelting(ore); #TiC Smeltery
		}
		#uranium
			furnace.remove(<*>, <ore:denseoreUranium>); #Furnace
			#IC2 macerator can only be overwritten, not removed, done in recipe creation step.
			RSFurnace.removeRecipe(<ore:denseoreUranium>); #TE Redstone furnace
			Pulverizer.removeRecipe(<ore:denseoreUranium>); #TE Pulverizer
			ISmelter.removeRecipe(<minecraft:sand>, <ore:denseoreUranium>); #TE Induction smelter Sand
			ISmelter.removeRecipe(<ThermalFoundation:material:20>, <ore:denseoreUranium>); #TE Induction smelter Cinnabar
			ISmelter.removeRecipe(<ThermalFoundation:material:512>, <ore:denseoreUranium>); #TE Induction smelter Pyrotheum		
			Smeltery.removeMelting(<ore:denseoreUranium>); #TiC Smeltery
	
	#nether ores
		for i, ore in netherOres {
			#IC2 macerator can only be overwritten, not removed, done in recipe creation step.
			Pulverizer.removeRecipe(ore); #TE Pulverizer
			Smeltery.removeMelting(ore); #TiC Smeltery
		}
		#uranium
			#IC2 macerator can only be overwritten, not removed, done in recipe creation step.
			Pulverizer.removeRecipe(<ore:oreNetherUranium>); #TE Pulverizer
			Smeltery.removeMelting(<ore:oreNetherUranium>); #TiC Smeltery
	
	
	#tc clusters
		for i, cluster in tcClusters {
			furnace.remove(<*>, cluster);
			RSFurnace.removeRecipe(cluster); #TE Redstone furnace
			Pulverizer.removeRecipe(cluster); #TE Pulverizer
			
			Smeltery.removeMelting(cluster); #TiC Smeltery
			InfernalBlastfurnace.removeRecipe(wgIngots[i]); #also removes uranium, because it smelts to yellorium
		}
		#uranium
			furnace.remove(<*>, <aobd:clusterUranium>);
			RSFurnace.removeRecipe(<aobd:clusterUranium>); #TE Redstone furnace
			Pulverizer.removeRecipe(<aobd:clusterUranium>); #TE Pulverizer
			Smeltery.removeMelting(<aobd:clusterUranium>); #TiC Smeltery
		#aluminium
			InfernalBlastfurnace.removeRecipe(<ImmersiveEngineering:metal:1>);
	
	#fz dirty gravel
		for gravel in fzDirtyGravels {
			furnace.remove(<*>, gravel);
			SlagFurnace.removeRecipe(gravel); #Fz Slag Furnace
			RSFurnace.removeRecipe(gravel); #TE Redstone furnace
		}
		#uranium
			furnace.remove(<*>, <aobd:dirtyGravelUranium>);
			SlagFurnace.removeRecipe(<aobd:dirtyGravelUranium>); #Fz Slag Furnace
			RSFurnace.removeRecipe(<aobd:dirtyGravelUranium>); #TE Redstone furnace
	
	#fz clean gravel
		for gravel in fzCleanGravels {
			furnace.remove(<*>, gravel);
			RSFurnace.removeRecipe(gravel); #TE Redstone furnace
			SlagFurnace.removeRecipe(gravel); #Fz Slag Furnace (silver only?¿?)
		}
		#uranium
			furnace.remove(<*>, <aobd:cleanGravelUranium>);
			RSFurnace.removeRecipe(<aobd:cleanGravelUranium>); #TE Redstone furnace
			SlagFurnace.removeRecipe(<aobd:cleanGravelUranium>); #Fz Slag Furnace
	
	#fz reduced chunks
		for chunk in fzReducedChunks {
			furnace.remove(<*>, chunk);
			RSFurnace.removeRecipe(chunk); #TE Redstone furnace
		}
		#uranium
			furnace.remove(<*>, <aobd:reducedUranium>);
			RSFurnace.removeRecipe(<aobd:reducedUranium>); #TE Redstone furnace
	
	#fz crystals
		for crystal in fzCrystallines {
			FZCrystallizer.removeRecipe(crystal);		
			furnace.remove(<*>, crystal);
			RSFurnace.removeRecipe(crystal); #TE Redstone furnace
		}
		#uranium
			furnace.remove(<*>, <aobd:crystallineUranium>);
			RSFurnace.removeRecipe(<aobd:crystallineUranium>); #TE Redstone furnace
		
	#ic2 crushed
		for crushed in ic2Crushed {
			furnace.remove(<*>, crushed);
			RSFurnace.removeRecipe(crushed); #TE Redstone furnace
			
			Smeltery.removeMelting(crushed); #TiC Smeltery
		}
		#uranium
			furnace.remove(<*>, <IC2:itemCrushedOre:4>);
			RSFurnace.removeRecipe(<IC2:itemCrushedOre:4>); #TE Redstone furnace
			Smeltery.removeMelting(<IC2:itemCrushedOre:4>); #TiC Smeltery
	
	#ic2 purified
		for crushed in ic2CrushedPurified {
			furnace.remove(<*>, crushed);
			RSFurnace.removeRecipe(crushed); #TE Redstone furnace
		}

	#tm purified 1
		for purified in tmPurified1 {
				furnace.remove(<*>, purified);
				RSFurnace.removeRecipe(purified); #TE Redstone furnace
		}
		
	#tm purified 2
		for purified in tmPurified2 {
			
				furnace.remove(<*>, purified);
				RSFurnace.removeRecipe(purified); #TE Redstone furnace

		}
		
	#tm purified 3
		for purified in tmPurified3 {
			
				furnace.remove(<*>, purified);
				RSFurnace.removeRecipe(purified); #TE Redstone furnace

		}
		
	#tm purified 4
		for purified in tmPurified4 {
			
				furnace.remove(<*>, purified);
				RSFurnace.removeRecipe(purified); #TE Redstone furnace

		}
		
	#tm purified 5
		for purified in tmPurified5 {
			
				furnace.remove(<*>, purified);
				RSFurnace.removeRecipe(purified); #TE Redstone furnace

		}
		
	#tm purified 6
		for purified in tmPurified6 {
			
				furnace.remove(<*>, purified);
				RSFurnace.removeRecipe(purified); #TE Redstone furnace

		}
	
	#machines
		recipes.remove(<ActuallyAdditions:blockGrinder>);
		recipes.remove(<appliedenergistics2:tile.BlockGrinder>);
		recipes.remove(<Metallurgy:crusher>);
		recipes.remove(<Steamcraft:smasher>);
		
#Setting Thaumcraft aspects
	#ores and nuggets
		for i, input in allOres {
			Aspects.set(input, allOreAspects[i]);
		}
		for input in allMKCNuggets {
			Aspects.set(input, "metallum 1"); #Todo apparently this causes the cyclic assignment while loading the script? At Aluminium, that is
			#WitchingGadgets' Transmutation turned off
		}
	
#Recipe creation
	#Creation functions
		#Crusher
			function addAllCrusherRecipes(
					oredictInputs as IIngredient[],
					tfInputs as IItemStack[],
					allInputs as IItemStack[],
					outputs as IItemStack[],
					allOutputs as IItemStack[],
					yield as int,
					ieSecondaryOutputs as IItemStack[],
					ieSecondaryOutputChances as int[],
					tfSecondaryOutputs as IItemStack[],
					tfSecondaryOutputChances as int[]) {

				for i, input in oredictInputs {
					recipes.addShapeless(outputs[i] * yield * 1.5, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
					Macerator.addRecipe(outputs[i] * 2 * yield, input); #IC2 macerator
					IECrusher.addRecipe(outputs[i] * 2 * yield, input, 1000*yield, ieSecondaryOutputs[i], 0.01 * ieSecondaryOutputChances[i] * yield); #IE Crusher (2x output)
					Pulverizer.addRecipe(1000*yield, tfInputs[i], outputs[i] * 2 * yield, tfSecondaryOutputs[i], tfSecondaryOutputChances[i]); #TE Pulverizer (2x+ output)
					Lacerator.addRecipe(input, outputs[i], 2.5 * yield); #FZ Lacerator (2.5x output)
				}
				for i, input in allInputs {
					MKCrusher.addRecipe(input, allOutputs[i] * 2 * yield); #MK Crusher (2x output)
				}
			}
		
		#Furnace
			function addAllFurnaceRecipes( #including Purification and injection
					oredictInputs as IIngredient[],
					tfInputs as IItemStack[],
					allInputs as IItemStack[],
					outputs as IItemStack[],
					allOutputs as IItemStack[],
					yield as int,
					wgSecondaryOutputs as IItemStack[],
					tfRichChances as int[],
					tfSecondaryOutputs as IItemStack[],
					tfSecondaryOutputChances as int[]) {

				for i, input in oredictInputs {
					furnace.addRecipe(outputs[i] * yield, input, 0.1*yield); #Furnace (1x output)
					recipes.addShapeless(outputs[i] * yield * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
					RSFurnace.addRecipe(400*yield, tfInputs[i], outputs[i] * yield * 2); #TE Redstone furnace (2x output)
					ISmelter.addRecipe(800*yield, <minecraft:sand>, tfInputs[i], outputs[i] * yield * 2, <ThermalExpansion:material:515> , tfRichChances[i] * yield ); #TE Induction smelter Sand (2x output)
					ISmelter.addRecipe(1000*yield, <ThermalFoundation:material:512>, tfInputs[i], outputs[i] * yield * 2, <ThermalExpansion:material:515> , tfRichChances[i] * yield * 3 ); #TE Induction smelter Pyrotheum (2x output)
					InfernalBlastfurnace.addRecipe(outputs[i] * yield * 2.5, input, 50*yield, wgSecondaryOutputs[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
					ArcFurnace.addRecipe(outputs[i] * yield * 2.5, input, <ImmersiveEngineering:material:13>, 100 * yield, 20); #IE Arc Furnace (2 - 2,5x output)
					ISmelter.addRecipe(2000*yield, <ThermalExpansion:material:515>, tfInputs[i], outputs[i] * yield * 3, <ThermalExpansion:material:514> , 75 * yield ); #TE Induction smelter Rich Slag (3x output)
					ISmelter.addRecipe(4000*yield, <ThermalFoundation:material:20>, tfInputs[i], outputs[i] * yield * 3, tfSecondaryOutputs[i], tfSecondaryOutputChances[i] * yield); #TE Induction smelter Cinnabar (3x+ output)
				}
				for i, input in allInputs {
					SlagFurnace.addRecipe(input, allOutputs[i], 1.5 * yield, <minecraft:stone>, 0.4 * yield); #FZ Slag Furnace (1,5x output)
					QED.addShapedRecipe(input * yield * 3, [ [allOutputs[i]] ]); #EU 
					Purification.addRecipe(input, <gas:oxygen>, allOutputs[i] * 3 * yield); #MK purification chamber (3x output)
					Injection.addRecipe(input, <gas:hydrogenchloride>, allOutputs[i] * 4 * yield); #MK injection chamber (4x output)
				}
			}
		
	#ores (1)
		addAllFurnaceRecipes(
				oredictOres,
				tfOres,
				allOres,
				tfNuggets,
				allNuggets,
				1,
				ic2TinyDusts,
				tfISmelterRichChances,
				tfISmelterSecondaries,
				tfISmelterSecChances);
				
		for i, input in oredictOres {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, tfOres[i], 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(tfOres[i], mkSlurries[i] * 100); #MK dissolution chamber
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfOres[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, tfOres[i], moltenMetals[i] * 36);
			
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 2, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, tfOres[i], ic2TinyDusts[i] * 2, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2x+ output)
			
			#ore crafting
			Combiner.addRecipe(tfBlocks[i] * 3, tfOres[i]);
			recipes.addShapeless(tfOres[i], 
				[oredictBlocks[i], oredictBlocks[i], oredictBlocks[i], 
				oredictIngots[i], oredictIngots[i], oredictIngots[i], 
				oredictIngots[i], oredictIngots[i], oredictIngots[i]]);
		}
		#IC2 Blast Furnace recipes are done in the configs
		for i, input in allOres {			
			MKCrusher.addRecipe(input, allTinyDusts[i] * 2); #MK Crusher (2x output)
			
			Enrichment.addRecipe(input, allTinyDusts[i] * 2); #MK enrichment chamber (2x output)
		}
		
		#uranium
			SlagFurnace.addRecipe(<IC2:blockOreUran>, <aobd:nuggetYellorium>, 1.5, <minecraft:stone>, 0.4); #FZ Slag Furnace (1,5x output)
			MKCrusher.addRecipe(<IC2:blockOreUran>, <IC2:itemCrushedOre:4>); #MK Crusher (2x output)
			Enrichment.addRecipe(<IC2:blockOreUran>, <aobd:dustTinyYellorium> * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(<IC2:blockOreUran>, <gas:oxygen>, <aobd:nuggetYellorium> * 3); #MK purification chamber (3x output)
			Injection.addRecipe(<IC2:blockOreUran>, <gas:hydrogenchloride>, <aobd:nuggetYellorium> * 4); #MK injection chamber (4x output)
			ManaInfusion.addAlchemy(<IC2:itemCrushedOre:4> * 2, <IC2:blockOreUran>, 1000); #Botania alchemy
			Macerator.addRecipe(<IC2:itemCrushedOre:4>, <ore:oreUranium>); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(<IC2:blockOreUran>, <gas:Uranium> * 100); #MK dissolution chamber
			furnace.addRecipe(<aobd:nuggetYellorium>, <ore:oreUranium>, 0.5); #Furnace (1x output)
			recipes.addShapeless(<aobd:nuggetYellorium> * 2, [<ThermalFoundation:material:512>, <ore:oreUranium> ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, <IC2:blockOreUran>, <aobd:nuggetYellorium> * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, <IC2:blockOreUran>, <aobd:nuggetYellorium> * 2, <ThermalExpansion:material:515> , 5 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, <IC2:blockOreUran>, <aobd:nuggetYellorium> * 2, <ThermalExpansion:material:515> , 15 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(<aobd:nuggetYellorium> * 2, <ore:oreUranium>, 50, <aobd:dustTinyYellorium>, true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(<aobd:nuggetYellorium> * 2, <ore:oreUranium>, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, <IC2:blockOreUran>, <aobd:nuggetYellorium> * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, <IC2:blockOreUran>, <aobd:nuggetYellorium> * 3, <aobd:nuggetYellorium>, 45); #TE Induction smelter Cinnabar (3x+ output)
			Smeltery.addMelting(<ore:oreUranium>, <liquid:yellorium> * 36, 600, <IC2:blockOreUran>); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, <IC2:blockOreUran>, <liquid:yellorium> * 36);
			recipes.addShapeless(<IC2:itemCrushedOre:4>, [<ImmersiveEngineering:tool>, <ore:oreUranium>]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(<aobd:dustTinyYellorium> * 2, <ore:oreUranium>, 2500, <aobd:dustTinyYellorium>, 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, <IC2:blockOreUran>, <aobd:dustTinyYellorium> * 2, <aobd:dustTinyYellorium>, 10); #TE Pulverizer (2x+ output)

	#dense ores (4)
		for i, input in oredictDenseOres {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 8, tfDenseOres[i], 1000); #Botania alchemy
			#Macerator recipe already exists
			Dissolution.addRecipe(tfDenseOres[i], mkSlurries[i] * 400); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i] * 4, input, 0.5); #Furnace (1x output)
			recipes.addShapeless(tfNuggets[i] * 8, [<ThermalFoundation:material:512>, <ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(1600, tfDenseOres[i], tfNuggets[i] * 8); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(3200, <minecraft:sand>, tfDenseOres[i], tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(4000, <ThermalFoundation:material:512>, tfDenseOres[i], tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 9); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 8, input, 100, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 8, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, tfDenseOres[i], tfNuggets[i] * 12, <ThermalExpansion:material:514> , 100); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, tfDenseOres[i], tfNuggets[i] * 12, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 3); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 144, smeltingTemperatures[i], tfDenseOres[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(40000, tfDenseOres[i], moltenMetals[i] * 144);
			
			recipes.addShapeless(ic2TinyDusts[i] * 5, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 8, input, 5000, ieCrusherSecondaries[i], 0.3); #IE Crusher (2x output)
			
			Pulverizer.addRecipe(2000, tfDenseOres[i], ic2TinyDusts[i] * 8, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 3); #TE Pulverizer (2x+ output)
			
			#ore crafting
				Combiner.addRecipe(tfOres[i] * 32, tfDenseOres[i]); #For agricraft base blocks
		}
		#IC2 Blast Furnace recipes are done in the configs
		for i, input in allDenseOres {
			SlagFurnace.addRecipe(input, allNuggets[i], 6, <minecraft:stone>, 1.2); #FZ Slag Furnace (1,5x output)
			
			MKCrusher.addRecipe(input, allTinyDusts[i] * 8); #MK Crusher (2x output)
			
			Enrichment.addRecipe(input, allTinyDusts[i] * 8); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, allNuggets[i] * 12); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, allNuggets[i] * 16); #MK injection chamber (4x output)
		}
		
	#nether ores (2)
		for i, input in netherOres {
			SlagFurnace.addRecipe(input, noNuggets[i], 3, <minecraft:netherrack>, 0.4); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(noNuggets[i] * 4, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(noNuggets[i] * 4, input, 50, noTinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(noNuggets[i] * 4, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			
			recipes.addShapeless(noTinyDusts[i] * 3, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, noTinyDusts[i] * 4); #MK Crusher (2x output)
			Macerator.addRecipe(noTinyDusts[i] * 4, input); #IC2 macerator can only be overwritten, not removed.
			
			Enrichment.addRecipe(input, noTinyDusts[i] * 4); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, noNuggets[i] * 6); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, noNuggets[i] * 8); #MK injection chamber (4x output)
		}
		#IC2 Blast Furnace recipes are done in the configs
		
	#dense nether ores (8)
		for i, input in denseNetherOres {
			#Macerator recipe already exists
			MKCrusher.addRecipe(input, netherOres[i] * 4); #MK Crusher
			
			SlagFurnace.addRecipe(input, noNuggets[i], 12, <minecraft:netherrack>, 0.4); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(noNuggets[i] * 16, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(noNuggets[i] * 18, input, 50, noTinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(noNuggets[i] * 20, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			
			recipes.addShapeless(noTinyDusts[i] * 12, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			
			Enrichment.addRecipe(input, noTinyDusts[i] * 16); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, noNuggets[i] * 24); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, noNuggets[i] * 32); #MK injection chamber (4x output)
		}
		#IC2 Blast Furnace recipes are done in the configs

		
	#dusts as input (9)
		for i, input in oredictDusts {
			recipes.addShapeless(ic2TinyDusts[i] * 9, [input]);	

			recipes.addShapeless(ic2Ingots[i], [<ThermalFoundation:material:512>, input ]); #Pyrotheum
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, ic2Dusts[i], ic2Ingots[i], <ThermalExpansion:material:514> , 100 ); #TE Induction smelter Pyrotheum
			
			Crucible.addRecipe(80000, ic2Dusts[i], moltenMetals[i] * 144); #TE Magma Crucible
		}
		
	#tiny dusts as input (1)
		for i, input in ic2TinyDusts {
			recipes.addShapeless(ic2Dusts[i], 
				[input, input, input, 
				input, input, input, 
				input, input, input]);
			
			furnace.addRecipe(tfNuggets[i], input); #Furnace
			recipes.addShapeless(tfNuggets[i], [<ThermalFoundation:material:512>, input ]); #Pyrotheum
			RSFurnace.addRecipe(800, ic2TinyDusts[i], tfNuggets[i]); #TE Redstone furnace
			ISmelter.addRecipe(1600, <minecraft:sand>, ic2TinyDusts[i], tfNuggets[i], <ThermalExpansion:material:514> , 25 ); #TE Induction smelter Sand
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, ic2TinyDusts[i], tfNuggets[i], <ThermalExpansion:material:514> , 100 ); #TE Induction smelter Pyrotheum
			InfernalBlastfurnace.addRecipe(tfNuggets[i], input, 50, null, false); #WG Infernal Blast Furnace
			ArcFurnace.addRecipe(tfNuggets[i], input, <ThermalExpansion:material:514>, 100, 512); #IE Arc Furnace
			
			Smeltery.addMelting(input, moltenMetals[i] * 16, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery
			Crucible.addRecipe(10000, input, moltenMetals[i] * 16); #TE Magma Crucible
		}
		
	#blocks as input (27)
		for i, input in oredictBlocks {
			Lacerator.addRecipe(input, ic2Dusts[i], 9.0); #FZ Lacerator
			
			recipes.addShapeless(ic2Ingots[i] * 9, [ input ]); #Block -> 9 Ingots
			Crucible.addRecipe(600000, tfBlocks[i], moltenMetals[i] * 1296); #TE Magma Crucible
		}
		
		#uranium
			Smeltery.addMelting(<IC2:blockMetal:3>, <liquid:uranium> * 144, 600, <IC2:blockMetal:3>); #TiC Smeltery
			Casting.addBasinRecipe(<BigReactors:BRMetalBlock>, <liquid:uranium> * 1296, null, false, 20);
		
	#ingots as input (9)
		for i, input in oredictIngots {
			Macerator.addRecipe(ic2Dusts[i], input); #IC2 macerator
			Lacerator.addRecipe(input, ic2Dusts[i], 1.0); #FZ Lacerator
			
			Crucible.addRecipe(80000, ic2Ingots[i], moltenMetals[i] * 144); #TE Magma Crucible
		}
		
	#nuggets as input (1)
		for i, input in oredictNuggets {
			recipes.addShaped(ic2Ingots[i], 
				[[input, input, input],
				[input, input, input], 
				[input, input, input]]);
			
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer
			IECrusher.addRecipe(ic2TinyDusts[i], input, 2500); #IE Crusher
			Pulverizer.addRecipe(1000, tfNuggets[i], ic2TinyDusts[i]); #TE Pulverizer
			Lacerator.addRecipe(input, ic2TinyDusts[i], 1.0); #FZ Lacerator
			
			Smeltery.addMelting(input, moltenMetals[i] * 16, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery
			Crucible.addRecipe(10000, tfNuggets[i], moltenMetals[i] * 16); #TE Magma Crucible
			Casting.addTableRecipe(tfNuggets[i], moltenMetals[i] * 16, <TConstruct:metalPattern:27>, false, 5); #TiC Casting | Technically, the nugget is the output here, but oh well...
		}
		for i, input in allMKCNuggets {
			MKCrusher.addRecipe(input, allMKCTinyDusts[i]); #MK Crusher
		}
	
	#oreBerries as input (1)
		for i, input in oredictOreBerries {
			Smeltery.addMelting(input, moltenMetals[i] * 16, smeltingTemperatures[i], tfOres[i]); #TiC Smeltery
		}

	#tc clusters (2)
		for i, input in tcClusters {
			Lacerator.addRecipe(input, fzDirtyGravels[i], 2.5); #FZ Lacerator
			
			ManaInfusion.addAlchemy(ic2Crushed[i] * 5, input, 1500); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i] * 2, input); #IC2 macerator
			Dissolution.addRecipe(input, mkSlurries[i] * 300); #MK dissolution chamber
			Purification.addRecipe(input, <gas:oxygen>, mkCrystals[i]); #MK purification chamber
			Injection.addRecipe(input, <gas:hydrogenchloride>, mkShards[i]); #MK injection chamber
			
			furnace.addRecipe(tfNuggets[i] * 2, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 3.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 4, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 4); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] *4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 2 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 4, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 5, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 6, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 6, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 2); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 72, smeltingTemperatures[i], tfOres[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(40000, input, moltenMetals[i] * 72); #TE Magma Crucible
			
			recipes.addShapeless(ic2TinyDusts[i] * 3, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 4); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 4, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 4, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2x+ output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 4); #MK enrichment chamber (2x output)
		}
		#uranium
			Lacerator.addRecipe(<aobd:clusterUranium>, <aobd:dirtyGravelUranium>, 2.5); #FZ Lacerator
			InfernalBlastfurnace.addRecipe(<aobd:nuggetUranium> * 4, <aobd:clusterUranium>, 50, <aobd:dustTinyUranium>, true); #WG Infernal Blast Furnace (2 - 2,5x output)
		
	#fz dirty gravel (1)
		for i, input in fzDirtyGravels {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			OreWasher.addRecipe([ic2CrushedPurified[i], ic2TinyDusts[i], <IC2:itemDust:9>], input, 1000); #IC2 Orewasher
			
			ThermalCentrifuge.addRecipe([ tmPurified1[i], ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], input, 2000); #IC2 Thermal Centrifuge

			Dissolution.addRecipe(input, mkSlurries[i] * 150); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 2, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, input, moltenMetals[i] * 36); #TE Magma Crucible
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}

	#fz clean gravel (1)
		for i, input in fzCleanGravels {
			SlagFurnace.addRecipe(input, fzReducedChunks[i], 0.75, fzReducedChunks[i], 0.75);
			
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(input, mkSlurries[i] * 175); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 2, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, input, moltenMetals[i] * 36); #TE Magma Crucible
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
		#uranium
			SlagFurnace.addRecipe(<aobd:cleanGravelUranium>, <aobd:reducedUranium>, 0.75, <aobd:reducedUranium>, 0.75);
		
		
	#fz reduced chunks (1)
		for i, input in fzReducedChunks {
			FZCrystallizer.addRecipe(input, fzCrystallines[i], <factorization:acid:1>, 1.2);
			
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 1000); #Botania alchemy
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(input, mkSlurries[i] * 150); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 2, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, input, moltenMetals[i] * 36); #TE Magma Crucible
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
		#uranium
			FZCrystallizer.addRecipe(<aobd:reducedUranium>, <aobd:crystallineUranium>, <factorization:acid:1>, 1.2);
	
	#fz crystals (1)
		for i, input in fzCrystallines {
			ManaInfusion.addAlchemy(ic2Crushed[i] * 2, input, 750); #Botania alchemy
			
			Macerator.addRecipe(ic2Crushed[i], input); #IC2 macerator can only be overwritten, not removed.
			Dissolution.addRecipe(input, mkSlurries[i] * 175); #MK dissolution chamber
			Purification.addRecipe(input, <gas:oxygen>, mkCrystals[i]); #MK purification chamber
			Injection.addRecipe(input, <gas:hydrogenchloride>, mkShards[i]); #MK injection chamber
		
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 2, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, input, moltenMetals[i] * 36); #TE Magma Crucible
			
			recipes.addShapeless(ic2TinyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 2); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 2, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 2, tfPulvSecondaries[i], tfPulvSecondaryChances[i]); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 3.0); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
		}
		#uranium
			ManaInfusion.addAlchemy(<IC2:itemCrushedOre:4> * 2, <aobd:crystallineUranium>, 750); #Botania alchemy
			Dissolution.addRecipe(<aobd:crystallineUranium>, <gas:Uranium> * 175); #MK dissolution chamber

	#ic2 crushed (1)
		for i, input in ic2Crushed {
				ThermalCentrifuge.addRecipe([ tmPurified1[i], ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], input, 2000); #thermal centrifuge in configs?
			Dissolution.addRecipe(input, mkSlurries[i] * 150); #MK dissolution chamber
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 2, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, input, moltenMetals[i] * 36); #TE Magma Crucible
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
	
	#ic2 purified (1)
		for i, input in ic2CrushedPurified {
				ThermalCentrifuge.addRecipe([ tmPurified1[i].withTag({Thaumcraft: 1}), ic2ThermCentSecondaries[i], <IC2:itemDust:9> ], input, 1000); #thermal centrifuge in configs -> into technomancy
			
			furnace.addRecipe(tfNuggets[i], input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 1.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 2, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 2); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 2, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 2, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 2, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i]); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 36, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(20000, input, moltenMetals[i] * 36); #TE Magma Crucible
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 2); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 3); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 4); #MK injection chamber (4x output)
		}
		#uranium
			Dissolution.addRecipe(<IC2:itemPurifiedCrushedOre:4>, <gas:Yellorium> * 200); #MK dissolution chamber
	
	#tm purified 1 (2)
		function mekanismRecipes1(i as int, input as IItemStack, mkSlurries as IGasStack[], ic2TinyDusts as IItemStack[], tfNuggets as IItemStack[])
		{
			var tags = [ {Thaumcraft: 1},
				{Botania: 1},
				{"Blood Magic": 1}
			] as IData[];
		
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 300); #Mekanism dissolution chamber
				
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 4); #MK Crusher (2x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 4); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 6); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 8); #MK injection chamber (4x output)
			}
		}

		for i, input in tmPurified1 {
				mekanismRecipes1(i, input, mkSlurries, ic2TinyDusts, tfNuggets);
				
				furnace.addRecipe(tfNuggets[i] * 2, input, 0.5); #Furnace (1x output)
				SlagFurnace.addRecipe(input, tfNuggets[i], 3.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
				recipes.addShapeless(tfNuggets[i] * 4, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
				RSFurnace.addRecipe(800, input, tfNuggets[i] * 4); #TE Redstone furnace (2x output)
				ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 2 ); #TE Induction smelter Sand (2x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 4, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Pyrotheum (2x output)
				InfernalBlastfurnace.addRecipe(tfNuggets[i] * 4, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
				ArcFurnace.addRecipe(tfNuggets[i] * 5, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
				ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 6, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 6, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 2); #TE Induction smelter Cinnabar (3x+ output)
			
				Smeltery.addMelting(input, moltenMetals[i] * 72, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
				Crucible.addRecipe(40000, input, moltenMetals[i] * 72); #TE Magma Crucible
				
				recipes.addShapeless(ic2TinyDusts[i] * 3, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
				IECrusher.addRecipe(ic2TinyDusts[i] * 4, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
				Macerator.addRecipe(ic2TinyDusts[i] * 4, input); #IC2 macerator (2x output)
				Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 4, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 2); #TE Pulverizer (2x+ output)
				Lacerator.addRecipe(input, ic2TinyDusts[i], 5.0); #FZ Lacerator (2.5x output)
		}
		
	#tm purified 2 (3)
		function mekanismRecipes2(i as int, input as IItemStack, mkSlurries as IGasStack[], mkCrystals as IItemStack[], mkShards as IItemStack[], ic2TinyDusts as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2},
				{Botania: 2},
				{"Blood Magic": 2},
				{Thaumcraft: 1, Botania: 1},
				{Botania: 1, "Blood Magic": 1},
				{Thaumcraft: 1, "Blood Magic": 1}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 400); #MK dissolution chamber
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, mkCrystals[i]); #MK purification chamber
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, mkShards[i]); #MK injection chamber
				
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 6); #MK Crusher (2x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 6); #MK enrichment chamber (2x output)
			}
		}
	
		for i, input in tmPurified2 {
				mekanismRecipes2(i, input, mkSlurries, mkCrystals, mkShards, ic2TinyDusts);
				
				furnace.addRecipe(tfNuggets[i] * 3, input, 0.5); #Furnace (1x output)
				SlagFurnace.addRecipe(input, tfNuggets[i], 4.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
				recipes.addShapeless(tfNuggets[i] * 6, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
				RSFurnace.addRecipe(800, input, tfNuggets[i] * 6); #TE Redstone furnace (2x output)
				ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Sand (2x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 9 ); #TE Induction smelter Pyrotheum (2x output)
				InfernalBlastfurnace.addRecipe(tfNuggets[i] * 6, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
				ArcFurnace.addRecipe(tfNuggets[i] * 7, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
				ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, ic2Ingots[i], <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, ic2Ingots[i], tfISmelterSecondaries[i], tfISmelterSecChances[i] * 3); #TE Induction smelter Cinnabar (3x+ output)
			
				Smeltery.addMelting(input, moltenMetals[i] * 108, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
				Crucible.addRecipe(60000, input, moltenMetals[i] * 108); #TE Magma Crucible
				
				recipes.addShapeless(ic2TinyDusts[i] * 4, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
				IECrusher.addRecipe(ic2TinyDusts[i] * 6, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
				Macerator.addRecipe(ic2TinyDusts[i] * 6, input); #IC2 macerator (2x output)
				Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 6, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 3); #TE Pulverizer (2x+ output)
				Lacerator.addRecipe(input, ic2TinyDusts[i], 9.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 3 (4)
		function mekanismRecipes3(i as int, input as IItemStack, mkSlurries as IGasStack[], ic2TinyDusts as IItemStack[], tfNuggets as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2, Botania: 1},
				{Thaumcraft: 2, "Blood Magic": 1},
				{Botania: 2, "Blood Magic": 1},
				{Thaumcraft: 1, Botania: 2},
				{Thaumcraft: 1, Botania: 1, "Blood Magic": 1},
				{Thaumcraft: 1, "Blood Magic": 2},
				{Botania: 1, "Blood Magic": 2}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 500); #MK dissolution chamber
			
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 8); #MK Crusher (2x output)
			
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 8); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 12); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 16); #MK injection chamber (4x output)
			}
		}
		
		for i, input in tmPurified3 {
				mekanismRecipes3(i, input, mkSlurries, ic2TinyDusts, tfNuggets);
			
				furnace.addRecipe(tfNuggets[i] * 4, input, 0.5); #Furnace (1x output)
				SlagFurnace.addRecipe(input, tfNuggets[i], 6.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
				recipes.addShapeless(tfNuggets[i] * 8, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
				RSFurnace.addRecipe(800, input, tfNuggets[i] * 8); #TE Redstone furnace (2x output)
				ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 4 ); #TE Induction smelter Sand (2x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 12 ); #TE Induction smelter Pyrotheum (2x output)
				InfernalBlastfurnace.addRecipe(tfNuggets[i] * 9, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
				ArcFurnace.addRecipe(tfNuggets[i] * 10, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
				ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 12, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 12, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 4); #TE Induction smelter Cinnabar (3x+ output)
			
				Smeltery.addMelting(input, moltenMetals[i] * 144, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
				Crucible.addRecipe(80000, input, moltenMetals[i] * 144); #TE Magma Crucible
				
				recipes.addShapeless(ic2TinyDusts[i] * 6, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
				IECrusher.addRecipe(ic2TinyDusts[i] * 8, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
				Macerator.addRecipe(ic2TinyDusts[i] * 8, input); #IC2 macerator (2x output)
				Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 8, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 4); #TE Pulverizer (2x+ output)
				Lacerator.addRecipe(input, ic2TinyDusts[i], 12.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 4 (5)
		function mekanismRecipes4(i as int, input as IItemStack, mkSlurries as IGasStack[], mkCrystals as IItemStack[], mkShards as IItemStack[], ic2TinyDusts as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2, Botania: 2},
				{Thaumcraft: 2, Botania: 1, "Blood Magic": 1},
				{Thaumcraft: 2, "Blood Magic": 2},
				{Botania: 2, "Blood Magic": 2},
				{Thaumcraft: 1, Botania: 2, "Blood Magic": 1},
				{Thaumcraft: 1, Botania: 1, "Blood Magic": 2}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 600); #MK dissolution chamber
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, mkCrystals[i] * 2); #MK purification chamber
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, mkShards[i] * 2); #MK injection chamber
			
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 10); #MK Crusher (2x output)
			
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 10); #MK enrichment chamber (2x output)
			}
		}
		
		for i, input in tmPurified4 {
				mekanismRecipes4(i, input, mkSlurries, mkCrystals, mkShards, ic2TinyDusts);
				
				furnace.addRecipe(tfNuggets[i] * 5, input, 0.5); #Furnace (1x output)
				SlagFurnace.addRecipe(input, tfNuggets[i], 7.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
				recipes.addShapeless(tfNuggets[i] * 10, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
				RSFurnace.addRecipe(800, input, tfNuggets[i] * 10); #TE Redstone furnace (2x output)
				ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 10, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 5 ); #TE Induction smelter Sand (2x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 10, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 15 ); #TE Induction smelter Pyrotheum (2x output)
				InfernalBlastfurnace.addRecipe(tfNuggets[i] * 11, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
				ArcFurnace.addRecipe(tfNuggets[i] * 12, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
				ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 15, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 15, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 5); #TE Induction smelter Cinnabar (3x+ output)
			
				Smeltery.addMelting(input, moltenMetals[i] * 180, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
				Crucible.addRecipe(100000, input, moltenMetals[i] * 180); #TE Magma Crucible
				
				recipes.addShapeless(ic2TinyDusts[i] * 7, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
				IECrusher.addRecipe(ic2TinyDusts[i] * 10, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
				Macerator.addRecipe(ic2TinyDusts[i] * 10, input); #IC2 macerator (2x output)
				Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 10, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 5); #TE Pulverizer (2x+ output)
				Lacerator.addRecipe(input, ic2TinyDusts[i], 15.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 5 (6)
		function mekanismRecipes5(i as int, input as IItemStack, mkSlurries as IGasStack[], ic2TinyDusts as IItemStack[], tfNuggets as IItemStack[])
		{
			var tags = [ {Thaumcraft: 2, Botania: 2, "Blood Magic": 1},
				{Thaumcraft: 2, Botania: 1, "Blood Magic": 2},
				{Thaumcraft: 1, Botania: 2, "Blood Magic": 2}
			] as IData[];
	
			for tag in tags {
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 700); #MK dissolution chamber
				
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 12); #MK Crusher (2x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 12); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 18); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 24); #MK injection chamber (4x output)
			}
		}
		
		for i, input in tmPurified5 {
				mekanismRecipes5(i, input, mkSlurries, ic2TinyDusts, tfNuggets);
				
				furnace.addRecipe(tfNuggets[i] * 6, input, 0.5); #Furnace (1x output)
				SlagFurnace.addRecipe(input, tfNuggets[i], 9.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
				recipes.addShapeless(tfNuggets[i] * 12, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
				RSFurnace.addRecipe(800, input, tfNuggets[i] * 12); #TE Redstone furnace (2x output)
				ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 12, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Sand (2x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 12, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 18 ); #TE Induction smelter Pyrotheum (2x output)
				InfernalBlastfurnace.addRecipe(tfNuggets[i] * 14, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
				ArcFurnace.addRecipe(tfNuggets[i] * 15, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
				ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, ic2Ingots[i] * 3, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, ic2Ingots[i] * 3, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 6); #TE Induction smelter Cinnabar (3x+ output)
			
				Smeltery.addMelting(input, moltenMetals[i] * 216, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
				Crucible.addRecipe(120000, input, moltenMetals[i] * 216); #TE Magma Crucible
				
				recipes.addShapeless(ic2TinyDusts[i] * 9, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
				IECrusher.addRecipe(ic2TinyDusts[i] * 12, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
				Macerator.addRecipe(ic2TinyDusts[i] * 12, input); #IC2 macerator (2x output)
				Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 12, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 6); #TE Pulverizer (2x+ output)
				Lacerator.addRecipe(input, ic2TinyDusts[i], 18.0); #FZ Lacerator (3x output)
		}
		
	#tm purified 6 (7)
		for i, input in tmPurified6 {
				var tag = {Thaumcraft: 2, Botania: 2, "Blood Magic": 2} as IData;
				
				Dissolution.addRecipe(input.withTag(tag), mkSlurries[i] * 800); #MK dissolution chamber
				
				furnace.addRecipe(tfNuggets[i] * 7, input, 0.5); #Furnace (1x output)
				SlagFurnace.addRecipe(input, tfNuggets[i], 10.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
				recipes.addShapeless(tfNuggets[i] * 14, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
				RSFurnace.addRecipe(800, input, tfNuggets[i] * 14); #TE Redstone furnace (2x output)
				ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 14, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 7 ); #TE Induction smelter Sand (2x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 14, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 21 ); #TE Induction smelter Pyrotheum (2x output)
				InfernalBlastfurnace.addRecipe(tfNuggets[i] * 16, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
				ArcFurnace.addRecipe(tfNuggets[i] * 17, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
				ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 21, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
				ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 21, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 7); #TE Induction smelter Cinnabar (3x+ output)
			
				Smeltery.addMelting(input, moltenMetals[i] * 252, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
				Crucible.addRecipe(140000, input, moltenMetals[i] * 252); #TE Magma Crucible
				
				recipes.addShapeless(ic2TinyDusts[i] * 10, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
				MKCrusher.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 14); #MK Crusher (2x output)
				IECrusher.addRecipe(ic2TinyDusts[i] * 14, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
				Macerator.addRecipe(ic2TinyDusts[i] * 14, input); #IC2 macerator (2x output)
				Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 14, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 7); #TE Pulverizer (2x+ output)
				Lacerator.addRecipe(input, ic2TinyDusts[i], 21.0); #FZ Lacerator (3x output)
				
				Enrichment.addRecipe(input.withTag(tag), ic2TinyDusts[i] * 14); #MK enrichment chamber (2x output)
				Purification.addRecipe(input.withTag(tag), <gas:oxygen>, tfNuggets[i] * 21); #MK purification chamber (3x output)
				Injection.addRecipe(input.withTag(tag), <gas:hydrogenchloride>, tfNuggets[i] * 28); #MK injection chamber (4x output)
		}
	
	#mk slurries
		for i, slurry in mkSlurries {
			MKCrystallizer.addRecipe(slurry * 300, mkCrystals[i]);
		}
	
	#mk crystals (3)
		for i, input in mkCrystals {
			furnace.addRecipe(tfNuggets[i] * 3, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 4.0, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 5, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 5); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 5, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 3 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 5, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 9 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 5, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 6, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 5, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 5, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 3); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 80, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(40000, input, moltenMetals[i] * 80); #TE Magma Crucible
			
			recipes.addShapeless(ic2TinyDusts[i] * 4, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 5); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 5, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 5, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 5, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 3); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 5.5); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 5); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 5); #MK purification chamber (3x output)
		}
	
	#mk shards (5)
		for i, input in mkShards {
			furnace.addRecipe(tfNuggets[i] * 5, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 5.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 6, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 6); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 5 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 6, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 15 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 6, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 7, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 6, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 6, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 5 ); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 96, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(60000, input, moltenMetals[i] * 96); #TE Magma Crucible
			
			recipes.addShapeless(ic2TinyDusts[i] * 5, [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer (1 - 1,5x output)
			MKCrusher.addRecipe(input, ic2TinyDusts[i] * 6); #MK Crusher (2x output)
			IECrusher.addRecipe(ic2TinyDusts[i] * 6, input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher (2x output)
			Macerator.addRecipe(ic2TinyDusts[i] * 6, input); #IC2 macerator (2x output)
			Pulverizer.addRecipe(1000, input, ic2TinyDusts[i] * 6, tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 5); #TE Pulverizer (2x+ output)
			Lacerator.addRecipe(input, ic2TinyDusts[i], 6.5); #FZ Lacerator (3x output)
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 6); #MK enrichment chamber (2x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 6); #MK injection chamber (4x output)
		}
	
	#mk clumps (6)
		for i, input in mkClumps {
			furnace.addRecipe(tfNuggets[i] * 6, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 7.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 7, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 7); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 7, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 6 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 7, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 18 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 7, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 8, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 7, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 7, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 6); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 112, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(30000, input, moltenMetals[i] * 112); #TE Magma Crucible
			
			recipes.addShapeless(mkDirtyDusts[i], [<ImmersiveEngineering:tool>, input]); #IE Engineers Hammer
			IECrusher.addRecipe(mkDirtyDusts[i], input, 2500, ieCrusherSecondaries[i], 0.1); #IE Crusher
			Macerator.addRecipe(mkDirtyDusts[i], input); #IC2 macerator
			Pulverizer.addRecipe(1000, input, mkDirtyDusts[i], tfPulvSecondaries[i], tfPulvSecondaryChances[i] * 6); #TE Pulverizer
			Lacerator.addRecipe(input, mkDirtyDusts[i], 1.1); #FZ Lacerator
			
			Enrichment.addRecipe(input, ic2TinyDusts[i] * 7); #MK enrichment chamber (2x output)
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 7); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 7); #MK injection chamber (4x output)
		}
		
	#mk dirty dusts (8)
		for i, input in mkDirtyDusts {
			furnace.addRecipe(tfNuggets[i] * 8, input, 0.5); #Furnace (1x output)
			SlagFurnace.addRecipe(input, tfNuggets[i], 8.5, <minecraft:dirt>, 0.1); #FZ Slag Furnace (1,5x output)
			recipes.addShapeless(tfNuggets[i] * 8, [<ThermalFoundation:material:512>, input ]); #Pyrotheum (2x output)
			RSFurnace.addRecipe(800, input, tfNuggets[i] * 8); #TE Redstone furnace (2x output)
			ISmelter.addRecipe(1600, <minecraft:sand>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 8 ); #TE Induction smelter Sand (2x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:512>, input, tfNuggets[i] * 8, <ThermalExpansion:material:515> , tfISmelterRichChances[i] * 24 ); #TE Induction smelter Pyrotheum (2x output)
			InfernalBlastfurnace.addRecipe(tfNuggets[i] * 8, input, 50, ic2TinyDusts[i], true); #WG Infernal Blast Furnace (2 - 2,5x output)
			ArcFurnace.addRecipe(tfNuggets[i] * 9, input, <ImmersiveEngineering:material:13>, 100, 512); #IE Arc Furnace (2 - 2,5x output)
			ISmelter.addRecipe(2000, <ThermalExpansion:material:515>, input, tfNuggets[i] * 8, <ThermalExpansion:material:514> , 75 ); #TE Induction smelter Rich Slag (3x output)
			ISmelter.addRecipe(2000, <ThermalFoundation:material:20>, input, tfNuggets[i] * 8, tfISmelterSecondaries[i], tfISmelterSecChances[i] * 8); #TE Induction smelter Cinnabar (3x+ output)
			
			Smeltery.addMelting(input, moltenMetals[i] * 132, smeltingTemperatures[i], tfBlocks[i]); #TiC Smeltery (2.25x output)
			Crucible.addRecipe(80000, input, moltenMetals[i] * 132); #TE Magma Crucible
			
			Purification.addRecipe(input, <gas:oxygen>, tfNuggets[i] * 8); #MK purification chamber (3x output)
			Injection.addRecipe(input, <gas:hydrogenchloride>, tfNuggets[i] * 8); #MK injection chamber (4x output)
		}
	
	
#todo:
#1. Uranium TCclusters do exist
#2. Make Semi-Product -> Tiny dust Sagmill recipes more complex (different energy values 'n stuff)?
#3. Other Bronze armours?
#4. Dedicated Functions for adding crusher and furnace recipes (maybe smelting as well?)

#Other files are needed for the OP to work: aobd.cfg and ic2/Blast_Furnace.ini

#Problems
#Fz lacerator recipes cannot be removed?
#IC2 Uranium is a separate case, I guess?
