scoreboard players set #ticks ftf.data 0
scoreboard players add #days ftf.data 1
execute if score #enabled ftf.config matches 1 if score #days ftf.data = #start_day ftf.config as @a at @s run playsound minecraft:ambient.cave ambient @s ~ ~ ~ 1 0.5
