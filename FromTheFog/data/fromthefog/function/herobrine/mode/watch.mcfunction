# Стоит вдалеке и смотрит. Исчезает, если подойти или долго смотреть на него
execute if score @s ftf.look matches 40.. run return run function fromthefog:herobrine/vanish
execute if entity @a[distance=..20,gamemode=!spectator] run return run function fromthefog:herobrine/vanish
