#priority 727
#modloaded lychee

import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.fluid.IFluidStack;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.ingredient.IIngredient;
import stdlib.List;

/*
    It is HIGHLY recommended to check the Lychee wiki in order to fully understand how the mod works.
    强烈建议查看 Lychee wiki，以便全面了解该模组的工作原理。
*/
public class LycheeRecipeBuilder {
    private var recipe as MapData;

    /*
        Create a blank recipe at the start.
        创建一个空白的配方表。
    */
    public this() {
        recipe = {};
    }

    public getRecipe() as MapData => recipe;

    /*
        Add a neoforge condition to the recipe. See https://docs.neoforged.net/docs/1.21.1/resources/server/conditions for more info
        为配方添加neoforge的数据条件 请参阅 https://docs.neoforged.net/docs/1.21.1/resources/server/conditions 了解更多信息
    */
    public neoforgeConditions(conditions as MapData[]) as LycheeRecipeBuilder {
        var conditionList = new List<IData>();
        for condition in conditions {
            conditionList.add(condition as IData);
        }
        recipe.put("neoforge:conditions", new ListData(conditionList));
        return this;
    }
    
    /*
        Add a condition to the recipe. See LycheeCondition.zs for more info.
        Type alias: if
        为配方添加条件。请参阅 LycheeCondition.zs 了解更多信息。
        类型别名：if
    */
    public condition(condition as LycheeCondition) as LycheeRecipeBuilder {
        recipe.put("contextual", condition);
        return this;
    }

    /*
        Add multiple conditions to the recipe. See LycheeCondition.zs for more info.
        Type alias: if
        为配方添加多个条件。请参阅 LycheeCondition.zs 了解更多信息。
        类型别名：if
    */
    public condition(conditions as LycheeCondition[]) as LycheeRecipeBuilder {
        var conditionList = new List<IData>();
        for condition in conditions {
            conditionList.add(condition as IData);
        }
        recipe.put("contextual", new ListData(conditionList));
        return this;
    }

    /*
        Add a post action to the recipe. See LycheePost.zs for more info.
        为配方添加一个Post操作。请参阅 LycheePost.zs 了解更多信息。
    */
    public post(post as LycheePost) as LycheeRecipeBuilder {
        recipe.put("post", post);
        return this;
    }

    /*
        Add multiple post actions to the recipe. See LycheePost.zs for more info.
        为配方添加多个Post操作。请参阅 LycheePost.zs 了解更多信息。
    */
    public post(posts as LycheePost[]) as LycheeRecipeBuilder {
        var postList = new List<IData>();
        for post in posts {
            postList.add(post as IData);
        }
        recipe.put("post", new ListData(postList));
        return this;
    }

    /*
        Add a assembling action(actions that running before the result is displayed) to the recipe
        为配方添加一个Assembling操作(在显示结果前的操作)
    */
    public assembling(assemblingAction as LycheePost) as LycheeRecipeBuilder {
        recipe.put("assembling", assemblingAction);
        return this;
    }

    /*
        Add multiple assembling action(actions that running before the result is displayed) to the recipe
        为配方添加多个Assembling操作(在显示结果前的操作)
    */
    public assembling(assemblingActions as LycheePost[]) as LycheeRecipeBuilder {
        var postList = new List<IData>();
        for post in assemblingActions {
            postList.add(post as IData);
        }
        recipe.put("assembling", new ListData(postList));
        return this;
    }

    /*
        Adds a comment to put when you hover over the (i) in JEI
        添加注释，当您将鼠标悬停在 JEI 中的 (i) 上时显示
    */
    public comment(comment as string) as LycheeRecipeBuilder {
        recipe.put("comment", comment);
        return this;
    }

    /*
        If true, recipe appears in JEI but does not do anything.
        如果为true, 配方将会出现在JEI中但是无法合成
    */
    public setGhost(isGhost as bool) as LycheeRecipeBuilder {
        recipe.put("ghost", isGhost);
        return this;
    }

    /*
        Whether or not to hide in JEI.
        是否在 JEI 中隐藏。
    */
    public setHideInJEI(shouldHide as bool) as LycheeRecipeBuilder {
        recipe.put("hide_in_viewer", shouldHide);
        return this;
    }

    /*
        Some recipes are repeatable, this allows you to control how much they can be repeated
        有些配方是可重复的，这可以让你控制重复的次数
    */
    public setMaxRepeats(repeats as int) as LycheeRecipeBuilder {
        recipe.put("max_repeats", repeats);
        return this;
    }

    // ==================================================================================================== //
    // For everything below this line, check on the wiki FIRST if the recipe supports the given input type. //
    //                 对于此行以下的所有内容，请首先在 wiki 上检查该配方是否支持给定的输入类型。                 //
    // ==================================================================================================== //


