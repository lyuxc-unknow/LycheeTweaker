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
            if (resourceId == "minecraft:lore" && value.asList().isEmpty) continue;
            if (resourceId == "minecraft:max_stack_size" && value.asInt() in [1,2,4,8,16,32,64]) continue;
            if (resourceId == "minecraft:attribute_modifiers" && value.asString() == "{modifiers: []}") continue;
            if (resourceId == "minecraft:enchantments" && value.asString() == "{levels: {}}") continue;
            if (resourceId == "minecraft:repair_cost" && value.asInt() == 0) continue;
            if (resourceId == "minecraft:rarity" && value.asString() in ["\"common\"","\"uncommon\"","\"rare\"","\"epic\""]) continue;
            datas.put(resourceId,value);
        }

        if (!datas.isEmpty()) {
            itemData.put("components",datas);
        }

        return itemData;
    }
}