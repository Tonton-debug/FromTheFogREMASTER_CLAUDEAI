execute as @e[type=minecraft:mannequin,tag=ftf.herobrine] at @s run function fromthefog:herobrine/vanish
tag @a remove ftf.seq.steps
tag @a remove ftf.seq.mine
tag @a remove ftf.door
tag @a remove ftf.leave
advancement revoke @a only fromthefog:shrine_light
scoreboard objectives remove ftf.data
scoreboard objectives remove ftf.config
scoreboard objectives remove ftf.tmp
scoreboard objectives remove ftf.cd
scoreboard objectives remove ftf.life
scoreboard objectives remove ftf.look
scoreboard objectives remove ftf.seq
scoreboard objectives remove ftf.seqt
data remove storage fromthefog:tmp o
data remove storage fromthefog:tmp s
data remove storage fromthefog:tmp t
data remove storage fromthefog:tmp cd
data remove storage fromthefog:tmp sign
schedule clear fromthefog:events/sound_door_close
schedule clear fromthefog:events/fake_leave
tellraw @a {text:"[From The Fog] Данные удалены. Теперь выполните /datapack disable \"file/FromTheFog-26.2.zip\" (или удалите папку датапака).",color:"gray"}
