# Пропадают факелы неподалёку (там, куда игрок не смотрит)
execute unless score #griefing ftf.config matches 1 run return run function fromthefog:events/sounds
execute store result storage fromthefog:tmp o.yaw int 1 run random value 120..240
execute store result storage fromthefog:tmp o.dist int 1 run random value 12..18
data modify storage fromthefog:tmp o.fn set value "fromthefog:events/torches_remove"
function fromthefog:util/offset with storage fromthefog:tmp o
