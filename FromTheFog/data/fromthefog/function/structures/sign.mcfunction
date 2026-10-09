# Табличка с посланием, повёрнутая к игроку
execute store result storage fromthefog:tmp sign.rot int 1 run scoreboard players get #rot ftf.tmp
execute store result score #m ftf.tmp run random value 1..6
execute if score #m ftf.tmp matches 1 run data modify storage fromthefog:tmp sign.msg set value "Я ВИЖУ ТЕБЯ"
execute if score #m ftf.tmp matches 2 run data modify storage fromthefog:tmp sign.msg set value "УХОДИ"
execute if score #m ftf.tmp matches 3 run data modify storage fromthefog:tmp sign.msg set value "ТЫ НЕ ОДИН"
execute if score #m ftf.tmp matches 4 run data modify storage fromthefog:tmp sign.msg set value "ОБЕРНИСЬ"
execute if score #m ftf.tmp matches 5 run data modify storage fromthefog:tmp sign.msg set value "СЛИШКОМ ПОЗДНО"
execute if score #m ftf.tmp matches 6 run data modify storage fromthefog:tmp sign.msg set value "ОН ЗДЕСЬ"
function fromthefog:structures/sign_place with storage fromthefog:tmp sign
