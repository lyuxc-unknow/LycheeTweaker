#priority 727
#modloaded lychee

import crafttweaker.api.entity.Entity;
import crafttweaker.api.entity.EntityType;
import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.tag.type.KnownTag;
import stdlib.List;

public class LycheeTags {
    public static dispenserPlacement(ingredient as IIngredient) as void{
        var itemList = new List<IItemStack>();
        for item in ingredient.items {
            itemList.add(item);
        }
        <tag:item:lychee:dispenser_placement>.add(itemList);
    }

    public static fireImmune(ingredient as IIngredient) as void{
        var itemList = new List<IItemStack>();
        for item in ingredient.items {
            itemList.add(item);
        }
        <tag:item:lychee:fire_immune>.add(itemList);
    }

    public static lightningImmune(entity as EntityType<Entity>) as void {
        <tag:entity_type:lychee:lightning_immune>.add(entity);
    }

    public static lightningFireImmune(entity as EntityType<Entity>) as void {
        <tag:entity_type:lychee:lightning_fire_immune>.add(entity);
    }
}