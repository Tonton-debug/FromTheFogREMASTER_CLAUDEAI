# Выбор случайного события для игрока (@s, на его позиции)
execute store result score #r ftf.tmp run random value 1..100

execute if score #r ftf.tmp matches 1..18 run return run function fromthefog:events/sighting
execute if score #r ftf.tmp matches 19..26 run return run function fromthefog:events/behind
execute if score #r ftf.tmp matches 27..31 run return run function fromthefog:events/stalk
execute if score #r ftf.tmp matches 32..34 run return run function fromthefog:events/jumpscare
execute if score #r ftf.tmp matches 35..50 run return run function fromthefog:events/sounds
execute if score #r ftf.tmp matches 51..58 run return run function fromthefog:events/footsteps
execute if score #r ftf.tmp matches 59..64 run return run function fromthefog:events/torches
execute if score #r ftf.tmp matches 65..71 run return run function fromthefog:events/leaves
execute if score #r ftf.tmp matches 72..80 run return run function fromthefog:events/structure
execute if score #r ftf.tmp matches 81..85 run return run function fromthefog:events/tunnel
execute if score #r ftf.tmp matches 86..91 run return run function fromthefog:events/chat
execute if score #r ftf.tmp matches 92..95 run return run function fromthefog:events/lightning
function fromthefog:events/whisper
