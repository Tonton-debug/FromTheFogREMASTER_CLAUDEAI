$scoreboard players $(op) #$(key) ftf.config $(v)
# Ограничения
execute if score #start_day ftf.config matches ..-1 run scoreboard players set #start_day ftf.config 0
execute if score #min_cd ftf.config matches ..14 run scoreboard players set #min_cd ftf.config 15
execute if score #max_cd ftf.config < #min_cd ftf.config run scoreboard players operation #max_cd ftf.config = #min_cd ftf.config
function fromthefog:config/menu
