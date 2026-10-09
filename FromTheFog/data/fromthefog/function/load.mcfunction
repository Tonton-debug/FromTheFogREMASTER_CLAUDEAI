# From The Fog REMASTER — Minecraft 26.2
scoreboard objectives add ftf.data dummy
scoreboard objectives add ftf.config dummy
scoreboard objectives add ftf.tmp dummy
scoreboard objectives add ftf.cd dummy
scoreboard objectives add ftf.life dummy
scoreboard objectives add ftf.look dummy
scoreboard objectives add ftf.seq dummy
scoreboard objectives add ftf.seqt dummy

# Константы
scoreboard players set #2 ftf.data 2
scoreboard players set #8 ftf.data 8
scoreboard players set #16 ftf.data 16

execute unless score #installed ftf.data matches 1 run function fromthefog:install
