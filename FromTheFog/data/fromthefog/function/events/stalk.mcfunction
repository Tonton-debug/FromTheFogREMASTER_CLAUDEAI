# Ночью в тумане: медленно приближается
execute unless score #sightings ftf.config matches 1 run return run function fromthefog:events/sounds
execute unless score #night ftf.data matches 1 run return run function fromthefog:events/sighting
execute if entity @e[type=minecraft:mannequin,tag=ftf.herobrine] run return run function fromthefog:events/sounds
execute unless predicate fromthefog:can_see_sky run return run function fromthefog:events/behind

effect give @s minecraft:darkness 30 0 true
playsound minecraft:ambient.cave ambient @s ~ ~ ~ 1 0.6
execute store result storage fromthefog:tmp o.yaw int 1 run random value -40..40
execute store result storage fromthefog:tmp o.dist int 1 run random value 22..28
data modify storage fromthefog:tmp o.fn set value "fromthefog:events/stalk_place"
function fromthefog:util/offset with storage fromthefog:tmp o
