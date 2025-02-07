import crafttweaker.api.block.Block;
import crafttweaker.api.block.BlockState;
import crafttweaker.api.data.MapData;
import crafttweaker.api.ingredient.IIngredientWithAmount;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.ItemDefinition;
import crafttweaker.api.resource.ResourceLocation;
import crafttweaker.api.world.Level;
import crafttweaker.api.util.math.BlockPos;

public class DataConvertUtils {
    public static convertItemStack(itemstack: IItemStack): MapData {
        val itemData as MapData = new MapData();
        itemData.put("id",itemstack.registryName);
        itemData.put("item",itemstack.registryName);

        if (itemstack is IIngredientWithAmount) {
            itemData.put("count",(itemstack as IIngredientWithAmount).amount);
        }

        val datacomponent = itemstack.components;
        val datas = new MapData();
        for component in datacomponent.list {
            val resourceId = component.registryName.toString();
            val value = component.asIData();
            datas.put(resourceId,value);
        }

        if (!datas.isEmpty()) {
            itemData.put("components",datas);
        }

        return itemData;
    }
}