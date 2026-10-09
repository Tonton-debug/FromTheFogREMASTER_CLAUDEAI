# Жуткие звуки рядом с игроком
execute unless score #sounds ftf.config matches 1 run return 0
execute store result score #s ftf.tmp run random value 1..8
execute if score #s ftf.tmp matches 1 run return run playsound minecraft:ambient.cave ambient @s ~ ~ ~ 1 0.8
execute if score #s ftf.tmp matches 2 run return run function fromthefog:events/sound_door
execute if score #s ftf.tmp matches 3 run return run playsound minecraft:block.chest.open block @s ^-4 ^ ^-6 0.7 0.8
execute if score #s ftf.tmp matches 4 run return run playsound minecraft:entity.player.breath player @s ^ ^1 ^-1.5 0.5 0.7
execute if score #s ftf.tmp matches 5 run return run function fromthefog:events/mining
execute if score #s ftf.tmp matches 6 run return run playsound minecraft:ambient.soul_sand_valley.mood ambient @s ~ ~ ~ 1 0.7
execute if score #s ftf.tmp matches 7 run return run playsound minecraft:block.stone_button.click_on block @s ^2 ^ ^-5 0.6 0.6
function fromthefog:events/footsteps
