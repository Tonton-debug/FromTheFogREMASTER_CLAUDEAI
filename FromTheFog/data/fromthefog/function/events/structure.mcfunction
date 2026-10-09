# Странная постройка где-то позади игрока
execute unless score #structures ftf.config matches 1 run return run function fromthefog:events/sounds
execute unless predicate fromthefog:can_see_sky run return run function fromthefog:events/sounds

execute store result score #k ftf.tmp run random value 0..7
# Направление от игрока (8 румбов по 45°) и поворот таблички «лицом» к игроку
scoreboard players set #45 ftf.tmp 45
scoreboard players operation #yaw ftf.tmp = #k ftf.tmp
scoreboard players operation #yaw ftf.tmp *= #45 ftf.tmp
scoreboard players operation #rot ftf.tmp = #k ftf.tmp
scoreboard players operation #rot ftf.tmp *= #2 ftf.data
scoreboard players add #rot ftf.tmp 8
scoreboard players operation #rot ftf.tmp %= #16 ftf.data
execute store result storage fromthefog:tmp s.yaw int 1 run scoreboard players get #yaw ftf.tmp
execute store result storage fromthefog:tmp s.dist int 1 run random value 24..40
data modify storage fromthefog:tmp s.fn set value "fromthefog:structures/place"
function fromthefog:util/offset_abs with storage fromthefog:tmp s
