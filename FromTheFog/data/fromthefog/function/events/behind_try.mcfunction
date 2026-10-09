# Нужны: 2 блока воздуха и твёрдый пол
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ #minecraft:replaceable run return fail
execute unless block ~ ~1 ~ #minecraft:air run return fail
execute if block ~ ~-1 ~ #minecraft:air run return fail
execute if block ~ ~-1 ~ #minecraft:replaceable run return fail
scoreboard players set #ok ftf.tmp 1
function fromthefog:herobrine/summon {mode:"behind",life:300}
