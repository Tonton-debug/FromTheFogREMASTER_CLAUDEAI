# Херобрин появляется за спиной игрока (работает и в пещерах)
execute unless score #sightings ftf.config matches 1 run return run function fromthefog:events/sounds
execute if entity @e[type=minecraft:mannequin,tag=ftf.herobrine] run return run function fromthefog:events/sounds

scoreboard players set #ok ftf.tmp 0
execute rotated ~180 0 positioned ^ ^ ^9 align xyz positioned ~0.5 ~ ~0.5 run function fromthefog:events/behind_try
execute if score #ok ftf.tmp matches 0 rotated ~180 0 positioned ^ ^ ^6 align xyz positioned ~0.5 ~ ~0.5 run function fromthefog:events/behind_try
execute if score #ok ftf.tmp matches 0 rotated ~150 0 positioned ^ ^ ^7 align xyz positioned ~0.5 ~ ~0.5 run function fromthefog:events/behind_try
execute if score #ok ftf.tmp matches 0 rotated ~210 0 positioned ^ ^ ^7 align xyz positioned ~0.5 ~ ~0.5 run function fromthefog:events/behind_try
execute if score #ok ftf.tmp matches 0 run function fromthefog:events/footsteps
