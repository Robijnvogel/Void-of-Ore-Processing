//Aluminum Brass Catalyst
mods.thaumcraft.Aspects.set(<TConstruct:materials:24>, "metallum 1");
mods.thaumcraft.Aspects.set(<TConstruct:materials:22>, "metallum 1");

recipes.remove(<Thaumcraft:ItemThaumometer>);
recipes.addShaped(<Thaumcraft:ItemThaumometer>, 
				[[null, <ore:materialAspectShard>, null],
				[<ore:ingotGold>, <ore:blockGlass>, <ore:ingotGold>],
				[null, <ore:materialAspectShard>, null]]);
				
recipes.remove(<Thaumcraft:ItemEssence>);
recipes.addShaped(<Thaumcraft:ItemEssence>, 
				[[null, <ore:itemClay>, null],
				[<ore:blockGlass>, null, <ore:blockGlass>],
				[null, <ore:blockGlass>, null]]);