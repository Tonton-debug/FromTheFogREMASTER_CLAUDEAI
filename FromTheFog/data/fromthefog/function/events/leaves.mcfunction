# Листья на деревьях неподалёку исчезают (только естественные)
execute unless score #griefing ftf.config matches 1 run return run function fromthefog:events/sounds
execute unless predicate fromthefog:can_see_sky run return run function fromthefog:events/torches
execute store result storage fromthefog:tmp o.yaw int 1 run random value 90..270
execute store result storage fromthefog:tmp o.dist int 1 run random value 16..28
data modify storage fromthefog:tmp o.fn set value "fromthefog:events/leaves_strip"
function fromthefog:util/offset with storage fromthefog:tmp o
