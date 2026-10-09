execute positioned over motion_blocking_no_leaves unless loaded ~ ~ ~ run return fail
playsound minecraft:entity.lightning_bolt.thunder weather @a[distance=..96] ~ ~ ~ 2 0.8
# Безопасная «вспышка»: короткое ночное зрение вместо настоящей молнии (без пожаров)
effect give @a[distance=..96] minecraft:night_vision 1 0 true
particle minecraft:end_rod ~ ~12 ~ 0.2 6 0.2 0.05 60 force
execute positioned over motion_blocking_no_leaves align xz positioned ~0.5 ~ ~0.5 run function fromthefog:herobrine/summon {mode:"flash",life:30}
