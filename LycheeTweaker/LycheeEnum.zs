#priority 1000
#modloaded lychee

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
    DESTROR_WITH_DECAY,

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
    FORWARD,
    
    // LycheeConditions#lootParameter
    THIS_ENTITY,
    LAST_DAMAGE_PLAYER,
    DAMAGE_SOURCE,
    ATTACKING_ENTITY,
    DIRECT_ATTACKING_ENTITY,
    ORIGIN,
    BLOCK_STATE,
    BLOCK_ENTITY,
    TOOL,
    EXPLOSION_RADIUS,
    ENCHANTMENT_LEVEL,
    ENCHANTMENT_ACTIVE;

    public value(v as LycheeEnum) as string {
        if (v == LycheeEnum.KEEP) return "keep";
        if (v == LycheeEnum.DESTROY) return "destroy";
        if (v == LycheeEnum.DESTROR_WITH_DECAY) return "destroy_with_decay";
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
        if (v == LycheeEnum.THIS_ENTITY) return "this_entity";
        if (v == LycheeEnum.LAST_DAMAGE_PLAYER) return "last_damage_player";
        if (v == LycheeEnum.DAMAGE_SOURCE) return "damage_source";
        if (v == LycheeEnum.ATTACKING_ENTITY) return "attacking_entity";
        if (v == LycheeEnum.DIRECT_ATTACKING_ENTITY) return "direct_attacking_entity";
        if (v == LycheeEnum.ORIGIN) return "origin";
        if (v == LycheeEnum.BLOCK_STATE) return "block_state";
        if (v == LycheeEnum.BLOCK_ENTITY) return "block_entity";
        if (v == LycheeEnum.TOOL) return "tool";
        if (v == LycheeEnum.EXPLOSION_RADIUS) return "explosion_radius";
        if (v == LycheeEnum.ENCHANTMENT_LEVEL) return "enchantment_level";
        if (v == LycheeEnum.ENCHANTMENT_ACTIVE) return "enchantment_active";
        return "";
    }

    public implicit as string => value(this);
}