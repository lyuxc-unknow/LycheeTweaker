#priority 727
#modloaded lychee

import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.util.math.BlockPos;
import crafttweaker.api.util.Pair;
import stdlib.List;

public class LycheeCondition {
    private var data as MapData : get;
    
    public this(type as string, data as MapData) {
        this.data = ({"type": type} as MapData).merge(data);
    }

    /*
        如果 isSecret 为 true，则该条件不会出现在 JEI 中
    */
    public secret(isSecret as bool) as LycheeCondition {
        data.put("secret", isSecret);
        return this;
    }
    /*
        当您将鼠标悬停在 (i) 上时，会添加条件描述。
    */
    public description(desc as string) as LycheeCondition {
        data.put("description", desc);
        return this;
    }

    public asData() as IData => data;
    public implicit as IData => data;


    public |(other as LycheeCondition) as LycheeCondition {
        return LycheeConditions.or([this, other]);
    }

    public !() as LycheeCondition {
        return LycheeConditions.not(this);
    }

    public &(other as LycheeCondition) as LycheeCondition {
        return LycheeConditions.and([this, other]);
    }

    public ^(other as LycheeCondition) as LycheeCondition {
        return LycheeConditions.xor(this, other);
    }
}

/*
    Class containing static methods to easily create LycheeConditions. Recommended you use these instead of using the exposed constructors in LycheeCondition. 
    包含静态方法的类可轻松创建 LycheeConditions。建议您使用这些方法，而不是使用 LycheeCondition 中公开的构造函数。
*/
public class LycheeConditions {
    /*
        Logic conditions. not, and, and or are provided by Lychee, the rest are custom built off of those.
        逻辑条件。非、与、和或由 Lychee 提供，其余的都是根据这些条件定制的。
    */
    public static not(condition as LycheeCondition) as LycheeCondition => new LycheeCondition("not", {"contextual": condition as IData});

    public static and(conditions as LycheeCondition[]) as LycheeCondition {
        var conditionList = new stdlib.List<IData>();
        for condition in conditions {
            conditionList.add(condition as IData);
        }
        return new LycheeCondition("and", {"contextual": new ListData(conditionList)});
    }

    public static or(conditions as LycheeCondition[]) as LycheeCondition {
        var conditionList = new stdlib.List<IData>();
        for condition in conditions {
            conditionList.add(condition as IData);
        }
        return new LycheeCondition("or", {"contextual": new ListData(conditionList)});
    } 

    public static nand(conditions as LycheeCondition[]) as LycheeCondition => not(and(conditions));

    public static nor(conditions as LycheeCondition[]) as LycheeCondition => not(or(conditions));

    /*
        Recommended you hide xor and xnor in JEI, as they look very weird in the preview
        建议你在 JEI 中隐藏 xor 和 xnor，因为它们在预览中看起来非常奇怪
    */
    public static xor(condition1 as LycheeCondition, condition2 as LycheeCondition) as LycheeCondition => and([nand([condition1, condition2]), or([condition1, condition2])]);

    public static xnor(condition1 as LycheeCondition, condition2 as LycheeCondition) as LycheeCondition => not(xor(condition1, condition2));

    // True if the number of true inputs is odd.
    // 如果真实输入的数量为奇数，则为真。
    public static xor(conditions as LycheeCondition[]) as LycheeCondition {
        var out as LycheeCondition = xor(conditions[0], conditions[1]);
        if conditions.length < 3 return out;

        //Need to use indexes and stuff
        //需要使用索引和其他东西
        for i in 2 .. conditions.length {
            out = xor(out, conditions[2]);
        }

        return out;

    }
    public static xnor(conditions as LycheeCondition[]) as LycheeCondition => not(xor(conditions));

    /*
        Returns true if and only if ONE of the inputs is true.
        只有一个条件成立时,才会为true
    */
    public static onlyOne(conditions as LycheeCondition[]) as LycheeCondition {
        var orList = new List<LycheeCondition>();

        for condition in conditions {
            var nandList = new List<LycheeCondition>();
            for con in conditions {
                if !((con as IData) == (condition as IData)) nandList.add(con);
            }
            orList.add(and([condition, nand(nandList)]));
        }
        return or(orList);
    }

    /*
        Regular conditions here. Most are self explanatory
        此处为常规条件。大多数情况一目了然
    */
    public static chance(chance as double) as LycheeCondition => new LycheeCondition("chance", {"chance": chance});

