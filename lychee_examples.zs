#noload

/*
    Valid recipetypes:
    <recipetype:lychee:lightning_channeling>
    <recipetype:lychee:item_inside>
    <recipetype:lychee:item_exploding>
    <recipetype:lychee:item_burning>
    <recipetype:lychee:anvil_crafting>
    <recipetype:lychee:block_exploding>
    <recipetype:lychee:block_crushing>
    <recipetype:lychee:block_interacting>
    <recipetype:lychee:block_clicking>
    <recipetype:lychee:random_block_ticking> //1.19+ 
    <recipetype:lychee:dripstone_dripping> //1.19+
    <recipetype:lychee:crafting> //1.19+ Cannot be used directly, need to call LycheeRecipeManager.addAdvencedRecipe(...)
*/

import crafttweaker.api.util.math.BlockPos;

//Toss brick into fire, get back nether brick
LycheeRecipeManager.addRecipe("example_item_burning", <recipetype:lychee:item_burning>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:brick>)
    .post(LycheePosts.dropItem(<item:minecraft:nether_brick>))
);


//Gives all players in a 5 block radius Wither 3 for 10 seconds
LycheeRecipeManager.addRecipe("sand_crush_nether_star", <recipetype:lychee:block_crushing>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:nether_star>)
    .crushingFallingBlock(<block:minecraft:sand>)
    .post(LycheePosts.executeCommand("effect give @e[type=minecraft:player, distance=0..5] minecraft:wither 10 2"))
);

//Turn sand into glass, in the nether while sneaking
LycheeRecipeManager.addRecipe("smelt_sand", <recipetype:lychee:block_interacting>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:fire_charge>)
    .blockIn(<block:minecraft:sand>)
    .condition([LycheeConditions.dimension("minecraft:the_nether"), LycheeConditions.isSneaking()])
    .post([LycheePosts.placeBlock(<block:minecraft:glass>).condition(LycheeConditions.fluid(<tag:fluid:c:lava>,new BlockPos(0,1,0))), LycheePosts.executeCommand("particle minecraft:end_rod ~ ~ ~ 0.1 0.1 0.1 0.1 4")])
);

LycheeTags.fireImmune(<tag:item:c:sands>);
LycheeTags.lightningImmune(<entitytype:minecraft:cat>);

craftingTable.remove(<item:minecraft:coarse_dirt>);
LycheeRecipeManager.addAdvancedRecipe(<item:minecraft:coarse_dirt>, [
    [<item:minecraft:stone>,<item:minecraft:stone>],
    [<item:minecraft:dirt>,<item:minecraft:dirt>],
    [<item:minecraft:stone>,<item:minecraft:stone>]
], new LycheeRecipeBuilder()
    .comment("Tetsing")
    .assembling(LycheePosts.setItem(<item:minecraft:redstone>).target("/result"))
);