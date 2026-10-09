#!/usr/bin/env python3
"""Статическая проверка датапака по дереву команд и реестрам Minecraft 26.2.

Данные берутся из https://github.com/misode/mcmeta (ветки 26.2-summary / 26.2-data).
Использование:  python3 tools/validate.py [путь_к_кэшу]
"""
import json, os, re, sys, urllib.request

VERSION = "26.2"
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PACK = os.path.join(ROOT, "FromTheFog")
NS = "fromthefog"
CACHE = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, ".cache")
BASE = f"https://raw.githubusercontent.com/misode/mcmeta/{VERSION}-summary/"


def fetch(rel):
    os.makedirs(CACHE, exist_ok=True)
    p = os.path.join(CACHE, rel.replace("/", "_"))
    if not os.path.exists(p):
        urllib.request.urlretrieve(BASE + rel, p)
    return json.load(open(p, encoding="utf-8"))


TREE = fetch("commands/data.json")
REG = fetch("registries/data.json")
REGS = {k: set(v) for k, v in REG.items()}

# Значения-заглушки для строк-макросов
MACRO = dict(yaw="10", dist="5", fn="fromthefog:tick", min="1", max="2", mode="watch",
             life="10", rot="4", msg="X", half="3", key="enabled", label="L", step="1",
             op="add", v="1", event="roll")

errors = []
own_functions, own_tags, own_preds, own_advs = set(), set(), set(), set()
for dp, _, fs in os.walk(os.path.join(PACK, "data")):
    for f in fs:
        rel = os.path.relpath(os.path.join(dp, f), os.path.join(PACK, "data")).replace(os.sep, "/")
        ns, kind, *rest = rel.split("/")
        name = "/".join(rest).rsplit(".", 1)[0]
        if kind == "function":
            own_functions.add(f"{ns}:{name}")
        elif kind == "predicate":
            own_preds.add(f"{ns}:{name}")
        elif kind == "advancement":
            own_advs.add(f"{ns}:{name}")
        elif kind == "tags" and rest[0] == "block":
            own_tags.add(f"{ns}:{'/'.join(rest[1:]).rsplit('.', 1)[0]}")


def rl(s):
    return s if ":" in s else "minecraft:" + s


class Fail(Exception):
    pass


# ---------------- SNBT ----------------
def skip_ws(s, i):
    while i < len(s) and s[i] == " ":
        i += 1
    return i


def snbt_value(s, i):
    """Возвращает (python-значение, новый индекс)."""
    i = skip_ws(s, i)
    if i >= len(s):
        raise Fail("SNBT: неожиданный конец")
    c = s[i]
    if c == "{":
        obj, i = {}, i + 1
        i = skip_ws(s, i)
        if s[i] == "}":
            return obj, i + 1
        while True:
            i = skip_ws(s, i)
            if s[i] in "\"'":
                k, i = snbt_string(s, i)
            else:
                m = re.match(r"[A-Za-z0-9_.+\-]+", s[i:])
                if not m:
                    raise Fail(f"SNBT: плохой ключ у {s[i:i+15]!r}")
                k, i = m.group(0), i + m.end()
            i = skip_ws(s, i)
            if s[i] != ":":
                raise Fail(f"SNBT: ожидалось ':' у {s[i:i+15]!r}")
            v, i = snbt_value(s, i + 1)
            obj[k] = v
            i = skip_ws(s, i)
            if s[i] == ",":
                i += 1
                continue
            if s[i] == "}":
                return obj, i + 1
            raise Fail(f"SNBT: ожидалось ',' или '}}' у {s[i:i+15]!r}")
    if c == "[":
        arr, i = [], i + 1
        i = skip_ws(s, i)
        if s[i:i + 2] in ("B;", "I;", "L;"):
            i += 2
        if s[i] == "]":
            return arr, i + 1
        while True:
            v, i = snbt_value(s, i)
            arr.append(v)
            i = skip_ws(s, i)
            if s[i] == ",":
                i += 1
                continue
            if s[i] == "]":
                return arr, i + 1
            raise Fail("SNBT: плохой список")
    if c in "\"'":
        return snbt_string(s, i)
    m = re.match(r"[A-Za-z0-9_.+\-]+", s[i:])
    if not m:
        raise Fail(f"SNBT: плохое значение у {s[i:i+15]!r}")
    return m.group(0), i + m.end()


