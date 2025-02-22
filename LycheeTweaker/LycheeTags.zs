#priority 727
#modloaded lychee

import crafttweaker.api.entity.Entity;
import crafttweaker.api.entity.EntityType;
import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.tag.type.KnownTag;
import stdlib.List;

public class LycheeTags {
    /*
        Add lychee:dispenser_placement tag to the item, which allows the dispenser to place blocks
        为物品添加 lychee:dispenser_placement 标签，该标签允许发射器放置含有这个标签的方块
    */
    public static dispenserPlacement(ingredient as IIngredient) as void{
        var itemList = new List<IItemStack>();
        for item in ingredient.items {
            itemList.add(item);
        }
        <tag:item:lychee:dispenser_placement>.add(itemList);
    }

    /*
        Add the lychee:fire_immune tag to the item, which allows it to be protected from fire damage
        为物品添加 lychee:dispenser_placement 标签，该标签允许物品不会被火焰烧掉
    */
    public static fireImmune(ingredient as IIngredient) as void{
        var itemList = new List<IItemStack>();
        for item in ingredient.items {
            itemList.add(item);
        }
        <tag:item:lychee:fire_immune>.add(itemList);
    }

    /*
        Add the lychee:lightning_immune tag to the entity, which allows the entity to be protected from lightning damage
        为实体添加l ychee:lightning_immune 标签，该标签允许实体不会受到闪电的伤害
    */
    public static lightningImmune(entity as EntityType<Entity>) as void {
        <tag:entity_type:lychee:lightning_immune>.add(entity);
    }

    /*
        Add the lychee:lightning_fire_immune tag to the entity, which allows the entity to be protected from flame damage caused by lightning
        为实体添加 lychee:lightning_fire_immun 标签，该标签允许实体不会被闪电产生的火焰伤害
    */
    public static lightningFireImmune(entity as EntityType<Entity>) as void {
        <tag:entity_type:lychee:lightning_fire_immune>.add(entity);
    }
}