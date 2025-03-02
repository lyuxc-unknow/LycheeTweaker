#priority 727
#modloaded lychee

import crafttweaker.api.recipe.IRecipeManager;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.MapData;
import crafttweaker.api.util.random.Percentaged;
import crafttweaker.api.recipe.type.Recipe;
import crafttweaker.api.world.Container;

/*
    This is the method for writing a Lychee recipe, simply call LycheeRecipeManager.addRecipe(). If you need to add advanced ordered synthesis recipes, you need to call LycheeRecipeManager.addAdvancedRecipe()
    这是编写 Lychee 配方的方法，只需通过调用 LycheeRecipeManager.addRecipe(),如果需要添加高级有序合成配方，则需要调用 LycheeRecipeManager.addAdvancedRecipe()
*/
public class LycheeRecipeManager {
    public static addRecipe(recipeType as IRecipeManager<Recipe<Container>>, builder as LycheeRecipeBuilder) as void {
        recipeType.addJsonRecipe(DataConvertUtils.recipesName(), builder.getRecipe());
    }

    public static addAdvancedRecipe(output as IItemStack, inputs as IIngredient[][], assembling as LycheeRecipeBuilder, group as string = "", recipeName as string = "") as void {
        val recipe = new MapData();

        recipe.put("type","lychee:crafting");
        recipe.merge(DataConvertUtils.toPatternAndKey(inputs));
        recipe.put("result",DataConvertUtils.convertItemStack(output));
        recipe.merge(assembling.getRecipe());

        if (group != "") recipe.put("group",group);
        recipes.addJsonRecipe(DataConvertUtils.recipesName(),recipe);
    }

    public static addAdvancedRecipe(output as IItemStack, inputs as IIngredient[][], group as string = "", recipeName as string = "") as void {
        val recipe = new MapData();

        recipe.put("type","lychee:crafting");
        recipe.merge(DataConvertUtils.toPatternAndKey(inputs));
        recipe.put("result",DataConvertUtils.convertItemStack(output));

        if (group != "") recipe.put("group",group);
        recipes.addJsonRecipe(DataConvertUtils.recipesName(),recipe);
    }

    public static removeByName(recipeType as IRecipeManager<Recipe<Container>>, name as string[]) as void {
        recipeType.removeByName(name);
    }

    public static remove(recipeType as IRecipeManager<Recipe<Container>>, output as IIngredient) as void {
        recipeType.remove(output);
    }
}