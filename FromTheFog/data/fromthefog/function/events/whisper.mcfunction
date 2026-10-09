# Едва заметная надпись над хотбаром
execute unless score #chat ftf.config matches 1 run return run function fromthefog:events/sounds
execute store result score #c ftf.tmp run random value 1..4
execute if score #c ftf.tmp matches 1 run title @s actionbar {text:"Он наблюдает.",color:"dark_gray",italic:true}
execute if score #c ftf.tmp matches 2 run title @s actionbar {text:"Ты слышал это?",color:"dark_gray",italic:true}
execute if score #c ftf.tmp matches 3 run title @s actionbar {text:"Не оборачивайся.",color:"dark_gray",italic:true}
execute if score #c ftf.tmp matches 4 run title @s actionbar {text:"Туман сгущается...",color:"dark_gray",italic:true}
playsound minecraft:ambient.cave ambient @s ~ ~ ~ 0.6 1.4
