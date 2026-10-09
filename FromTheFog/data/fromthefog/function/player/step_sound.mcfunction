# Шаг за спиной — звук зависит от блока под ногами
execute if block ~ ~-1 ~ #minecraft:substrate_overworld run return run playsound minecraft:block.grass.step player @a[distance=..8] ~ ~ ~ 0.6 0.9
execute if block ~ ~-1 ~ #minecraft:sand run return run playsound minecraft:block.sand.step player @a[distance=..8] ~ ~ ~ 0.6 0.9
execute if block ~ ~-1 ~ minecraft:gravel run return run playsound minecraft:block.gravel.step player @a[distance=..8] ~ ~ ~ 0.6 0.9
execute if block ~ ~-1 ~ #minecraft:planks run return run playsound minecraft:block.wood.step player @a[distance=..8] ~ ~ ~ 0.6 0.9
playsound minecraft:block.stone.step player @a[distance=..8] ~ ~ ~ 0.6 0.9
