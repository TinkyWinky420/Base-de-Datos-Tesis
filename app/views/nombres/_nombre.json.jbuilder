json.extract! nombre, :id, :titulo, :descripcion, :created_at, :updated_at
json.url nombre_url(nombre, format: :json)
