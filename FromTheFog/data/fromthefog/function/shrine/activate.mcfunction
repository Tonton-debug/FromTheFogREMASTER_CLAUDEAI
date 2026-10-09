execute unless score #enabled ftf.config matches 1 run return fail
scoreboard players set #awake ftf.data 1

playsound minecraft:entity.lightning_bolt.thunder weather @a[distance=..128] ~ ~ ~ 3 0.6
playsound minecraft:entity.wither.spawn hostile @a[distance=..48] ~ ~ ~ 0.5 0.5
particle minecraft:large_smoke ~ ~1 ~ 0.6 1.5 0.6 0.02 80 normal
particle minecraft:soul ~ ~1 ~ 0.8 1 0.8 0.02 30 normal
effect give @a[distance=..32] minecraft:darkness 6 0 true
weather thunder 6000
tellraw @a[distance=..64] {text:"Ты призвал его.",color:"dark_red",italic:true}

# Сокращаем паузу у ближайших игроков — он придёт скоро
execute as @a[distance=..64] run scoreboard players set @s ftf.cd 20

# Херобрин на миг появляется у алтаря
execute unless entity @e[type=minecraft:mannequin,tag=ftf.herobrine] rotated as @p positioned ^ ^ ^-4 positioned over motion_blocking_no_leaves run function fromthefog:herobrine/summon {mode:"flash",life:40}
