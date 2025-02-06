#priority 727
#modloaded lychee

import crafttweaker.api.recipe.IRecipeManager;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.util.random.Percentaged;
import crafttweaker.api.recipe.type.Recipe;
import crafttweaker.api.world.Container;

/*
    This is how you will be making your Lychee recipes, by calling LycheeRecipeManager.addRecipe().
    这就是您编写 Lychee 配方的方法，只需通过调用 LycheeRecipeManager.addRecipe()。
*/
public class LycheeRecipeManager {
    public static addRecipe(name as string, recipeType as IRecipeManager<Recipe<Container>>, builder as LycheeRecipeBuilder) as void {
        recipeType.addJsonRecipe(name, builder.getRecipe());
    }

    public static removeByName(recipeType as IRecipeManager<Recipe<Container>>, name as string) as void {
        recipeType.removeByName(name);
    }

    public static remove(recipeType as IRecipeManager<Recipe<Container>>, output as IIngredient) as void {
        recipeType.remove(output);
    }
}