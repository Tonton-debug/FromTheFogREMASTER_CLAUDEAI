# Херобрин живёт своей жизнью, даже если мод выключен (чтобы корректно исчезнуть)
execute as @e[type=minecraft:mannequin,tag=ftf.herobrine] at @s run function fromthefog:herobrine/tick

# Звуковые последовательности (шаги, копание)
execute as @a[scores={ftf.seq=1..}] at @s run function fromthefog:player/seq_tick

# Счётчик игровых дней с момента установки
scoreboard players add #ticks ftf.data 1
execute if score #ticks ftf.data matches 24000.. run function fromthefog:clock/new_day

scoreboard players add #sec ftf.data 1
execute if score #sec ftf.data matches 20.. run function fromthefog:clock/second
