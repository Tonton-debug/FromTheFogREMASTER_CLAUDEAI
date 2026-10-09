execute if entity @s[gamemode=creative] unless score #creative ftf.config matches 1 run return 0

# Новый игрок — сначала выдаём паузу
execute unless score @s ftf.cd matches -2147483648.. run return run function fromthefog:player/reset_cooldown

scoreboard players remove @s ftf.cd 1
execute if score @s ftf.cd matches 1.. run return 0

function fromthefog:player/reset_cooldown
function fromthefog:events/roll