def snbt_string(s, i):
    q, i, out = s[i], i + 1, []
    while i < len(s):
        c = s[i]
        if c == "\\":
            out.append(s[i + 1])
            i += 2
            continue
        if c == q:
            return "".join(out), i + 1
        out.append(c)
        i += 1
    raise Fail("SNBT: незакрытая строка")


COMPONENT_KEYS = {"text", "translate", "with", "fallback", "score", "selector", "keybind", "nbt", "type",
                  "color", "bold", "italic", "underlined", "strikethrough", "obfuscated", "font", "insertion",
                  "shadow_color", "click_event", "hover_event", "extra", "separator", "source", "block",
                  "entity", "storage", "interpret", "object", "sprite", "atlas", "player", "hat"}
COLORS = {"black", "dark_blue", "dark_green", "dark_aqua", "dark_red", "dark_purple", "gold", "gray",
          "dark_gray", "blue", "green", "aqua", "red", "light_purple", "yellow", "white"}


def check_component(v, where):
    if isinstance(v, str):
        return
    if isinstance(v, list):
        for x in v:
            check_component(x, where)
        return
    if not isinstance(v, dict):
        raise Fail(f"компонент: неожиданный тип в {where}")
    for k in v:
        if k not in COMPONENT_KEYS:
            raise Fail(f"компонент: неизвестный ключ '{k}'")
    if "color" in v and v["color"] not in COLORS and not str(v["color"]).startswith("#"):
        raise Fail(f"компонент: цвет {v['color']}")
    if "score" in v and set(v["score"]) - {"name", "objective"}:
        raise Fail("компонент: score")
    ce = v.get("click_event")
    if ce is not None:
        a = ce.get("action")
        need = {"run_command": "command", "suggest_command": "command", "open_url": "url",
                "copy_to_clipboard": "value", "change_page": "page"}.get(a)
        if not need or need not in ce:
            raise Fail(f"компонент: click_event {ce}")
        if a in ("run_command", "suggest_command"):
            check_command(ce["command"].lstrip("/"), where + " (click_event)")
    he = v.get("hover_event")
    if he is not None:
        if he.get("action") != "show_text" or "value" not in he:
            raise Fail(f"компонент: hover_event {he}")
        check_component(he["value"], where)
    for k in ("extra", "with"):
        if k in v:
            check_component(v[k], where)


# ---------------- аргументы ----------------
def word(s, i):
    m = re.match(r"\S+", s[i:])
    if not m:
        raise Fail("ожидался аргумент")
    return m.group(0), i + m.end()


def coord(s, i, n, local_ok=True):
    pos = []
    for _ in range(n):
        i = skip_ws(s, i)
        w, i = word(s, i)
        if not re.fullmatch(r"([~^]?-?(\d+\.?\d*|\.\d+)?)", w) or w == "":
            raise Fail(f"координата {w!r}")
        pos.append(w)
    kinds = {p[0] == "^" for p in pos}
    if len(kinds) > 1 and any(p.startswith("^") for p in pos):
        raise Fail("нельзя смешивать ^ и обычные координаты")
    return i


def selector(s, i):
    if s[i] == "@":
        if s[i + 1] not in "parsen":
            raise Fail("селектор")
        j = i + 2
        if j < len(s) and s[j] == "[":
            depth = 0
            while j < len(s):
                if s[j] in "[{":
                    depth += 1
                elif s[j] in "]}":
                    depth -= 1
                    if depth == 0:
                        j += 1
                        break
                j += 1
            body = s[i + 3:j - 1]
            for part in re.split(r",(?![^\[{]*[\]}])", body):
                k, _, val = part.partition("=")
                if k not in {"type", "tag", "distance", "limit", "sort", "scores", "gamemode", "x", "y", "z",
                             "dx", "dy", "dz", "name", "nbt", "level", "advancements", "predicate",
                             "x_rotation", "y_rotation", "team"}:
                    raise Fail(f"селектор: ключ {k}")
                if k == "type" and rl(val.lstrip("!")) not in {rl(x) for x in REGS["entity_type"]}:
                    raise Fail(f"селектор: тип {val}")
                if k == "gamemode" and val.lstrip("!") not in {"survival", "creative", "adventure", "spectator"}:
                    raise Fail(f"селектор: gamemode {val}")
        return j
    return word(s, i)[1]


