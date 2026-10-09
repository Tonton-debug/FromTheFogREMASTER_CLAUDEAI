# Сообщения в чате
execute unless score #chat ftf.config matches 1 run return run function fromthefog:events/sounds
execute store result score #c ftf.tmp run random value 1..9
execute if score #c ftf.tmp matches 1 run return run function fromthefog:events/fake_join
execute if score #c ftf.tmp matches 2 run return run tellraw @s "<Herobrine> Я вижу тебя."
execute if score #c ftf.tmp matches 3 run return run tellraw @s "<Herobrine> Ты здесь не один."
execute if score #c ftf.tmp matches 4 run return run tellraw @s "<Herobrine> ..."
execute if score #c ftf.tmp matches 5 run return run tellraw @s "<Herobrine> Почему ты всё ещё здесь?"
execute if score #c ftf.tmp matches 6 run return run tellraw @s "<Herobrine> Обернись."
execute if score #c ftf.tmp matches 7 run return run tellraw @s "<Herobrine> Уходи."
execute if score #c ftf.tmp matches 8 run return run tellraw @s {text:"<Herobrine> ",extra:[{text:"aaaaaaaaaa",obfuscated:true}]}
function fromthefog:events/fake_join
