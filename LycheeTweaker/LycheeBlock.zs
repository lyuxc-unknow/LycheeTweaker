#priority 727
#modloaded lychee

import crafttweaker.api.block.Block;
import crafttweaker.api.block.BlockState;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.tag.manager.type.KnownTagManager;
import crafttweaker.api.tag.type.KnownTag;
import stdlib.List;
import crafttweaker.api.data.StringData;

/*
    Lychee Blocks wrap Lychee's format for representing Blocks. You can pass in a block, a blockstate, and nbt.
    Lychee Blocks 封装了 Lychee 的方块可以表示格式，可以传入方块、方块状态和 nbt。
*/
public class LycheeBlock {
    public var data as IData : get;

    public this(tag as KnownTag<Block>) {
        data = "#" + tag.id;
    }

    public this(blocks as Block[], state as LycheeBlockState? = null, nbt as MapData? = null) {
        var blockList = new List<StringData>();
        for block in blocks {
            blockList.add(new StringData(block.registryName));
        }
        var mapData as MapData = {"blocks": new ListData(blockList)};
        if(nbt != null) mapData.put("nbt", nbt);
        if(state != null) mapData.put("state", state.data);

        data = mapData as IData;
    }

    public this() {
        data = "*";
    }
    
    public asData() as IData => data;
    public implicit as IData => data;


}

/*
    Horrible implementation but whatever. Wraps blockstates, so all you gotta pass in is a BlockState. Also adds support for ranged state values.
    实现得很糟糕，但没关系。包装块状态，所以你只需要传入一个块状态。还添加了对范围状态值的支持。
*/
public class LycheeBlockState {
    private var data as MapData : get;

    public this(state as BlockState) {
        data = {};
        for k, v in state.properties {
            data.put(k, v);
        }
    }
    public this(data as MapData) {
        this.data = data;
    }

    public implicit as MapData => data;

    public addRangedState(key as string, min as int, max as int) as LycheeBlockState {
        data.put(key, {"min": min, "max": max});
        return this;
    }

}

public expand BlockState {
    public asLycheeBlock() as LycheeBlock => new LycheeBlock([this.block], new LycheeBlockState(this));
    public implicit as LycheeBlock => new LycheeBlock([this.block], new LycheeBlockState(this));
}

public expand Block {
    public asLycheeBlock() as LycheeBlock => new LycheeBlock([this]);
    public implicit as LycheeBlock => new LycheeBlock([this]);
}

public expand KnownTag<Block> {
    public asLycheeBlock() as LycheeBlock => new LycheeBlock(this);
    public implicit as LycheeBlock => new LycheeBlock(this);
}