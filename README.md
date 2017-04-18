# README

### Docker

[docker installation](https://docs.docker.com/engine/installation/)

To restart production containers use *docker/restart_production.sh*

To access shell in production containers (http://bangbang.mystand.ru), use the following scripts:

* *docker/rsh_backend.sh*

* *docker/rsh_frontend.sh*

* *docker/rsh_postgres.sh*

docker-compose.yml example for development

```yaml
version: '3'
services:
  frontend:
    image: dr.mystand.ru/bangbang/frontend:dev
    ports:
      - 4000:4000
    volumes:
      - ./frontend/:/app
  backend:
    image: dr.mystand.ru/bangbang/backend:dev
    ports:
      - 3000:3000
    volumes:
      - ./backend/:/app
      - backend_bundle:/usr/local/bundle
  changes_notifier:
    image: dr.mystand.ru/changes-notifier
    ports:
      - 5000:80
    volumes:
      - ./changes-notifier/config.js:/app/src/config.js
    environment:
      PGUSER: root
      PGPASSWORD: 123qwe
    depends_on:
      - postgres
  postgres:
    image: mdillon/postgis
    volumes:
      - db_data:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: root
      POSTGRES_PASSWORD: 123qwe

volumes:
  db_data:
  backend_bundle:
```

### Run development server

```bash
mkdir bangbang && cd bangbang
```
create *docker-compose.yml* from example
```bash
git clone git@bitbucket.org:mystand/bangbang-backend.git backend
git clone git@bitbucket.org:mystand/bangbang-frontend.git frontend
cp backend/config/database.yml.example backend/config/database.yml
cp backend/config/secrets.yml.example backend/config/secrets.yml
cp frontend/src/config.js.example frontend/src/config.js
```
in *backend/config/database.yml* specify:
```yaml
  host: postgres
  user: root
  password: 123qwe
```
create db:
```bash
docker-compose up -d postgres
docker-compose run backend bash -c "bundle && rake db:create && rake db:seed"
```
start up servers & show logs:
```bash
docker-compose up -d
docker-compose logs -f
```