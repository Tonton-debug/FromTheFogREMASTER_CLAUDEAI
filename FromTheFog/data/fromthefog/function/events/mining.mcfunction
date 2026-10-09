# Кто-то копает за стеной
execute unless score #sounds ftf.config matches 1 run return 0
execute if score @s ftf.seq matches 1.. run return 0
tag @s add ftf.seq.mine
execute store result score @s ftf.seq run random value 5..9
scoreboard players set @s ftf.seqt 0