def block_state(s, i, predicate=False):
    m = re.match(r"#?[a-z0-9_:/.\-]+", s[i:])
    if not m:
        raise Fail("блок")
    bid = m.group(0)
    if bid.startswith("#"):
        if not predicate:
            raise Fail("тег блока здесь недопустим")
        t = rl(bid[1:])
        if t.startswith("minecraft:") and t[10:] not in REGS["tag/block"]:
            raise Fail(f"нет тега блоков {t}")
        if not t.startswith("minecraft:") and t not in own_tags:
            raise Fail(f"нет своего тега блоков {t}")
    elif rl(bid)[10:] not in REGS["block"]:
        raise Fail(f"нет блока {bid}")
    i += m.end()
    if i < len(s) and s[i] == "[":
        j = s.index("]", i)
        i = j + 1
    if i < len(s) and s[i] == "{":
        _, i = snbt_value(s, i)
    return i


def parse_arg(node, name, s, i, cmd):
    p = node["parser"]
    props = node.get("properties", {})
    if p in ("brigadier:integer", "brigadier:float", "brigadier:double", "brigadier:long"):
        w, j = word(s, i)
        try:
            val = float(w) if p != "brigadier:integer" else int(w)
        except ValueError:
            raise Fail(f"{name}: число {w!r}")
        if "min" in props and val < props["min"] or "max" in props and val > props["max"]:
            raise Fail(f"{name}: {w} вне диапазона")
        return j
    if p == "brigadier:bool":
        w, j = word(s, i)
        if w not in ("true", "false"):
            raise Fail("bool")
        return j
    if p == "brigadier:string":
        t = props.get("type")
        if t == "greedy":
            return len(s)
        if t == "phrase" and s[i] in "\"'":
            return snbt_string(s, i)[1]
        return word(s, i)[1]
    if p in ("minecraft:message",):
        return len(s)
    if p in ("minecraft:entity", "minecraft:score_holder", "minecraft:game_profile"):
        return selector(s, i)
    if p == "minecraft:vec3":
        return coord(s, i, 3)
    if p == "minecraft:block_pos":
        return coord(s, i, 3)
    if p in ("minecraft:vec2", "minecraft:rotation", "minecraft:column_pos"):
        return coord(s, i, 2)
    if p == "minecraft:block_state":
        return block_state(s, i)
    if p == "minecraft:block_predicate":
        return block_state(s, i, predicate=True)
    if p in ("minecraft:component", "minecraft:style"):
        v, j = snbt_value(s, i)
        check_component(v, cmd)
        return j
    if p in ("minecraft:nbt_compound_tag", "minecraft:nbt_tag"):
        return snbt_value(s, i)[1]
    if p == "minecraft:particle":
        m = re.match(r"[a-z0-9_:]+", s[i:])
        if rl(m.group(0))[10:] not in REGS["particle_type"]:
            raise Fail(f"частица {m.group(0)}")
        j = i + m.end()
        if j < len(s) and s[j] == "{":
            j = snbt_value(s, j)[1]
        return j
    if p == "minecraft:loot_predicate":
        if s[i] == "{":
            return snbt_value(s, i)[1]
        w, j = word(s, i)
        if not rl(w).startswith("minecraft:") and rl(w) not in own_preds:
            raise Fail(f"нет предиката {w}")
        return j
    if p == "minecraft:function":
        w, j = word(s, i)
        if w.startswith("#"):
            return j
        if w.startswith(NS + ":") and w not in own_functions:
            raise Fail(f"нет функции {w}")
        return j
    if p in ("minecraft:resource", "minecraft:resource_key", "minecraft:resource_or_tag"):
        w, j = word(s, i)
        reg = props.get("registry", "").replace("minecraft:", "")
        if reg == "advancement":
            if rl(w) not in own_advs and not rl(w).startswith("minecraft:"):
                raise Fail(f"нет достижения {w}")
        elif reg in REGS and not w.startswith("#") and rl(w)[10:] not in REGS[reg] and rl(w).startswith("minecraft:"):
            raise Fail(f"нет {w} в реестре {reg}")
        return j
    if p == "minecraft:resource_location":
        w, j = word(s, i)
        if name == "sound" and rl(w)[10:] not in REGS["sound_event"]:
            raise Fail(f"нет звука {w}")
        return j
    if p == "minecraft:dimension":
        w, j = word(s, i)
        if rl(w)[10:] not in REGS["dimension"] | {"overworld", "the_nether", "the_end"}:
            raise Fail(f"измерение {w}")
        return j
    if p == "minecraft:heightmap":
        w, j = word(s, i)
        if w not in {"world_surface", "motion_blocking", "motion_blocking_no_leaves", "ocean_floor"}:
            raise Fail(f"heightmap {w}")
        return j
    if p == "minecraft:entity_anchor":
        w, j = word(s, i)
        if w not in ("eyes", "feet"):
            raise Fail("anchor")
        return j
    if p == "minecraft:swizzle":
        w, j = word(s, i)
        if not re.fullmatch(r"[xyz]{1,3}", w):
            raise Fail("swizzle")
        return j
    if p == "minecraft:int_range":
        w, j = word(s, i)
        if not re.fullmatch(r"-?\d*(\.\.)?-?\d*", w):
            raise Fail(f"диапазон {w}")
        return j
    if p == "minecraft:time":
        w, j = word(s, i)
        if not re.fullmatch(r"\d+(\.\d+)?[dst]?", w):
            raise Fail(f"время {w}")
        return j
    if p == "minecraft:operation":
        w, j = word(s, i)
        if w not in ("=", "+=", "-=", "*=", "/=", "%=", "<", ">", "><"):
            raise Fail(f"операция {w}")
        return j
    if p == "minecraft:objective":
        w, j = word(s, i)
        if not w.startswith("ftf."):
            raise Fail(f"чужая цель {w}")
        return j
    if p == "minecraft:objective_criteria":
        return word(s, i)[1]
    if p == "minecraft:nbt_path":
        return word(s, i)[1]
    # остальные парсеры — одно слово
    return word(s, i)[1]


