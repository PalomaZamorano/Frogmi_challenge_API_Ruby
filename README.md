# Frogmi

## Introducción
Desafío para desarrollador Frogmi de consumo de data https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson mediante API RoR
    
## Stack

### Lenguaje

- Ruby 3.2.0
- Rails 7.1.3.2

## Setup proyecto

### Cómo hacer correr el proyecto desde cero

Instalar gemas

```bash
bundle install
```

Migrar migraciones pendientes 

```bash
rails db:migrate
```
Poblar base de datos mediante task que consume url y guarda en Base de Datos

```bash
  bin/rake task:get_features_data_task
```
### Ejecutar proyecto

```bash
  rails server
```

## Url API
- Agregar comentarios según id del feature
  
```bash
   POST http://localhost/api/v1/features/:feature_id/comments
  {
    "comment": {
      "body": "Este es mi comentario sobre el feature."
    }
  }
```
- Ver comentarios por feature
  
```bash
  GET http://localhost/api/v1/features/:feature_id/comments
```
- Filtrar features según tipo de magnitud
  - per_page: entero que indica cantidad de datos por página
  - page:  página en la que se encuentra la data
```bash
  GET http://localhost/api/v1/features?page=${:page}&per_page=${:per_page}
  {
    "filters": {
      "mag_types": ["mww", "md"] #u otro según se requiera
    }
  }
```

## Ejemplos de retorno 

![image](https://github.com/PalomaZamorano/Frogmi_challenge_API_Ruby/assets/31086486/a15923c9-afd5-4893-b5f6-becc21da89b3)

![image](https://github.com/PalomaZamorano/Frogmi_challenge_API_Ruby/assets/31086486/5beb4ccd-f62d-4d36-ab03-be0eb9900e94)

![image](https://github.com/PalomaZamorano/Frogmi_challenge_API_Ruby/assets/31086486/9d7fc523-e871-4563-9aff-d3a72b4bcf8d)


