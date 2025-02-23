public enum LycheeEnum {
    /*
        keep: Only particles, will not destroy blocks
        destroy: It will destroy the blocks, but keep them all(same as vanilla)
        destroy_with_decay: It will destroy the block, but only retain a portion (similar to the explosion in old versions)

        keep: 只有粒子效果，不会破坏方块
        destroy：破坏方块，但是全部保留（与原版相同）
        destroy_with_decay：破坏方块，但是只保留部分（与老版本相同）
    */
    // LycheePosts#explode
    KEEP,
    DESTROY,
    DESTRORWITHDECAY,

    // LycheeConditions#weather
    CLEAR,
    RAIN,
    THUNDER,

    // LycheeConditions#difficulty
    PEACEFUL,
    EASY,
    NORMAL,
    HARD,

    // LycheeConditions#direction
    UP,
    DOWN,
    NORTH,
    SOUTH,
    EAST,
    WEST,
    SIDE,
    FORWARD;

    public value(v as LycheeEnum) as string {
        if (v == LycheeEnum.KEEP) return "keep";
        if (v == LycheeEnum.DESTROY) return "destroy";
        if (v == LycheeEnum.DESTRORWITHDECAY) return "destroy_with_decay";
        if (v == LycheeEnum.CLEAR) return "clear";
        if (v == LycheeEnum.RAIN) return "rain";
        if (v == LycheeEnum.THUNDER) return "thunder";
        if (v == LycheeEnum.PEACEFUL) return "peaceful";
        if (v == LycheeEnum.UP) return "up";
        if (v == LycheeEnum.DOWN) return "down";
        if (v == LycheeEnum.NORTH) return "north";
        if (v == LycheeEnum.SOUTH) return "south";
        if (v == LycheeEnum.EAST) return "east";
        if (v == LycheeEnum.WEST) return "west";
        if (v == LycheeEnum.SIDE) return "side";
        if (v == LycheeEnum.FORWARD) return "forward";
        return "";
    }

    public implicit as string => value(this);
}