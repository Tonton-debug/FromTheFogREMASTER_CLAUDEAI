$execute store success score #t ftf.tmp if score #$(key) ftf.config matches 0
$scoreboard players operation #$(key) ftf.config = #t ftf.tmp
function fromthefog:config/menu
