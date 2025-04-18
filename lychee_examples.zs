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
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.predicate.EntityPredicate;

//Toss brick into fire, get back nether brick
//将红砖丢入火中返回下界砖
LycheeRecipeManager.addRecipe(<recipetype:lychee:item_burning>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:brick>)
    //Debugging log: When multiple item inputs are not supported for recipe types, prioritize reading the last one
    //调试日志:在不支持多个物品输入的配方类型时，优先读取最后一个
    // .itemIn([<item:minecraft:brick>,<tag:item:minecraft:coals>])
    // .itemIn()
    .post(LycheePosts.dropItem(<item:minecraft:nether_brick>))
);

//Gives all players in a 5 block radius Wither 3 for 10 seconds
//给半径五格内的玩家10秒的3级凋灵效果
LycheeRecipeManager.addRecipe(<recipetype:lychee:block_crushing>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:nether_star>)
    .crushingFallingBlock(<block:minecraft:sand>)
    .crushingLandingBlock(<block:minecraft:composter>)
    // .post(LycheePosts.dropItem(<item:minecraft:dirt>))
    .post(LycheePosts.executeCommand("effect give @e[type=minecraft:player, distance=0..5] minecraft:wither 10 2"))
);

//Turn sand into glass, in the nether while sneaking
//在下界潜行时，将沙子转换成玻璃
LycheeRecipeManager.addRecipe(<recipetype:lychee:block_interacting>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:fire_charge>)
    .blockIn(<block:minecraft:sand>)
    //Debugging log: Allow any block
    //调试日志:允许任意方块
    // .blockIn(new LycheeBlock())
    .condition(LycheeConditions.onlyOne([LycheeConditions.dimension("minecraft:the_nether"), LycheeConditions.isSneaking()]).description("需要满足条件[维度：下界,潜行]之一,必须只满足多个条件中的一条"))
    //Debugging log: condition test, allowing output only when conditions are met
    //调试日志:condition测试，需要满足条件时才允许输出
    .post([LycheePosts.placeBlock(<block:minecraft:glass>), LycheePosts.executeCommand("particle minecraft:end_rod ~ ~ ~ 0.1 0.1 0.1 0.1 4")])
);

LycheeTags.fireImmune(<tag:item:c:sands>);
LycheeTags.lightningImmune(<entitytype:minecraft:cat>);
LycheeTags.extendBox(<block:minecraft:composter>);

craftingTable.remove(<item:minecraft:coarse_dirt>);
LycheeRecipeManager.addAdvancedRecipe(<item:minecraft:coarse_dirt>, [
    [<item:minecraft:stone>,<item:minecraft:stone>],
    [<item:minecraft:dirt>,<item:minecraft:dirt>],
    [<item:minecraft:stone>,<item:minecraft:stone>]
], new LycheeRecipeBuilder()
    .comment("testing")
    .assembling(LycheePosts.setItem(<item:minecraft:redstone>).target("/result"))
);

LycheeRecipeManager.addRecipe(<recipetype:lychee:dripstone_dripping>,new LycheeRecipeBuilder()
    .sourceBlock(<blockstate:minecraft:water>)
    .targetBlock(new LycheeBlock([
        <block:minecraft:green_wool>,
        <block:minecraft:cyan_wool>,
        <block:minecraft:light_blue_wool>,
        <block:minecraft:blue_wool>,
        <block:minecraft:purple_wool>,
        <block:minecraft:magenta_wool>,
        <block:minecraft:pink_wool>,
        <block:minecraft:lime_wool>,
        <block:minecraft:yellow_wool>,
        <block:minecraft:orange_wool>,
        <block:minecraft:red_wool>,
        <block:minecraft:brown_wool>,
        <block:minecraft:black_wool>,
        <block:minecraft:gray_wool>,
        <block:minecraft:light_gray_wool>,
    ]))
    .post(LycheePosts.placeBlock(<block:minecraft:white_wool>))
);

LycheeRecipeManager.addRecipe(<recipetype:lychee:item_exploding>, new LycheeRecipeBuilder()
    .itemIn([<item:minecraft:obsidian>,<tag:item:minecraft:coals>,<item:minecraft:brick>])
    .post(LycheePosts.dropItem(<item:minecraft:soul_soil>))
);

LycheeRecipeManager.addRecipe(<recipetype:lychee:item_inside>, new LycheeRecipeBuilder()
    .itemIn(<item:minecraft:gunpowder> * 2)
    .blockIn(<block:minecraft:air>)
    .post(LycheePosts.explode(4,0.5,new BlockPos(0,0,0),LycheeEnum.DESTROR_WITH_DECAY,false))
);

<tag:item:lychee:item_exploding_catalysts>.add(<item:minecraft:gunpowder>);

<tag:block:waterlogged>.add(<block:minecraft:oak_stairs>);

val postList as LycheePost[] = [
    LycheePosts.placeBlock(<block:minecraft:light_gray_wool>, new BlockPos(1,0,0))
        .condition(LycheeConditions.block(<block:minecraft:deepslate>, new BlockPos(2,0,0))),  
    LycheePosts.placeBlock(<block:minecraft:light_gray_wool>, new BlockPos(-1,0,0))
        .condition(LycheeConditions.block(<block:minecraft:deepslate>, new BlockPos(-2,0,0))),
    LycheePosts.placeBlock(<block:minecraft:light_gray_wool>, new BlockPos(0,0,1))
        .condition(LycheeConditions.block(<block:minecraft:deepslate>, new BlockPos(0,0,2))),
    LycheePosts.placeBlock(<block:minecraft:light_gray_wool>, new BlockPos(0,0,-1))
        .condition(LycheeConditions.block(<block:minecraft:deepslate>, new BlockPos(0,0,-2)))
];

LycheeRecipeManager.addRecipe(<recipetype:lychee:random_block_ticking>, new LycheeRecipeBuilder()
    .blockIn(new LycheeBlock(<tag:block:waterlogged>,new LycheeBlockState({waterlogged: "true"} as MapData)))
    .post(postList)
);

LycheeRecipeManager.addRecipe(<recipetype:lychee:random_block_ticking>, new LycheeRecipeBuilder()
    .blockIn(<block:minecraft:water>)
    .post(postList)
);

LycheeRecipeManager.addRecipe(<recipetype:lychee:block_interacting>, new LycheeRecipeBuilder()
    .blockIn(<block:minecraft:grass_block>)
    .itemIn(<item:minecraft:lever>)
    // .post([LycheePosts.move(0.0,1.0,0.0),LycheePosts.placeBlock(<block:minecraft:dirt>)])
);
