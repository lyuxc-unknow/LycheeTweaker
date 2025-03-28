#priority 1000

import crafttweaker.api.data.IData;

/*
    Mostly used for Lychee recipes, represents a min and max value. Can be implicitly cast to IData
    主要用于 Lychee 配方，表示最小值和最大值。可以隐式转换为 IData
*/
public class IntBounds {
    public var min as int : get;
    public var max as int : get;

    public this(min as int, max as int) {
        this.min = min;
        this.max = max;
    }

    public asData() as IData {
        return {"min": min, "max": max};
    }
    public implicit as IData => asData();
}

public class DoubleBounds {
    public var min as double : get;
    public var max as double : get;

    public this(min as double, max as double) {
        this.min = min;
        this.max = max;
    }

    public asData() as IData {
        return {"min": min, "max": max};
    }
    public implicit as IData => asData();
}