# Стоит за спиной. Стоит обернуться — исчезает
execute if score @s ftf.look matches 3.. run return run function fromthefog:herobrine/vanish_loud
execute if entity @a[distance=..3,gamemode=!spectator] run return run function fromthefog:herobrine/vanish_loud
