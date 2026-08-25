from PIL import Image, ImageDraw, ImageFont
import os, math

SCREENSHOTS = r"C:\Users\Angel\Base-de-Datos-Tesis\screenshots"
OUTPUT = r"C:\Users\Angel\OneDrive\Escritorio\Diagrama Navegacion HiStesis.jpg"

THUMB_W, THUMB_H = 240, 170
LABEL_H = 30
ROW_GAP = 28
MARGIN = 50

BG = (255, 255, 255)
ARROW = (100, 100, 100)
TITLE_COLOR = (20, 20, 20)

ROLE_STYLES = {
    "alumno": {"border": (41, 128, 185), "bg": (214, 234, 248), "label": "Estudiante (Alumno)"},
    "asesor": {"border": (39, 174, 96), "bg": (212, 239, 223), "label": "Asesor"},
    "admin":  {"border": (142, 68, 173), "bg": (235, 222, 240), "label": "Administrativo"},
}

try:
    font_bold = ImageFont.truetype("arialbd.ttf", 12)
    font_role = ImageFont.truetype("arialbd.ttf", 15)
    font_title = ImageFont.truetype("arialbd.ttf", 20)
except:
    font_bold = ImageFont.load_default()
    font_role = font_bold
    font_title = font_bold

def load_thumb(filename):
    path = os.path.join(SCREENSHOTS, filename)
    img = Image.open(path).convert("RGB")
    img = img.resize((THUMB_W, THUMB_H), Image.LANCZOS)
    return img

def draw_arrow_v(draw, x, y1, y2, color=ARROW, w=2):
    draw.line([(x, y1), (x, y2)], fill=color, width=w)
    a = 9
    draw.polygon([(x, y2), (x - a//2, y2 - a), (x + a//2, y2 - a)], fill=color)

def cell_height():
    return THUMB_H + LABEL_H + ROW_GAP

def draw_thumb(canvas, cx, cy, img, label, border_color, bg_color):
    draw = ImageDraw.Draw(canvas)
    x = cx - THUMB_W // 2
    y = cy - THUMB_H // 2
    draw.rounded_rectangle([x-2, y-2, x+THUMB_W+2, y+THUMB_H+2], radius=5, outline=border_color, width=2)
    canvas.paste(img, (x, y))
    ly = y + THUMB_H + 5
    bb = draw.textbbox((0,0), label, font=font_bold)
    tw = bb[2] - bb[0]
    draw.rounded_rectangle([cx-tw//2-7, ly-1, cx+tw//2+7, ly+17], radius=3, fill=bg_color, outline=border_color, width=1)
    draw.text((cx-tw//2, ly), label, fill=TITLE_COLOR, font=font_bold)

# Data
ROLES = {
    "alumno": [
        ("alumno_home.png", "Inicio"),
        ("alumno_registrar.png", "Registrar Tesis"),
        ("alumno_revisar.png", "Revisar Mi Tesis"),
    ],
    "asesor": [
        ("asesor_buscar.png", "Buscar Tesis"),
        ("asesor_listado.png", "Listado de Tesis"),
        ("asesor_historial.png", "Historial"),
        ("asesor_estadisticas.png", "Estadisticas"),
    ],
    "admin": [
        ("admin_dashboard.png", "Panel Admin"),
        ("admin_listado.png", "Listado de Tesis"),
        ("admin_buscar.png", "Buscar Tesis"),
        ("admin_historial.png", "Historial"),
        ("admin_estadisticas.png", "Estadisticas"),
        ("admin_zonas.png", "Zonas y Planteles"),
        ("admin_carreras.png", "Carreras por Plantel"),
    ],
}

max_rows = max(len(v) for v in ROLES.values())

# Canvas dimensions
col_w = THUMB_W + 60
canvas_w = 3 * col_w + 2 * MARGIN + 60
login_area_h = 120
roles_label_h = 36
screens_area_h = max_rows * cell_height()
canvas_h = login_area_h + roles_label_h + screens_area_h + 80

canvas = Image.new("RGB", (canvas_w, canvas_h), BG)
draw = ImageDraw.Draw(canvas)

# Title
bb = draw.textbbox((0,0), "Diagrama de Navegacion de Interfaces - HiStesis", font=font_title)
tw = bb[2] - bb[0]
draw.text(((canvas_w - tw)//2, 12), "Diagrama de Navegacion de Interfaces - HiStesis", fill=TITLE_COLOR, font=font_title)

# Login screen center
login_img = load_thumb("login.png")
login_cx = canvas_w // 2
login_cy = login_area_h
draw_thumb(canvas, login_cx, login_cy, login_img, "Iniciar Sesion", (44, 62, 80), (210, 215, 220))

login_bottom = login_cy + THUMB_H // 2 + LABEL_H + 5

# Column centers
col_cxs = []
for i in range(3):
    col_cxs.append(MARGIN + 30 + i * col_w + THUMB_W // 2)

# Role labels
role_label_y = login_bottom + 18
for i, (key, style) in enumerate(ROLE_STYLES.items()):
    cx = col_cxs[i]
    bb = draw.textbbox((0,0), style["label"], font=font_role)
    tw = bb[2] - bb[0]
    th = bb[3] - bb[1]
    draw.rounded_rectangle([cx-tw//2-12, role_label_y-3, cx+tw//2+12, role_label_y+th+7], radius=8, fill=style["bg"], outline=style["border"], width=2)
    draw.text((cx-tw//2, role_label_y), style["label"], fill=style["border"], font=font_role)

# Arrows from login to role labels
arrow_mid_y = login_bottom + 8
for cx in col_cxs:
    draw.line([(login_cx, login_bottom), (login_cx, arrow_mid_y)], fill=ARROW, width=2)
    draw.line([(login_cx, arrow_mid_y), (cx, arrow_mid_y)], fill=ARROW, width=2)
    draw_arrow_v(draw, cx, arrow_mid_y, role_label_y - 3, ARROW, 2)

# Screens per role
for i, (key, screens) in enumerate(ROLES.items()):
    cx = col_cxs[i]
    style = ROLE_STYLES[key]
    y_cursor = role_label_y + roles_label_h + 10
    prev_bottom = None
    for fname, label in screens:
        img = load_thumb(fname)
        cy = y_cursor + THUMB_H // 2
        draw_thumb(canvas, cx, cy, img, label, style["border"], style["bg"])
        if prev_bottom is not None:
            draw = ImageDraw.Draw(canvas)
            draw_arrow_v(draw, cx, prev_bottom, cy - THUMB_H // 2 - 2, style["border"], 2)
        prev_bottom = cy + THUMB_H // 2 + LABEL_H + 4
        y_cursor += cell_height()

canvas.save(OUTPUT, "JPEG", quality=92)
print(f"Guardado: {OUTPUT}")
print(f"Tamano: {canvas.size[0]}x{canvas.size[1]} px")
