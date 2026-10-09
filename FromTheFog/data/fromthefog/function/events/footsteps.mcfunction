# Шаги за спиной
execute unless score #sounds ftf.config matches 1 run return 0
execute if score @s ftf.seq matches 1.. run return 0
tag @s add ftf.seq.steps
execute store result score @s ftf.seq run random value 4..8
scoreboard players set @s ftf.seqt 0
