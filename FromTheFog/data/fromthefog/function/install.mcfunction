# Первая установка: значения настроек по умолчанию
scoreboard players set #installed ftf.data 1
scoreboard players set #ticks ftf.data 0
scoreboard players set #days ftf.data 0
scoreboard players set #awake ftf.data 0

scoreboard players set #enabled ftf.config 1
# Через сколько игровых дней Херобрин начинает преследование
scoreboard players set #start_day ftf.config 3
# Пауза между событиями для каждого игрока (секунды)
scoreboard players set #min_cd ftf.config 90
scoreboard players set #max_cd ftf.config 300
scoreboard players set #sightings ftf.config 1
scoreboard players set #structures ftf.config 1
scoreboard players set #griefing ftf.config 1
scoreboard players set #jumpscares ftf.config 1
scoreboard players set #chat ftf.config 1
scoreboard players set #sounds ftf.config 1
scoreboard players set #creative ftf.config 0

tellraw @a [{text:"[From The Fog] ",color:"dark_red"},{text:"Установлен. Что-то наблюдает из тумана...",color:"gray",italic:true}]
tellraw @a [{text:"[From The Fog] ",color:"dark_red"},{text:"Настройки: ",color:"gray"},{text:"[открыть]",color:"yellow",click_event:{action:"run_command",command:"/function fromthefog:config/menu"},hover_event:{action:"show_text",value:"/function fromthefog:config/menu"}}]
