import asyncio
from playwright.async_api import async_playwright
from PIL import Image
import os

BASE = "http://127.0.0.1:3001"
OUT = r"C:\Users\Angel\Base-de-Datos-Tesis\screenshots"
os.makedirs(OUT, exist_ok=True)

PAGES = [
    ("01_home", "/"),
    ("02_login", "/login"),
    ("03_listado", "/bases"),
    ("04_buscar", "/bases/buscar"),
    ("05_nueva_tesis", "/bases/new"),
    ("06_revisar", "/bases/revisar"),
    ("07_historial", "/historial"),
    ("08_estadisticas", "/estadisticas"),
    ("09_zonas", "/zonas"),
    ("10_administrativo", "/administrativo"),
]

async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page(viewport={"width": 1280, "height": 900})
        
        for name, path in PAGES:
            url = BASE + path
            try:
                await page.goto(url, wait_until="networkidle", timeout=10000)
                await page.wait_for_timeout(1000)
                filepath = os.path.join(OUT, f"{name}.png")
                await page.screenshot(path=filepath, full_page=False)
                print(f"OK: {name} -> {url}")
            except Exception as e:
                print(f"ERROR: {name} -> {url}: {e}")
        
        await browser.close()

asyncio.run(main())
print("\nCapturas completadas en:", OUT)
