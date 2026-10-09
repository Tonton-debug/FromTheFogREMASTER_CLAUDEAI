scoreboard players set #sec ftf.data 0
execute unless score #enabled ftf.config matches 1 run return 0

# Время суток (26.1+: /time работает через часы мира)
execute store result score #tod ftf.data run time of minecraft:overworld query minecraft:day
scoreboard players set #night ftf.data 0
execute if score #tod ftf.data matches 13000..23000 run scoreboard players set #night ftf.data 1

# Херобрин активен после N дней или после разжигания алтаря
scoreboard players set #active ftf.data 0
execute if score #days ftf.data >= #start_day ftf.config run scoreboard players set #active ftf.data 1
execute if score #awake ftf.data matches 1 run scoreboard players set #active ftf.data 1
execute if score #active ftf.data matches 0 run return 0

execute as @a[gamemode=!spectator] at @s if dimension minecraft:overworld run function fromthefog:player/second
