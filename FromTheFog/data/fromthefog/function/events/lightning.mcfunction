# Вспышка молнии вдалеке — и силуэт Херобрина в ней
execute unless score #sightings ftf.config matches 1 run return run function fromthefog:events/sounds
execute if entity @e[type=minecraft:mannequin,tag=ftf.herobrine] run return run function fromthefog:events/sounds
execute unless predicate fromthefog:can_see_sky run return run function fromthefog:events/sounds

execute store result storage fromthefog:tmp o.yaw int 1 run random value -35..35
execute store result storage fromthefog:tmp o.dist int 1 run random value 35..55
data modify storage fromthefog:tmp o.fn set value "fromthefog:events/lightning_place"
function fromthefog:util/offset with storage fromthefog:tmp o
