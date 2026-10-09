scoreboard players remove @s ftf.life 1
execute if score @s ftf.life matches ..0 run return run function fromthefog:herobrine/vanish
execute unless entity @p[distance=..160,gamemode=!spectator] run return run function fromthefog:herobrine/vanish

# Всегда смотрит на ближайшего игрока
rotate @s facing entity @p[gamemode=!spectator] eyes

# Смотрит ли на него кто-то из игроков (конус ~15°)
scoreboard players set #looked ftf.tmp 0
tag @s add ftf.self
execute as @a[distance=..160,gamemode=!spectator] at @s anchored eyes facing entity @e[type=minecraft:mannequin,tag=ftf.self,limit=1] eyes anchored feet positioned ^ ^ ^1 rotated as @s positioned ^ ^ ^-1 if entity @s[distance=..0.26] run scoreboard players set #looked ftf.tmp 1
tag @s remove ftf.self
execute if score #looked ftf.tmp matches 1 run scoreboard players add @s ftf.look 1

execute if entity @s[tag=ftf.mode.watch] run return run function fromthefog:herobrine/mode/watch
execute if entity @s[tag=ftf.mode.behind] run return run function fromthefog:herobrine/mode/behind
execute if entity @s[tag=ftf.mode.stalk] run return run function fromthefog:herobrine/mode/stalk
execute if entity @s[tag=ftf.mode.flash] run return run function fromthefog:herobrine/mode/flash