def walk(node, s, i, cmd, depth=0):
    """Пытается разобрать s[i:] от узла node. Возвращает True при успехе."""
    i = skip_ws(s, i)
    if i >= len(s):
        if node.get("executable"):
            return True
        raise Fail("команда не завершена")
    if "redirect" in node:
        target = TREE
        for r in node["redirect"]:
            target = TREE["children"][r]
        kids = target.get("children", {})
    elif node.get("type") == "literal" and not node.get("children") and node is not TREE and node.get("executable") is None:
        kids = TREE["children"]  # 'execute run'
    else:
        kids = node.get("children", {})
    w = re.match(r"\S*", s[i:]).group(0)
    last = None
    for k, ch in kids.items():
        if ch["type"] == "literal" and k == w:
            try:
                return walk(ch, s, i + len(w), cmd, depth + 1)
            except Fail as e:
                last = e
    for k, ch in kids.items():
        if ch["type"] == "argument":
            try:
                j = parse_arg(ch, k, s, i, cmd)
                if j < len(s) and s[j] != " ":
                    raise Fail(f"{k}: лишние символы {s[j:j+15]!r}")
                return walk(ch, s, j, cmd, depth + 1)
            except Fail as e:
                last = e
    raise last or Fail(f"неизвестное слово {w!r}")


def check_command(line, where):
    try:
        walk(TREE, line, 0, line)
    except (Fail, IndexError, ValueError) as e:
        errors.append(f"{where}: {e}\n    {line}")


count = 0
for dp, _, fs in os.walk(os.path.join(PACK, "data")):
    for f in sorted(fs):
        path = os.path.join(dp, f)
        rel = os.path.relpath(path, ROOT)
        if f.endswith(".json"):
            try:
                json.load(open(path, encoding="utf-8"))
            except Exception as e:
                errors.append(f"{rel}: JSON {e}")
            continue
        if not f.endswith(".mcfunction"):
            continue
        for n, line in enumerate(open(path, encoding="utf-8"), 1):
            line = line.rstrip("\n")
            if not line.strip() or line.lstrip().startswith("#"):
                continue
            if line.startswith("$"):
                line = re.sub(r"\$\(([a-z_]+)\)", lambda m: MACRO[m.group(1)], line[1:])
            count += 1
            check_command(line, f"{rel}:{n}")

# функции, вызываемые через макро-аргумент fn / тег
for dp, _, fs in os.walk(os.path.join(PACK, "data")):
    for f in fs:
        txt = open(os.path.join(dp, f), encoding="utf-8").read()
        for ref in re.findall(r'"(fromthefog:[a-z_/]+)"', txt):
            if ref.startswith("fromthefog:entity/"):
                continue  # текстура из ресурспака
            if ref not in own_functions and ref not in own_advs and ref not in own_preds:
                errors.append(f"{f}: ссылка на несуществующее {ref}")

print(f"Проверено команд: {count}")
for e in errors:
    print("ОШИБКА", e)
sys.exit(1 if errors else 0)
