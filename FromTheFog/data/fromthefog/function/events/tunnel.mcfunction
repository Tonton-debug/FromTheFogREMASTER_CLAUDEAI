# Таинственный туннель 1x2 под землёй
execute unless score #griefing ftf.config matches 1 run return run function fromthefog:events/sounds
execute if predicate fromthefog:can_see_sky run return run function fromthefog:events/structure
execute unless entity @s[y=-64,dy=110] run return run function fromthefog:events/mining

execute store result score #k ftf.tmp run random value 0..3
scoreboard players set #90 ftf.tmp 90
scoreboard players operation #k ftf.tmp *= #90 ftf.tmp
execute store result storage fromthefog:tmp t.yaw int 1 run scoreboard players get #k ftf.tmp
execute store result score #len ftf.tmp run random value 14..26
scoreboard players operation #half ftf.tmp = #len ftf.tmp
scoreboard players operation #half ftf.tmp /= #2 ftf.data
execute store result storage fromthefog:tmp t.half int 1 run scoreboard players get #half ftf.tmp
function fromthefog:events/tunnel/start with storage fromthefog:tmp t
function fromthefog:events/mining
