import minetweaker.item.IItemStack;
import minetweaker.liquid.ILiquidStack;

import mods.tconstruct.Smeltery;

var poorOres = [ 
	<Railcraft:ore:7>, #iron
	<Railcraft:ore:8>, #gold
	<Railcraft:ore:9>, #copper
	<Railcraft:ore:10>, #tin
	<Railcraft:ore:11>, #lead
	<Steamcraft:steamcraftOre:2> #zinc
] as IItemStack[];

var moltenMetals = [ 
	<liquid:iron.molten>, #iron
	<liquid:gold.molten>, #gold
	<liquid:copper.molten>, #copper
	<liquid:tin.molten>, #tin
	<liquid:lead.molten>, #lead
	<liquid:zinc.molten> #zinc
] as ILiquidStack[];

var smeltingTemperatures = [ 600, #iron
	400, #gold
	550, #copper
	350, #tin
	500, #lead
	550 #zinc
] as int[];

for i, input in poorOres {
	Smeltery.addMelting(input, moltenMetals[i] * 48, smeltingTemperatures[i], poorOres[i]);
}