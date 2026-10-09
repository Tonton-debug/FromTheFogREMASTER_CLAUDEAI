# Редкий скример (только ночью)
execute unless score #jumpscares ftf.config matches 1 run return run function fromthefog:events/sounds
execute unless score #night ftf.data matches 1 run return run function fromthefog:events/footsteps
execute if entity @e[type=minecraft:mannequin,tag=ftf.herobrine] run return run function fromthefog:events/sounds

effect give @s minecraft:darkness 4 0 true
effect give @s minecraft:slowness 2 3 true
playsound minecraft:entity.elder_guardian.curse hostile @s ~ ~ ~ 0.8 0.5
playsound minecraft:ambient.cave hostile @s ~ ~ ~ 1 0.5
execute rotated ~ 0 positioned ^ ^ ^1.6 run function fromthefog:herobrine/summon {mode:"flash",life:14}
