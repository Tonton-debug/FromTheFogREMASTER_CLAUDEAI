# Алтарь Херобрина:
#   нижний слой 3x3 — золотой блок в центре, вокруг замшелый булыжник (или золото)
#   сверху — незерак в центре и 4 красных факела по сторонам
execute unless block ~ ~-1 ~ minecraft:gold_block run return fail
execute unless block ~1 ~-1 ~ #fromthefog:shrine_base run return fail
execute unless block ~-1 ~-1 ~ #fromthefog:shrine_base run return fail
execute unless block ~ ~-1 ~1 #fromthefog:shrine_base run return fail
execute unless block ~ ~-1 ~-1 #fromthefog:shrine_base run return fail
execute unless block ~1 ~-1 ~1 #fromthefog:shrine_base run return fail
execute unless block ~-1 ~-1 ~1 #fromthefog:shrine_base run return fail
execute unless block ~1 ~-1 ~-1 #fromthefog:shrine_base run return fail
execute unless block ~-1 ~-1 ~-1 #fromthefog:shrine_base run return fail
execute unless block ~1 ~ ~ minecraft:redstone_torch run return fail
execute unless block ~-1 ~ ~ minecraft:redstone_torch run return fail
execute unless block ~ ~ ~1 minecraft:redstone_torch run return fail
execute unless block ~ ~ ~-1 minecraft:redstone_torch run return fail
function fromthefog:shrine/activate
