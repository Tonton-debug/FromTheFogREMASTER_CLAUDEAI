execute store result storage fromthefog:tmp cd.min int 1 run scoreboard players get #min_cd ftf.config
execute store result storage fromthefog:tmp cd.max int 1 run scoreboard players get #max_cd ftf.config
function fromthefog:player/roll_cooldown with storage fromthefog:tmp cd
# После разжигания алтаря Херобрин появляется вдвое чаще
execute if score #awake ftf.data matches 1 run scoreboard players operation @s ftf.cd /= #2 ftf.data
execute if score @s ftf.cd matches ..0 run scoreboard players set @s ftf.cd 1
