#!/usr/bin/env python3
"""Генерирует скин Херобрина 64x64 (классическая раскладка, модель wide)."""
import os, random, sys
from PIL import Image

random.seed(1337)
OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
    "FromTheFog-Resources/assets/fromthefog/textures/entity/herobrine.png")

SKIN, HAIR, SHIRT, PANTS, SHOE = (170, 125, 102), (40, 28, 12), (0, 160, 160), (60, 50, 150), (90, 90, 90)
img = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
px = img.load()


def shade(c, k=10):
    d = random.randint(-k, k)
    return tuple(max(0, min(255, v + d)) for v in c) + (255,)


def rect(x, y, w, h, c):
    for i in range(x, x + w):
        for j in range(y, y + h):
            px[i, j] = shade(c)


def box(u, v, w, h, d, color_fn):
    """Развёртка куба: w — ширина, h — высота, d — глубина."""
    faces = {"top": (u + d, v, w, d), "bottom": (u + d + w, v, w, d),
             "right": (u, v + d, d, h), "front": (u + d, v + d, w, h),
             "left": (u + d + w, v + d, d, h), "back": (u + 2 * d + w, v + d, w, h)}
    for name, (x, y, fw, fh) in faces.items():
        for j in range(fh):
            for i in range(fw):
                px[x + i, y + j] = shade(color_fn(name, i, j, fh))


# Голова
def head(face, i, j, h):
    if face == "top":
        return HAIR
    if face == "bottom":
        return SKIN
    if face == "back":
        return HAIR if j < 7 else SKIN
    if face in ("left", "right"):
        return HAIR if j < 3 or (j < 5 and ((face == "right" and i < 3) or (face == "left" and i > 4))) else SKIN
    return HAIR if j < 2 or (j == 2 and i in (0, 7)) else SKIN


box(0, 0, 8, 8, 8, head)
# Лицо: белые глаза без зрачков, нос, рот, щетина
for x in (9, 10, 13, 14):
    px[x, 12] = (255, 255, 255, 255)
for x in (9, 14):
    px[x, 11] = (230, 230, 230, 255)
px[11, 13] = shade((130, 85, 65), 4)
px[12, 13] = shade((130, 85, 65), 4)
for x in range(10, 14):
    px[x, 14] = shade((95, 55, 40), 4)
for x in range(9, 15):
    px[x, 15] = shade((105, 70, 45), 6)

# Тело
box(16, 16, 8, 12, 4, lambda f, i, j, h: SHIRT if f != "bottom" else PANTS)
# Руки (правая и левая)
arm = lambda f, i, j, h: SHIRT if f == "top" or (f not in ("bottom", "top") and j < 4) else SKIN
box(40, 16, 4, 12, 4, arm)
box(32, 48, 4, 12, 4, arm)
# Ноги
leg = lambda f, i, j, h: SHOE if f == "bottom" or (f not in ("top", "bottom") and j >= 10) else PANTS
box(0, 16, 4, 12, 4, leg)
box(16, 48, 4, 12, 4, leg)

os.makedirs(os.path.dirname(OUT), exist_ok=True)
img.save(OUT)
print("saved", OUT)