    /*
        Adds an item input to the recipe.
        向配方中添加物品输入。
    */
    public itemIn(ingredient as IIngredient) as LycheeRecipeBuilder {
        recipe.put("item_in", DataConvertUtils.convertItemStack(ingredient));
        return this;
    }

    /*
        Adds any item input to the recipe.
        向配方中添加任意物品输入。
    */
    public itemIn() as LycheeRecipeBuilder {
        recipe.put("item_in", {type: "lychee:always_true" as IData} );
        return this;
    }

    /*
        Multiple item inputs.
        多个物品输入
    */
    public itemIn(ingredients as IIngredient[]) as LycheeRecipeBuilder {
        var ingredientList = new List<IData>();
        for ingredient in ingredients {
            ingredientList.add(DataConvertUtils.convertItemStack(ingredient));
        }
        recipe.put("item_in", new ListData(ingredientList));
        return this;
    }
    /*
        Adds a block input to the recipe. See LycheeBlock.zs for more info.
        向配方中添加方块输入。有关更多信息，请参阅 LycheeBlock.zs。
    */
    public blockIn(block as LycheeBlock) as LycheeRecipeBuilder {
        recipe.put("block_in", block);
        return this;
    }

    /*
        Waiting time for Item Entity inside a Block recipes (lychee:item_inside)
        物品实体在方块中合成等待事件（lychee:item_inside）
    */
    public insideBlockTime(time as int) as LycheeRecipeBuilder {
        recipe.put("time", time);
        return this;
    }

    /*
        Output item for anvil recipes (lychee:anvil_crafting)
        铁砧合成的输出物品（lychee:anvil_crafting）
    */
    public anvilItemOut(stack as IItemStack) as LycheeRecipeBuilder {
        recipe.put("item_out", stack);
        return this;
    }
    /*
        XP level cost for anvil recipes (lychee:anvil_crafting)
        铁砧合成的经验等级消耗（lychee:anvil_crafting）
    */
    public anvilLevelCost(cost as int) as LycheeRecipeBuilder {
        recipe.put("level_cost", cost);
        return this;
    }
    /*
        Amount of materials consumed by anvil recipes (lychee:anvil_crafting)
        铁砧合成所消耗的材料数量（lychee:anvil_crafting）
    */
    public anvilMaterialCost(cost as int) as LycheeRecipeBuilder {
        recipe.put("material_cost", cost);
        return this;
    }

    /*
        Block that is falling in block crushing recipes (lychee:block_crushing)
        方块掉落合成中所需要掉落的方块（lychee:block_crushing）
    */
    public crushingFallingBlock(block as LycheeBlock) as LycheeRecipeBuilder {
        recipe.put("falling_block", block);
        return this;
    }
    /*
        Block that is landed upon in block crushing recipes (lychee:block_crushing)
        方块掉落合成中所需要掉落在指定的方块（lychee:block_crushing）
    */
    public crushingLandingBlock(block as LycheeBlock) as LycheeRecipeBuilder {
        recipe.put("landing_block", block);
        return this;
    }
    /*
        Source block of dropstone cone recipes (lychee:dripstone_dripping)
        滴水石锥合成源头方块 （lychee:dripstone_dripping）
    */
    public sourceBlock(block as LycheeBlock) as LycheeRecipeBuilder {
        recipe.put("source_block", block);
        return this;
    }
    /*
        Source block of dropstone cone recipes (lychee:dripstone_dripping)
        NOTE: can ues IFluidStack as input(need the fluid name as same as IFluidStack registry name)
        滴水石锥合成源头方块 （lychee:dripstone_dripping）
        NOTE: 允许使用 IFluidStack 作为输入(需要流体的IFluidStack注册名与流体方块的注册名称相同)
    */
    public sourceBlock(inputFluid as IFluidStack) as LycheeRecipeBuilder {
        recipe.put("source_block", inputFluid.registryName.toString());
        return this;
    }
    /*
        Target block of dropstone cone recipes (lychee:dripstone_dripping)
        滴水石锥合成目标方块 （lychee:dripstone_dripping）
    */
    public targetBlock(block as LycheeBlock) as LycheeRecipeBuilder {
        recipe.put("target_block", block);
        return this;
    }
    /*
        Target block of dropstone cone recipes (lychee:dripstone_dripping)
        NOTE: can ues IFluidStack as input(need the fluid name as same as IFluidStack registry name)
        滴水石锥合成目标方块 （lychee:dripstone_dripping）
        NOTE: 允许使用 IFluidStack 作为输入(需要流体的IFluidStack注册名与流体方块的注册名称相同)
    */
    public targetBlock(inputFluid as IFluidStack) as LycheeRecipeBuilder {
        recipe.put("target_block", inputFluid.registryName.toString());
        return this;
    }
}