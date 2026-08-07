class ModoSoloLectura
  def initialize(app)
    @app = app
  end

  def call(env)
    if ENV["READ_ONLY"] == "true" && !lectura_permitida?(env)
      [403, { "content-type" => "text/html; charset=utf-8" }, [pagina]]
    else
      @app.call(env)
    end
  end

  private

  def lectura_permitida?(env)
    %w[GET HEAD OPTIONS].include?(env["REQUEST_METHOD"])
  end

  def pagina
    <<~HTML
      <!DOCTYPE html>
      <html lang="es">
        <head>
          <meta charset="utf-8">
          <title>Solo lectura</title>
          <style>
            body{font-family:system-ui,sans-serif;background:#f2f5f9;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0}
            .caja{background:#fff;border-radius:14px;padding:40px;max-width:460px;box-shadow:0 8px 24px rgba(0,0,0,.08);text-align:center}
            h1{color:#1f3a5f;margin:0 0 10px;font-size:22px}
            p{color:#5a6b7c;line-height:1.6;margin:0}
          </style>
        </head>
        <body>
          <div class="caja">
            <h1>Modo solo lectura</h1>
            <p>Esta aplicación está abierta solo para consulta. No se pueden realizar modificaciones.</p>
          </div>
        </body>
      </html>
    HTML
  end
end
