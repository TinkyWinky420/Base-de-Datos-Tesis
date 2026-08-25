from PIL import Image, ImageDraw, ImageFont
import os

SCREENSHOTS = r"C:\Users\Angel\Base-de-Datos-Tesis\screenshots"
OUTPUT = r"C:\Users\Angel\OneDrive\Escritorio\Diagrama Navegacion HiStesis.jpg"

THUMB_W, THUMB_H = 280, 200
PADDING = 40
ARROW_COLOR = (50, 50, 50)
BOX_BORDER = 2
TITLE_COLOR = (30, 30, 30)
LABEL_BG = (240, 240, 240)
SECTION_BG = (255, 255, 255)

def load_thumb(filename):
    path = os.path.join(SCREENSHOTS, filename)
    img = Image.open(path).convert("RGB")
    img = img.resize((THUMB_W, THUMB_H), Image.LANCZOS)
    return img

def draw_arrow(draw, x1, y1, x2, y2, color=ARROW_COLOR, width=2):
    draw.line([(x1, y1), (x2, y2)], fill=color, width=width)
    import math
    angle = math.atan2(y2 - y1, x2 - x1)
    arrow_len = 12
    arrow_angle = 0.4
    ax1 = x2 - arrow_len * math.cos(angle - arrow_angle)
    ay1 = y2 - arrow_len * math.sin(angle - arrow_angle)
    ax2 = x2 - arrow_len * math.cos(angle + arrow_angle)
    ay2 = y2 - arrow_len * math.sin(angle + arrow_angle)
    draw.polygon([(x2, y2), (ax1, ay1), (ax2, ay2)], fill=color)

def draw_label(draw, x, y, text, font):
    bbox = draw.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    px, py = 8, 4
    rx = x - tw // 2 - px
    ry = y - th // 2 - py
    draw.rounded_rectangle([rx, ry, rx + tw + 2*px, ry + th + 2*py], radius=6, fill=LABEL_BG, outline=ARROW_COLOR, width=1)
    draw.text((x - tw // 2, y - th // 2), text, fill=TITLE_COLOR, font=font)

def paste_thumb(canvas, filename, cx, cy, label, font):
    img = load_thumb(filename)
    x = cx - THUMB_W // 2
    y = cy - THUMB_H // 2
    canvas.paste(img, (x, y))
    draw = ImageDraw.Draw(canvas)
    draw.rounded_rectangle([x - BOX_BORDER, y - BOX_BORDER, x + THUMB_W + BOX_BORDER, y + THUMB_H + BOX_BORDER],
                           radius=8, outline=ARROW_COLOR, width=BOX_BORDER)
    label_y = y + THUMB_H + 12
    draw_label(draw, cx, label_y, label, font)
    return draw

try:
    font = ImageFont.truetype("arial.ttf", 13)
    font_title = ImageFont.truetype("arial.ttf", 20)
    font_section = ImageFont.truetype("arialbd.ttf", 15)
except:
    font = ImageFont.load_default()
    font_title = font
    font_section = font

# Layout: 3 rows
# Row 0: Home, Login (centered)
# Row 1: Listado, Buscar, Nueva, Revisar
# Row 2: Historial, Estadisticas, Zonas, Administrativo

col_w = THUMB_W + PADDING
row_h = THUMB_H + 60

# Canvas size
canvas_w = 4 * col_w + PADDING * 2
canvas_h = 3 * row_h + 180

canvas = Image.new("RGB", (canvas_w, canvas_h), SECTION_BG)

# Centers for each cell
def cell_cx(col, total=4):
    return PADDING + col_w * col + col_w // 2

def cell_cy(row):
    return 80 + row_h * row + THUMB_H // 2

draw = ImageDraw.Draw(canvas)

# Title
title = "Diagrama de Navegación de Interfaces - HiStesis"
bbox = draw.textbbox((0, 0), title, font=font_title)
draw.text(((canvas_w - (bbox[2] - bbox[0])) // 2, 15), title, fill=TITLE_COLOR, font=font_title)

# Section labels
draw_label(draw, canvas_w // 2, 52, "Público", font_section)

# Row 0: Home and Login
home_cx = cell_cx(1)
login_cx = cell_cx(2)
row0_cy = cell_cy(0)

paste_thumb(canvas, "01_home.png", home_cx, row0_cy, "Inicio (Público)", font)
paste_thumb(canvas, "02_login.png", login_cx, row0_cy, "Iniciar Sesión", font)

draw = ImageDraw.Draw(canvas)
# Arrow: Home -> Login
draw_arrow(draw, home_cx + THUMB_W // 2 + 5, row0_cy, login_cx - THUMB_W // 2 - 5, row0_cy)

# Section: Autenticado
auth_y = row0_cy + THUMB_H // 2 + 50
draw_label(draw, canvas_w // 2, auth_y, "Autenticado (requiere sesión)", font_section)

# Row 1: Main authenticated screens
row1_cy = cell_cy(1)
screens_row1 = [
    ("03_listado.png", "Listado de Tesis"),
    ("04_buscar.png", "Buscar Tesis"),
    ("05_nueva_tesis.png", "Nueva Tesis"),
    ("06_revisar.png", "Revisar Tesis"),
]

positions_r1 = []
for i, (fname, label) in enumerate(screens_row1):
    cx = cell_cx(i)
    paste_thumb(canvas, fname, cx, row1_cy, label, font)
    positions_r1.append(cx)

draw = ImageDraw.Draw(canvas)

# Arrow: Login -> Row 1 (fan out from login center to all 4)
login_bottom = row0_cy + THUMB_H // 2 + 25
row1_top = row1_cy - THUMB_H // 2 - 5
# Vertical line down from login
mid_x = (login_cx + home_cx) // 2
draw.line([(login_cx, login_bottom), (login_cx, login_bottom + 15)], fill=ARROW_COLOR, width=2)
draw.line([(login_cx, login_bottom + 15), (canvas_w // 2, login_bottom + 15)], fill=ARROW_COLOR, width=2)
draw.line([(canvas_w // 2, login_bottom + 15), (canvas_w // 2, row1_top - 5)], fill=ARROW_COLOR, width=2)
# Fan out
for cx in positions_r1:
    draw.line([(canvas_w // 2, row1_top - 5), (cx, row1_top - 5)], fill=ARROW_COLOR, width=2)
    draw_arrow(draw, cx, row1_top - 5, cx, row1_top, color=ARROW_COLOR, width=2)

# Row 2: Secondary screens
row2_cy = cell_cy(2)
screens_row2 = [
    ("07_historial.png", "Historial"),
    ("08_estadisticas.png", "Estadísticas"),
    ("09_zonas.png", "Zonas y Planteles"),
    ("10_administrativo.png", "Administrativo"),
]

positions_r2 = []
for i, (fname, label) in enumerate(screens_row2):
    cx = cell_cx(i)
    paste_thumb(canvas, fname, cx, row2_cy, label, font)
    positions_r2.append(cx)

draw = ImageDraw.Draw(canvas)

# Arrows from Row 1 to Row 2 (vertical down)
row1_bottom = row1_cy + THUMB_H // 2 + 25
row2_top = row2_cy - THUMB_H // 2 - 5
for cx in positions_r2:
    draw_arrow(draw, cx, row1_bottom, cx, row2_top, color=ARROW_COLOR, width=2)

# Save
canvas.save(OUTPUT, "JPEG", quality=92)
print(f"Diagrama guardado: {OUTPUT}")
print(f"Tamano: {canvas.size[0]}x{canvas.size[1]} px")
