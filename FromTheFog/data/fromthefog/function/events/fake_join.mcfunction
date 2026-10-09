tellraw @s {translate:"multiplayer.player.joined",with:["Herobrine"],color:"yellow"}
tag @s add ftf.leave
schedule function fromthefog:events/fake_leave 100t append
