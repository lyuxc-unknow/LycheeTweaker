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
    Reference the Minecraft wiki for more specific info. https://minecraft.fandom.com/wiki/Predicate
    位置谓词的原版语法将来可能会迁移到不再特定于荔枝。
    有关更多具体信息，请参阅 Minecraft wiki。https://minecraft.fandom.com/wiki/Predicate
*/
public class LycheeLocationPredicate {
    private var data as MapData = new MapData;

    public this() {

    }
    
    public this(data as MapData) {
        this.data = data;
    }

    // Network package recipe encoding failures that may trigger Lychee
    // 可能会触发Lychee的网络包配方编码失败
    public biome(biome as string) as LycheeLocationPredicate {
        data.put("biomes",biome as IData);
        return this;
    }

    // Network package recipe encoding failures that may trigger Lychee
    // 可能会触发Lychee的网络包配方编码失败
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

    // Network package recipe encoding failures that may trigger Lychee
    // 可能会触发Lychee的网络包配方编码失败
    public block(block as LycheeBlock) as LycheeLocationPredicate {
        data.put("block",block as IData);
        return this;
    }

    // Network package recipe encoding failures that may trigger Lychee
    // 可能会触发Lychee的网络包配方编码失败
    public fluid(fluid as LycheeBlock) as LycheeLocationPredicate {
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

    // Network package recipe encoding failures that may trigger Lychee
    // 可能会触发Lychee的网络包配方编码失败
    public structure(structure as string) as LycheeLocationPredicate {
        data.put("structures",structure as IData);
        return this;
    }

    // Network package recipe encoding failures that may trigger Lychee
    // 可能会触发Lychee的网络包配方编码失败
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