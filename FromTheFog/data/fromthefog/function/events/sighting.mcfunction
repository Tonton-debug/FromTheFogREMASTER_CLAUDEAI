# Херобрин стоит вдалеке на поверхности и смотрит на игрока
execute unless score #sightings ftf.config matches 1 run return run function fromthefog:events/sounds
execute if entity @e[type=minecraft:mannequin,tag=ftf.herobrine] run return run function fromthefog:events/sounds
execute unless predicate fromthefog:can_see_sky run return run function fromthefog:events/behind

execute store result storage fromthefog:tmp o.yaw int 1 run random value -55..55
execute store result storage fromthefog:tmp o.dist int 1 run random value 28..48
data modify storage fromthefog:tmp o.fn set value "fromthefog:events/sighting_place"
function fromthefog:util/offset with storage fromthefog:tmp o
