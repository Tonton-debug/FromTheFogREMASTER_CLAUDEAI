# Вызов: function fromthefog:herobrine/summon {mode:"watch",life:400}
# Херобрин — это mannequin (26.x) со скином из ресурспака FromTheFog-Resources
$summon minecraft:mannequin ~ ~ ~ {Tags:["ftf.herobrine","ftf.new","ftf.mode.$(mode)"],profile:{texture:"fromthefog:entity/herobrine",model:"wide"},hide_description:1b,immovable:1b,Invulnerable:1b,Silent:1b,NoGravity:1b,CustomName:"Herobrine",CustomNameVisible:0b}
$scoreboard players set @e[type=minecraft:mannequin,tag=ftf.new] ftf.life $(life)
scoreboard players set @e[type=minecraft:mannequin,tag=ftf.new] ftf.look 0
execute as @e[type=minecraft:mannequin,tag=ftf.new] at @s run rotate @s facing entity @p eyes
tag @e[type=minecraft:mannequin,tag=ftf.new] remove ftf.new
