#priority 727
#modloaded lychee

import crafttweaker.api.fluid.Fluid;
import crafttweaker.api.block.BlockState;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.tag.manager.type.KnownTagManager;
import crafttweaker.api.tag.type.KnownTag;
import stdlib.List;
import crafttweaker.api.data.StringData;
import crafttweaker.api.fluid.IFluidStack;

/*
    Lychee Fluid wrap Lychee's format for representing Fluid. You can pass in a block, a blockstate.
    Lychee Fluid 封装了 Lychee 的流体可以表示格式，可以传入方块、方块状态。
*/
public class LycheeFluid {
    public var data as IData : get;

    public this(tag as KnownTag<Fluid>) {
        data = {"fluids": "#" + tag.id};
    }

    public this(fluidRegistryName as string[], state as LycheeBlockState? = null) {
        var blockList = new List<StringData>();
        for name in fluidRegistryName {
            blockList.add(new StringData(name));
        }
        var mapData as MapData = {"fluids": new ListData(blockList)};
        
        if(state != null) mapData.put("state", state as MapData);

        data = mapData as IData;
    }

    public this() {
        data = "*";
    }
    
    public asData() as IData => data;
    public implicit as IData => data;


}

public expand BlockState {
    public asLycheeFluidk() as LycheeFluid => new LycheeFluid([this.block.registryName.toString()], new LycheeBlockState(this));
    public implicit as LycheeFluid => new LycheeFluid([this.block.registryName.toString()], new LycheeBlockState(this));
}

public expand IFluidStack {
    public asLycheeFluidk() as LycheeFluid => new LycheeFluid([this.fluid.registryName.toString()]);
    public implicit as LycheeFluid => new LycheeFluid([this.fluid.registryName.toString()]);
}

public expand KnownTag<Fluid> {
    public asLycheeFluidk() as LycheeFluid => new LycheeFluid(this);
    public implicit as LycheeFluid => new LycheeFluid(this);
}