    /*
        Not recommended, recommended to use the individual location predicate stuff below.
        不推荐，建议使用下面的单独位置谓词。
    */
    public static location(predicate as LycheeLocationPredicate, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": predicate
    });

    public static itemCooldown(item as IIngredient) as LycheeCondition => new LycheeCondition("is_off_item_cooldown",item as IData);

    public static weather(weather as string) as LycheeCondition => new LycheeCondition("weather", {"weather": weather});

    public static difficulty(difficulty as string) as LycheeCondition => new LycheeCondition("difficulty", {"difficulty": difficulty});
    
    public static difficulty(difficulty as int) as LycheeCondition => new LycheeCondition("difficulty", {"difficulty": difficulty});
    
    public static difficulty(difficulties as string[]) as LycheeCondition {
        var difficultyList = new stdlib.List<IData>();
        for difficulty in difficulties {
            difficultyList.add(difficulty);
        }
        return new LycheeCondition("difficulty", {"difficulty": new ListData(difficultyList)});
    }

    
    public static difficulty(difficulties as int[]) as LycheeCondition {
        // Have to add each value manually because java generics are weird
        // 由于 Java 泛型很奇怪，因此必须手动添加每个值
        var difficultyList = new List<int>();
        for difficulty in difficulties {
            difficultyList.add(difficulty);
        }
        return new LycheeCondition("difficulty", {"difficulty": new ListData(difficultyList)});
    }

    public static time(value as IntBounds, period as int) as LycheeCondition => new LycheeCondition("time", {
        "value": value,
        "period": period
    });

    public static command(command as string, value as IntBounds) as LycheeCondition => new LycheeCondition("execute", {
        "command": command,
        "value": value
    });
    
    public static fallDistance(distance as DoubleBounds) as LycheeCondition => new LycheeCondition("fall_distance", {
        "range": distance
    });

    public static entityHealth(health as DoubleBounds) as LycheeCondition => new LycheeCondition("entity_health", {
        "range": health
    });

    public static isSneaking() as LycheeCondition => new LycheeCondition("is_sneaking", {});

    // Allowed value for "direction": "up", "down", "north", "south", "east", "west", "side", "forward" or LycheeEnum
    // 允许输入的"方向"数值: "up", "down", "north", "south", "east", "west", "side", "forward"
    public static direction(dir as string) => new LycheeCondition("direction", {
        "direction": dir
    });

    public static lootParameter(key as string) => new LycheeCondition("check_param", {
        "key": key
    });

    public static skyDarkness(value as IntBounds,requireSkyLight as bool = false,canSeeSky as bool = false) => new LycheeCondition("sky_darken", {
        "value": value,
        "require_sky_light": requireSkyLight,
        "can_see_sky": canSeeSky
    });

    // =================================================== //
    // Custom conditions for easier Location Predicate use //
    //              自定义条件以便于使用位置谓词              //
    // =================================================== //

    public static biome(biome as string, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "biomes": biome
        }
    });

    public static dimension(dimension as string, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "dimension": dimension
        }
    });

    public static block(block as LycheeBlock, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "block": block
        }
    });

    /*
        It is recommended to use the block method to represent fluids, 
        because the use of fluids in Lychee does not handle localization correctly,
        and the corresponding fluid prompt code in Lychee is empty,
        which causes it to not display properly in the game. 
        If you use it, it is recommended to add comments with the LycheeRecipeBuilder#comment method
        
        建议使用block方法来表示流体，
        因为Lychee中使用流体未能正确处理本地化，
        且Lychee对应的流体提示代码为空导致游戏内无法正常显示，
        若使用建议配合 LycheeRecipeBuilder#comment 方法添加注释
        
        Doing stuff like <block:minecraft:water> is still valid!
        执行 <block:minecraft:water> 之类的操作仍然有效！
    */
    public static fluid(fluid as LycheeBlock, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "fluid": fluid
        }
    });
    /*
        It is recommended to use the block method to represent fluids, 
        because the use of fluids in Lychee does not handle localization correctly,
        and the corresponding fluid prompt code in Lychee is empty,
        which causes it to not display properly in the game. 
        If you use it, it is recommended to add comments with the LycheeRecipeBuilder#comment method
        
        建议使用block方法来表示流体，
        因为Lychee中使用流体未能正确处理本地化，
        且Lychee对应的流体提示代码为空导致游戏内无法正常显示，
        若使用建议配合 LycheeRecipeBuilder#comment 方法添加注释
    */
    public static fluid(fluid as LycheeFluid, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "fluid": fluid
        }
    });

    public static light(light as IntBounds, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "light": {
                "light":light
            }
        }
    });

    public static light(light as int, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "light": {
                "light":light
            }
        }
    });

    public static smokey(isSmokey as bool, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "smokey": isSmokey
        }
    });

    public static structure(structure as string, offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition => new LycheeCondition("location", {
        "offsetX": offset.x,
        "offsetY": offset.y,
        "offsetZ": offset.z,
        "predicate": {
            "structures": structure
        }
    });

    /*
        I know this has really weird syntax but this is the best way I could get this could work
        position is a map that looks something like this
        [
            "x": new IntBounds(min, max),
            "y": new IntBounds(min, max),
            "z": new IntBounds(min, max)
        ]
        You can omit x y or z but you must have one of these

        我知道这个语法很奇怪，但这是我能找到的最好的方法
        position 是一个类似这样的表
        [
            "x"：new IntBounds(min, max)，
            "y"：new IntBounds(min, max)，
            "z"：new IntBounds(min, max)
        ]
        您可以省略 x y 或 z，但必须有其中之一
    */
    public static position(position as IntBounds[string], offset as BlockPos = new BlockPos(0,0,0)) as LycheeCondition {
        var posMap as MapData = {};
        for k, v in position {
            posMap.put(k, v);
        }
        
        return new LycheeCondition("location", {
            "offsetX": offset.x,
            "offsetY": offset.y,
            "offsetZ": offset.z,
            "predicate": {
                "position": posMap
            }
        });
    }
}