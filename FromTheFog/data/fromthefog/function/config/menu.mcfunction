# Меню настроек (кликабельное)
tellraw @s {text:"========== From The Fog ==========",color:"dark_red",bold:true}
tellraw @s [{text:"Прошло дней: ",color:"gray"},{score:{name:"#days",objective:"ftf.data"},color:"white"},{text:"  |  Пробуждён: ",color:"gray"},{score:{name:"#awake",objective:"ftf.data"},color:"white"}]
function fromthefog:config/line_toggle {key:"enabled",label:"Мод включён"}
function fromthefog:config/line_toggle {key:"sightings",label:"Появления Херобрина"}
function fromthefog:config/line_toggle {key:"jumpscares",label:"Скримеры"}
function fromthefog:config/line_toggle {key:"structures",label:"Постройки и таблички"}
function fromthefog:config/line_toggle {key:"griefing",label:"Факелы / листья / туннели"}
function fromthefog:config/line_toggle {key:"chat",label:"Сообщения в чате"}
function fromthefog:config/line_toggle {key:"sounds",label:"Звуки и шаги"}
function fromthefog:config/line_toggle {key:"creative",label:"Работать в творческом"}
function fromthefog:config/line_number {key:"start_day",label:"Начало (день)",step:1}
function fromthefog:config/line_number {key:"min_cd",label:"Мин. пауза (сек)",step:15}
function fromthefog:config/line_number {key:"max_cd",label:"Макс. пауза (сек)",step:15}
tellraw @s [{text:"Тест события: ",color:"gray"},{text:"[появление] ",color:"aqua",click_event:{action:"run_command",command:"/function fromthefog:debug/run {event:\"sighting\"}"}},{text:"[за спиной] ",color:"aqua",click_event:{action:"run_command",command:"/function fromthefog:debug/run {event:\"behind\"}"}},{text:"[постройка] ",color:"aqua",click_event:{action:"run_command",command:"/function fromthefog:debug/run {event:\"structure\"}"}},{text:"[случайное]",color:"aqua",click_event:{action:"run_command",command:"/function fromthefog:debug/run {event:\"roll\"}"}}]
tellraw @s [{text:"[Сбросить дни] ",color:"gold",click_event:{action:"run_command",command:"/function fromthefog:config/reset_days"}},{text:"[Удалить мод]",color:"red",click_event:{action:"suggest_command",command:"/function fromthefog:uninstall"},hover_event:{action:"show_text",value:"Удаляет все данные From The Fog"}}]
