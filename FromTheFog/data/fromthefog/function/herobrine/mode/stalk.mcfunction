# Ночное преследование в тумане: каждые 2 секунды подходит ближе
execute if score @s ftf.look matches 60.. run return run function fromthefog:herobrine/vanish_loud
execute if entity @a[distance=..6,gamemode=!spectator] run return run function fromthefog:herobrine/vanish_loud

scoreboard players operation #m ftf.tmp = @s ftf.life
scoreboard players operation #m ftf.tmp %= #16 ftf.data
execute if score #m ftf.tmp matches 0 run playsound minecraft:entity.warden.heartbeat hostile @a[distance=..32] ~ ~ ~ 0.7 0.6
execute if score #m ftf.tmp matches 0 if score #looked ftf.tmp matches 0 at @s positioned ^ ^ ^3 positioned over motion_blocking_no_leaves run tp @s ~ ~ ~
