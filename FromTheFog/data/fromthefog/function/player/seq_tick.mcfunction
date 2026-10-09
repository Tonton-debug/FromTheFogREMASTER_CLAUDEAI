# Тиканье звуковой последовательности игрока
scoreboard players add @s ftf.seqt 1
execute if entity @s[tag=ftf.seq.steps] unless score @s ftf.seqt matches 7.. run return 0
execute if entity @s[tag=ftf.seq.mine] unless score @s ftf.seqt matches 12.. run return 0
scoreboard players set @s ftf.seqt 0
scoreboard players remove @s ftf.seq 1

execute if entity @s[tag=ftf.seq.steps] rotated ~ 0 positioned ^ ^ ^-5 run function fromthefog:player/step_sound
execute if entity @s[tag=ftf.seq.mine] if score @s ftf.seq matches 1.. run playsound minecraft:block.stone.hit block @s ^3 ^ ^-6 0.8 0.8
execute if entity @s[tag=ftf.seq.mine] if score @s ftf.seq matches 0 run playsound minecraft:block.stone.break block @s ^3 ^ ^-6 0.9 0.8

execute if score @s ftf.seq matches ..0 run function fromthefog:player/seq_end
