# Игрок поджёг незерак — ищем его лучом взгляда и проверяем алтарь
advancement revoke @s only fromthefog:shrine_light
scoreboard players set #ray ftf.tmp 0
execute at @s anchored eyes positioned ^ ^ ^ run function fromthefog:shrine/ray
