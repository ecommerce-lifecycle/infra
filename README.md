# Infra – Docker Compose Stack

This repo orchestrates the full local stack:  
**Zookeeper + Kafka + Postgres + pgAdmin + Catalog Service**

---

## Folder Layout
````

/ecommerce-lifecycle/
│
├── catalog-service/
│   ├── CatalogDockerfile
│   ├── wait-for-it.sh
│   └── (Spring Boot code)
│
└── infra/
    ├── docker-compose.yml
    ├── docker-restart.bat
    └── postgres/
        └── init.sql   <-- seed data

````

---

## 🛠️ Technologies & Tools Used

* **PostgreSQL 16** – Relational Database  
* **Kafka (Confluent Platform)** – Event streaming & messaging  
* **Docker & Docker Compose** – Containerization & orchestration  
* **pgAdmin4** – PostgreSQL database management (UI)  
* **Eclipse STS / IntelliJ IDEA / VS Code** – IDEs for development (choose any)  

---
## Services & Ports

| Service         | URL / Port                                                |
| --------------- | --------------------------------------------------------- |
| Catalog Service | [http://localhost:8081](http://localhost:8081)            |
| PostgreSQL      | localhost:5432                                            |
| pgAdmin         | [http://localhost:5050](http://localhost:5050)            |
| Kafka Broker    | localhost:9092 (internal) / localhost:29092 (host access) |
| Zookeeper       | localhost:2181                                            |

---

## Usage and maintenance

### Start all
```bash
cd infra
docker compose up -d --build
````

### Check status & logs of containers

```bash
docker compose ps
docker compose logs -f            # all services
docker logs -f catalog-service    # specific service
docker logs -f kafka			  # kafka service
```

### Shell Access

```bash
docker exec -it catalog-service sh
docker exec -it kafka bash
```

### Stop & clean

```bash
docker compose stop               # stop containers
docker compose down               # stop & remove
docker compose down -v            # also remove DB volumes
```

---

## 📦 Database Access (pgAdmin)

👉 **Note**:
If you want to change pgAdmin login, update values in `docker-compose.yml` under `PGADMIN_DEFAULT_EMAIL` & `PGADMIN_DEFAULT_PASSWORD`.

* Open [http://localhost:5050](http://localhost:5050)

* Default login (from `docker-compose.yml`):

  * Email: `admin@local.com`
  * Password: `admin`

* Add new server in pgAdmin:

  * Host: `postgres`
  * Port: `5432`
  * DB: `catalog_db`
  * User: `postgres`
  * Password: `postgres`

---

### 🖥️ Local Database Access (outside container)

You can also connect directly using your **local pgAdmin4 desktop app** or **psql shell**:

* Connection details:
  * Host: `localhost`
  * Port: `5432`
  * Database: `catalog_db`
  * Username: `postgres`
  * Password: `postgres`
  
---

## Troubleshooting

* **Docker Desktop not running** → Start Docker Desktop first.
* **`no main manifest attribute, in app.jar`** → Check Spring Boot plugin config in `pom.xml`.
* **`localhost:8081 refused`** → Run `docker compose ps` → verify container is up & port 8081 exposed.
* **pgAdmin login fails** → Use credentials from `docker-compose.yml`.
* **Kafka/Zookeeper retries** → Wait, broker eventually connects.
* **Kafka Cluster ID issue**
    If Kafka/Zookeeper mismatch → delete state and restart:

    ```bash
    rmdir /s /q infra\kafka-data
    rmdir /s /q infra\zookeeper-data
    rmdir /s /q infra\postgres-data
    ```

---

## Clean rebuild

```bash
cd infra
docker compose down -v
docker compose up -d --build
```

---

## 🛠️ Helpers

A script `docker-restart.bat` is included (Windows).
It does:

1. Stop & remove all containers + volumes
2. Delete local data folders (`kafka-data`, `zookeeper-data`, `postgres-data`)
3. Rebuild images (no cache)
4. Start containers

Usage (from `infra` folder):

```cmd
docker-restart.bat
```

---

### ⏳ Wait-for-it Script

The `wait-for-it.sh` script ensures that dependent services (like PostgreSQL) are up
before the `catalog-service` container starts.  

- It is automatically copied into the catalog container via its Dockerfile.  
- Uses **LF line endings** (Linux format). If you are on Windows, run:

```bash
dos2unix wait-for-it.sh
```

---
