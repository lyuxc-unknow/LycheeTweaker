#priority 727
#modloaded lychee

import crafttweaker.api.block.Block;
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
        Add the lychee:item_deploding_catalysts tag to the item, which allows the item to be a catalyst synthesized by explosion in XEI (i.e. the item in the upper left corner of the JEI interface)
        为物品添加 lychee:item_exploding_catalysts 标签，该标签允许物品为XEI中物品爆破合成的催化剂（即JEI界面左上角的物品）
    */
    public static itemExplodingCatalysts(ingredient as IIngredient) as void{
        var itemList = new List<IItemStack>();
        for item in ingredient.items {
            itemList.add(item);
        }
        <tag:item:lychee:item_exploding_catalysts>.add(itemList);
    }

    /*
        Add the lychee:block_deploding_catalysts tag to the item, which allows the item to be a catalyst synthesized by block explosion in XEI (i.e. the item in the upper left corner of the JEI interface)
        为物品添加 lychee:block_exploding_catalysts 标签，该标签允许物品为XEI中方块爆破合成的催化剂（即JEI界面左上角的物品）
    */
    public static blockExplodingCatalysts(ingredient as IIngredient) as void{
        var itemList = new List<IItemStack>();
        for item in ingredient.items {
            itemList.add(item);
        }
        <tag:item:lychee:block_exploding_catalysts>.add(itemList);
    }

    /*
        Add the lychee:lightning_immune tag to the entity, which allows the entity to be protected from lightning damage
        为实体添加 lychee:lightning_immune 标签，该标签允许实体不会受到闪电的伤害
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

    /*
        Add the lychee: extend_fox tag to the block, 
        which allows for automatic processing of blocks contained within the block when<recipe type: lychee: block_crushing>[block falling during crafting] if the target block is incomplete and contains the target item
        为方块添加 lychee:extend_box标签，该标签允许<recipetype:lychee:block_crushing>[方块下落合成]时若目标方块为不完整方块且方块内含有目标物品时,自动处理方块内含有的方块
    */
    public static extendBox(block as Block) as void {
        <tag:block:lychee:extend_box>.add(block);
    }
    /*
        Same as above, but with tags passed in
        同上，但是传入的是标签
    */
    public static extendBox(tag as KnownTag<Block>) as void {
        <tag:block:lychee:extend_box>.add(tag);
    }
}