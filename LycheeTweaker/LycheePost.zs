#priority 1000
#modloaded lychee

import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.util.math.BlockPos;
import stdlib.List;

public class LycheePost {
    protected var data as MapData : get;

    public this(type as string, data as MapData) {
        this.data = ({"type": type} as MapData).merge(data);
    }
    /*
        Fragment methods are not available in ZenSpricts
    */
    // public this(type as string, data as MapData, isFragment as bool = false) {
    //     if(isFragment) {
    //         var typeAB as string[] = type.split("|");
    //         this.data = ({typeAB[0] : typeAB[1]} as MapData).merge(data);
    //     } 
    //     else {
    //         this.data = ({"type": type} as MapData).merge(data);
    //     }
    //     this.data = ({"type": type} as MapData).merge(data);
    // }

    public this(type as string) {
        this.data = {"type": type};
    }

    public withWeight(weight as int) as LycheePost {
        data.put("weight", weight);
        return this;
    }

    // see https://lycheetweaker.readthedocs.io/en/docs-1.21/general-types/#jsonpointer for more info
    // 请参阅 https://lycheetweaker.readthedocs.io/en/docs-1.21/general-types/#jsonpointer 来获得更多信息
    public target(target as string) as LycheePost {
        data.put("target", target);
        return this;
    }

    public hide(hideInXEI as bool) as LycheePost {
        data.put("hide", hideInXEI);
        return this;
    }

    public condition(condition as LycheeCondition) as LycheePost {
        data.put("if", condition);
        return this;
    }

    public icon(path as string) as LycheePost {
        data.put("icon", path);
        return this;
    }

    public condition(conditions as LycheeCondition[]) as LycheePost {
        var conditionList = new List<IData>();
        for condition in conditions {
            conditionList.add(condition as IData);
        }
        data.put("if", new ListData(conditionList));
        return this;
    }
    
    public asData() as IData => data;
    public implicit as IData => data;
}

public class LycheePosts {
    public static dropItem(stack as IItemStack) as LycheePost => new LycheePost("drop_item", DataConvertUtils.convertItemStack(stack));

    public static placeBlock(block as LycheeBlock, offset as BlockPos = new BlockPos(0, 0, 0)) as LycheePost {
        return new LycheePost("place", {
            "block": block,
            "offsetX": offset.x,
            "offsetY": offset.y,
            "offsetZ": offset.z
        });
    }

    public static executeCommand(command as string, shouldHide as bool = false,shouldRepeat as bool = false) as LycheePost {
        return new LycheePost("execute", {
            "command": command,
            "hide": shouldHide,
            "repeat": shouldRepeat
        });
    }

    public static dropXp(xp as int) as LycheePost => new LycheePost("drop_xp", { "xp" : xp });

    public static random(entries as LycheePost[], min as int = 0, max as int = 1, emptyWeight as int = 0) as LycheePost {
        var entryList = new List<IData>();
        for entry in entries {
            entryList.add(entry as IData);
        }
        return new LycheePost("random", {
            "rolls": {
                "min": min,
                "max": max
            },
            "entries": new ListData(entryList),
            "empty_weight": emptyWeight
        });
    }

    public static preventDefault() as LycheePost => new LycheePost("prevent_default");

    public static damageItem(damage as int = 1) as LycheePost => new LycheePost("damage_item", { "damage" : damage });

    /*
        hurt method has been removed in 1.21.1. You need to use the /damage command instead.
        hurt方法在1.21.1中已经被删除，你需要使用/damage命令来代替
    */
    // public static hurt(bounds as DoubleBounds, source as string = "") as LycheePost {
    //     var map as MapData = {};
    //     map.put("damage",bounds);
    //     if (source != "") map.put("source",source);
    //     return new LycheePost("hurt",map);
    // }

    public static anvilDamageChance(chance as double) as LycheePost => new LycheePost("anvil_damage_chance", { "chance" : chance });

    /*
        blockInteraction can inputs "keep" | "destroy" | "destroy_with_decay" or LycheeEnum
        keep: Only particles, will not destroy blocks
        destroy: It will destroy the blocks, but keep them all(same as vanilla)
        destroy_with_decay: It will destroy the block, but only retain a portion (similar to the explosion in old versions)

        blockInteraction 可以输入 "keep" | "destroy" | "destroy_with_decay" 或者 LycheeEnum
        keep: 只有粒子效果，不会破坏方块
        destroy：破坏方块，但是全部保留（与原版相同）
        destroy_with_decay：破坏方块，但是只保留部分（与老版本相同）
    */
    public static explode(radius as int = 4, radiusStep as double = 0.5, offset as BlockPos = new BlockPos(0,0,0), blockInteraction as string = "destroy", onFire as bool = false) as LycheePost {
        return new LycheePost("explode", {
            "offsetX": offset.x,
            "offsetY": offset.y,
            "offsetZ": offset.z,
            "fire": onFire,
            "block_interaction": blockInteraction,
            "radius": radius,
            "radius_step": radiusStep
        });
    }

    public static lycheeIf(thenArray as LycheePost[],elseArray as LycheePost[]) as LycheePost {
        var thenList = new List<IData>();
        var elseList = new List<IData>();

        for thenPost in thenArray {
            thenList.add(thenPost as IData);
        }

        for elsePost in elseArray {
            elseList.add(elsePost as IData);
        }
        return new LycheePost("if",{
            "then": new ListData(thenList),
            "else": new ListData(elseList)
        });
    }

    public static delay(time as double) as LycheePost => new LycheePost("delay",{ "s" : time });

    public static addItemCoolDown(time as double) as LycheePost => new LycheePost("add_item_cooldown",{ "s" : time });

    public static exit() as LycheePost => new LycheePost("exit");

    public static moveTowardsFace(num as double = 1.0) as LycheePost => new LycheePost("move_towards_face", { "factor" : num});

    public static cycleStateProperty(block as LycheeBlock, property as string, offset as BlockPos = new BlockPos(0,0,0), reversed as bool = false) as LycheePost => new LycheePost("cycle_state_property", {
        "block": block,
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "property": property,
        "reversed": reversed
    });

    public static setItem(stack as IItemStack) as LycheePost => new LycheePost("set_item", DataConvertUtils.convertItemStack(stack));

    public static setBlock(block as LycheeBlock) as LycheePost => new LycheePost("set_block", { "block" : block });

    public static move(x as double, y as double, z as double) as LycheePost {
        var list as ListData = new ListData();
        list.add(x);
        list.add(y);
        list.add(z);
        return new LycheePost("move",{"offset":list});
    }

    public static custom(id as string,data as MapData = new MapData()) as LycheePost {
        var map as MapData = new MapData();
        map.put("id",id);
        if (!data.isEmpty()) map.put("data",data);
        return new LycheePost("custom",map);
    }

    /*
        Fragment methods are not available in ZenSpricts
    */
    // public static useFragment(replace as bool, id as string, data as MapData = new MapData()) as LycheePost {
    //     var type as string = "";
    //     if(replace) {
    //         type = "@|" + id;
    //     }
    //     else {
    //         type = "...@|" + id;
    //     }
    //     return new LycheePost(type,data,true);
    // }
}