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
    private var data as MapData;
    private var listdata as List<MapData>;

    public this() {
        this.listdata = new List<MapData>();
        this.data = {"predicate": new ListData(listdata)};
    }
    
    public this(data as MapData) {
        this.listdata = new List<MapData>();
        this.data = data;
    }

    public offset(offset as BlockPos) as LycheeLocationPredicate {
        data.put("offsetX", offset.x);
        data.put("offsetY", offset.y);
        data.put("offsetZ", offset.z);
        return this;
    }

    public biome(biome as string) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("biome", biome as IData);
        this.listdata.add(data);
        return this;
    }

    public dimension(dimension as string) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("dimension", dimension);
        this.listdata.add(data);
        return this;
    }

    public block(block as LycheeBlock) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("block", block);
        this.listdata.add(data);
        return this;
    }

    public fluid(fluid as LycheeBlock) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("fluid", fluid);
        this.listdata.add(data);
        return this;
    }

    public light(light as IntBounds) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("light", light);
        this.listdata.add(data);
        return this;
    }

    public smokey(isSmokey as bool) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("smokey", isSmokey);
        this.listdata.add(data);
        return this;
    }

    public structure(structure as string) as LycheeLocationPredicate {
        var data1 = new MapData();
        data1.put("structure", structure);
        this.listdata.add(data);
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
        var data1 = new MapData();
        data1.put("position", posMap);
        this.listdata.add(data1);
        return this;
    }
    
    public build() as MapData {
        return {"predicate": new ListData(listdata)};
    }

    public asData() as IData {
        return {};
    }
    public implicit as IData => asData();
}