execute positioned over motion_blocking_no_leaves unless loaded ~ ~ ~ run return fail
execute positioned over motion_blocking_no_leaves unless block ~ ~-1 ~ #fromthefog:ground unless block ~ ~-1 ~ #minecraft:logs run return fail
execute positioned over motion_blocking_no_leaves align xz positioned ~0.5 ~ ~0.5 run function fromthefog:herobrine/summon {mode:"watch",life:600}
