#priority 727
#modloaded lychee

import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;
import crafttweaker.api.util.math.BlockPos;
import stdlib.List;

/*
    Vanilla syntax for Location Predicate, may migrate to not be specific to lychee in the future.
    Reference the Minecraft wiki for more specific info. https://zh.minecraft.wiki/w/Predicate
    原版语法的位置谓词将来可能会迁移到不再特定于Lychee。
    有关更多具体信息，请参阅 Minecraft wiki。https://zh.minecraft.wiki/w/Predicate
*/
public class LycheeLocationPredicate {
    private var data as MapData = new MapData;

    public this() {

    }
    
    public this(data as MapData) {
        this.data = data;
    }

    public biome(biome as string) as LycheeLocationPredicate {
        data.put("biomes", biome);
        return this;
    }

    public biome(biomes as string[]) as LycheeLocationPredicate {
        var biomeList = new List<IData>();
        for biome in biomes { 
            biomeList.add(biome);
        }
        data.put("biomes",new ListData(biomeList));
        return this;
    }

    public dimension(dimension as string) as LycheeLocationPredicate {
        data.put("dimension",dimension as IData);
        return this;
    }

    public block(block as LycheeBlock) as LycheeLocationPredicate {
        data.put("block",block as IData);
        return this;
    }
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
    public fluid(fluid as LycheeFluid) as LycheeLocationPredicate {
        data.put("fluid",fluid as IData);
        return this;
    }

    public light(light as IntBounds) as LycheeLocationPredicate {
        data.put("light",{"light":light as IData});
        return this;
    }

    public light(light as int) as LycheeLocationPredicate {
        data.put("light",{"light":light});
        return this;
    }

    public smokey(isSmokey as bool) as LycheeLocationPredicate {
        data.put("smokey",isSmokey as IData);
        return this;
    }

    public canSeeSky(canSeeSky as bool) as LycheeLocationPredicate {
        data.put("can_see_sky", canSeeSky as IData);
        return this;
    }

    public structure(structure as string) as LycheeLocationPredicate {
        data.put("structures",structure as IData);
        return this;
    }

    public structure(structures as string[]) as LycheeLocationPredicate {
        var structureList = new List<IData>();
        for structure in structures {
            structureList.add(structure as IData);
        }
        data.put("structures",new ListData(structureList));
        return this;
    }
    /*
        I know this has really weird syntax but this is the best way I could get this could work
        position is a map that looks something like this
        [
            "x": new IntBounds(min, max),
            "y": new IntBounds(min, max),
            "z": new IntBounds(min, max)
        ]
        You can omit x y or z but you must have one of those

        我知道这个语法很奇怪，但这是我能找到的最好的方法
        position 是一个类似这样的表
        [
            "x"：new IntBounds(min, max)，
            "y"：new IntBounds(min, max)，
            "z"：new IntBounds(min, max)
        ]
        您可以省略 x y 或 z，但必须有其中之一
    */
    public position(position as IntBounds[string]) as LycheeLocationPredicate {
        var posMap as MapData = {};
        for k, v in position {
            posMap.put(k, v);
        }
        data.put("position",posMap as IData);
        return this;
    }

    public asData() as IData {
        return data;
    }
    public implicit as IData => asData();
}