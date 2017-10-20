#imports
	import minetweaker.item.IItemStack;
	
	import mods.immersiveengineering.Squeezer;	
	import mods.agricraft.growing.BaseBlock;
	#Dense Ores
	
#lists
	var seeds = [
		<AgriCraft:seedFerranium>, #iron
		<AgriCraft:seedAurigold>, #gold
		<AgriCraft:seedLapender>, #lapis
		<AgriCraft:seedDiamahlia>, #diamond
		<AgriCraft:seedEmeryllis>, #emerald
		<AgriCraft:seedRedstodendron>, #redstone
		<AgriCraft:seedQuartzanthemum>, #nether quartz
		<AgriCraft:seedCuprosia>, #copper
		<AgriCraft:seedPetinia>, #tin
		<AgriCraft:seedSilverweed>, #silver
		<AgriCraft:seedPlombean>, #lead
		<AgriCraft:seedNiccissus>, #nickel
		<AgriCraft:seedPlatiolus>, #platinum
		<AgriCraft:seedJaslumine>, #aluminium
		<AgriCraft:seedOsmonium> #osmium
	] as IItemStack[];

	var denseOres = [
		<denseores:block0>, #iron
		<denseores:block0:1>, #gold
		<denseores:block0:2>, #lapis
		<denseores:block0:3>, #diamond
		<denseores:block0:4>, #emerald
		<denseores:block0:5>, #redstone
		<denseores:block0:7>, #nether quartz
		<denseores:block1:14>, #copper
		<denseores:block1:15>, #tin
		<denseores:block2>, #silver
		<denseores:block2:1>, #lead
		<denseores:block2:2>, #nickel
		<denseores:block2:3>, #platinum
		<denseores:block2:9>, #aluminium
		<denseores:block5:13> #osmium
	] as IItemStack[];

#baseblock changes
	for i, seed in seeds {
		BaseBlock.set(seed, denseOres[i], 1, true);
	}

val seed = <ore:listAllseed>;
	seed.add(<ActuallyAdditions:itemRiceSeed>);
	seed.add(<ActuallyAdditions:itemCanolaSeed>);
	seed.add(<ActuallyAdditions:itemFlaxSeed>);
	seed.add(<ActuallyAdditions:itemCoffeeSeed>);
	seed.add(<minecraft:wheat_seeds>);
	seed.add(<minecraft:pumpkin_seeds>);
	seed.add(<minecraft:melon_seeds>);
	seed.add(<ImmersiveEngineering:seed>);
	
	Squeezer.addRecipe(null, <liquid:plantoil> * 80, seed, 80);
	