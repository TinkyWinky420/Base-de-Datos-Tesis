import asyncio
from playwright.async_api import async_playwright
import os

BASE = "http://127.0.0.1:3001"
OUT = r"C:\Users\Angel\Base-de-Datos-Tesis\screenshots"
os.makedirs(OUT, exist_ok=True)

async def login(page, username, password):
    await page.goto(f"{BASE}/login", wait_until="networkidle", timeout=10000)
    await page.wait_for_timeout(500)
    await page.fill('input[name="usuario"]', username)
    await page.fill('input[name="password"]', password)
    await page.click('input[type="submit"], button[type="submit"]')
    await page.wait_for_timeout(1500)

async def screenshot(page, name):
    path = os.path.join(OUT, f"{name}.png")
    await page.screenshot(path=path, full_page=False)
    print(f"  OK: {name}")

async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        
        # ============ LOGIN (no session) ============
        page = await browser.new_page(viewport={"width": 1280, "height": 900})
        await page.goto(f"{BASE}/login", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "login")
        
        # ============ ALUMNO ============
        print("\n--- ALUMNO ---")
        await login(page, "alumno", "1234")
        await screenshot(page, "alumno_home")
        
        # Registrar tesis
        await page.goto(f"{BASE}/bases/new", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "alumno_registrar")
        
        # Revisar tesis
        await page.goto(f"{BASE}/bases/revisar", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "alumno_revisar")
        
        # Logout
        await page.goto(f"{BASE}/logout", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(500)
        
        # ============ ASESOR ============
        print("\n--- ASESOR ---")
        await login(page, "asesor", "1234")
        await screenshot(page, "asesor_buscar")
        
        # Listado
        await page.goto(f"{BASE}/bases", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "asesor_listado")
        
        # Historial
        await page.goto(f"{BASE}/historial", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "asesor_historial")
        
        # Estadisticas
        await page.goto(f"{BASE}/estadisticas", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "asesor_estadisticas")
        
        # Logout
        await page.goto(f"{BASE}/logout", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(500)
        
        # ============ ADMINISTRATIVO ============
        print("\n--- ADMINISTRATIVO ---")
        await login(page, "administrativo", "1234")
        await screenshot(page, "admin_dashboard")
        
        # Listado
        await page.goto(f"{BASE}/bases", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "admin_listado")
        
        # Buscar
        await page.goto(f"{BASE}/bases/buscar", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "admin_buscar")
        
        # Historial
        await page.goto(f"{BASE}/historial", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "admin_historial")
        
        # Estadisticas
        await page.goto(f"{BASE}/estadisticas", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "admin_estadisticas")
        
        # Zonas
        await page.goto(f"{BASE}/zonas", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "admin_zonas")
        
        # Carreras por plantel
        await page.goto(f"{BASE}/plantel_carreras", wait_until="networkidle", timeout=10000)
        await page.wait_for_timeout(1000)
        await screenshot(page, "admin_carreras")
        
        await browser.close()
        print("\nTodas las capturas completadas")

asyncio.run(main())
