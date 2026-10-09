execute if block ~ ~ ~ minecraft:netherrack align xyz positioned ~0.5 ~ ~0.5 run return run function fromthefog:shrine/validate
scoreboard players add #ray ftf.tmp 1
execute if score #ray ftf.tmp matches ..70 positioned ^ ^ ^0.1 run function fromthefog:shrine/ray
