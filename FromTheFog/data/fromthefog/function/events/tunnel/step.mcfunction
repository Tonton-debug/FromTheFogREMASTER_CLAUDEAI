fill ~ ~ ~ ~ ~1 ~ minecraft:air replace #fromthefog:tunnelable
scoreboard players remove #len ftf.tmp 1
execute if score #len ftf.tmp matches ..0 if block ~ ~ ~ minecraft:air unless block ~ ~-1 ~ #minecraft:air run setblock ~ ~ ~ minecraft:redstone_torch
execute if score #len ftf.tmp matches 1.. positioned ^ ^ ^1 run function fromthefog:events/tunnel/step
