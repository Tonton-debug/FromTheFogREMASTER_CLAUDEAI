execute store result score #p ftf.tmp run random value 1..6
execute if score #p ftf.tmp matches 1 run return run function fromthefog:structures/sand_pyramid
execute if score #p ftf.tmp matches 2 run return run function fromthefog:structures/cross
execute if score #p ftf.tmp matches 3 run return run function fromthefog:structures/dead_tree
execute if score #p ftf.tmp matches 4 run return run function fromthefog:structures/torch_shrine
execute if score #p ftf.tmp matches 5 run return run function fromthefog:structures/hole
function fromthefog:structures/sign
