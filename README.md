# CICD6 - Flask Messages App with Docker

🚀 **Aplicație web containerizată cu Docker, Flask și PostgreSQL**

## 📋 Descriere

Acest proiect demonstrează utilizarea **Docker** pentru containerizarea unei aplicații web Flask cu bază de date PostgreSQL, folosind practici moderne de securitate și orchestrare.

**Autor:** DiacovCatalin  
**Tehnologii:** Flask, PostgreSQL, Docker, Docker Compose

## 🛠️ Tehnologii Folosite

### Backend
- **Flask 2.3.3** - Framework web Python
- **psycopg2-binary** - Driver PostgreSQL
- **Gunicorn** - WSGI server

### Database
- **PostgreSQL 15** - Bază de date relațională
- **Persistență date** cu volume Docker

### Containerization & Orchestration
- **Docker** - Container engine (industry standard)
- **Docker Compose** - Orchestration multi-container
- **Dockerfile** - Definiție imagine (standard Docker)

## 🏗️ Structura Proiectului

```
CICD6/
├── application.py           # Aplicația Flask principală
├── Dockerfile              # Definiție imagine Docker pentru Flask
├── Dockerfile.db           # Definiție imagine Docker pentru PostgreSQL
├── requirements.txt        # Dependințe Python
├── docker-compose.yml      # Configurare orchestrare
├── init.sql               # Script inițializare bază de date
├── .env                   # Variabile de mediu pentru testare locală
├── .env.compose           # Variabile de mediu pentru docker-compose
├── Walkthrough.md         # Ghid complet pas cu pas
├── RESET_DATABASE.md      # Ghid pentru resetarea bazei de date
├── templates/
│   └── index.html         # Template HTML
└── README.md              # Documentație
```

## 🚀 Quick Start

### Prerechizite

1. **Instalare Docker Desktop:**
   - **Windows:** Descarcă de la [docker.com](https://www.docker.com/products/docker-desktop)
   - **macOS:** Descarcă de la [docker.com](https://www.docker.com/products/docker-desktop)
   - **Linux:** `sudo apt install docker.io docker-compose`

2. **Verificare instalare:**
   ```bash
   docker --version
   docker-compose version
   ```

### Opțiunea 1: Docker Compose (Recomandat)

1. **Clonare repository:**
   ```bash
   git clone https://github.com/alephnil/CICD6.git
   cd CICD6
   ```

2. **Construire și pornire servicii:**
   ```bash
   docker-compose up --build
   ```

3. **Accesare aplicație:**
   - **URL:** http://localhost:5000
   - **Health Check:** http://localhost:5000/health

4. **Oprire servicii:**
   ```bash
   docker-compose down
   ```

### Opțiunea 2: Imagini Docker Individuale

1. **Build imagini:**
   ```bash
   docker build -t alephnil/cicd6-flask-app -f Dockerfile .
   docker build -t alephnil/cicd6-postgres-db -f Dockerfile.db .
   ```

2. **Creare rețea:**
   ```bash
   docker network create cicd6-network
   ```

3. **Pornire database:**
   ```bash
   docker run -d --name cicd6-db --network cicd6-network -p 5432:5432 -v postgres_data:/var/lib/postgresql/data alephnil/cicd6-postgres-db
   ```

4. **Așteptare 30 secunde** pentru inițializarea bazei de date

5. **Pornire Flask app:**
   ```bash
   docker run -d --name cicd6-app --network cicd6-network -p 5000:5000 alephnil/cicd6-flask-app
   ```

6. **Accesare aplicație:** http://localhost:5000

## 📦 Imagini Docker Hub

Proiectul include două imagini publice pe Docker Hub:

- **Flask App:** [alephnil/cicd6-flask-app](https://hub.docker.com/r/alephnil/cicd6-flask-app)
- **PostgreSQL DB:** [alephnil/cicd6-postgres-db](https://hub.docker.com/r/alephnil/cicd6-postgres-db)

### Utilizare imagini din Docker Hub:

```bash
# Database
docker run -d --name hub-db --network cicd6-network -p 5432:5432 -v postgres_data:/var/lib/postgresql/data alephnil/cicd6-postgres-db:latest

# Flask app
docker run -d --name hub-app --network cicd6-network -p 5000:5000 -e DB_HOST=hub-db -e DB_PORT=5432 -e DB_NAME=messages_db -e DB_USER=postgres -e DB_PASSWORD=postgres alephnil/cicd6-flask-app:latest
```

## 🐳 Comenzi Docker Utile

### Construire Imagini
```bash
docker build -t alephnil/cicd6-flask-app -f Dockerfile .
docker build -t alephnil/cicd6-postgres-db -f Dockerfile.db .
```

### Rulare Containere
```bash
docker run -d --name cicd6-db --network cicd6-network -p 5432:5432 -v postgres_data:/var/lib/postgresql/data alephnil/cicd6-postgres-db
docker run -d --name cicd6-app --network cicd6-network -p 5000:5000 alephnil/cicd6-flask-app
```

### Management Containere
```bash
docker ps                    # Listează containere active
docker ps -a                 # Listează toate containerele
docker logs cicd6-db         # Vizualizează log-uri database
docker logs cicd6-app        # Vizualizează log-uri aplicație
docker stop cicd6-app cicd6-db    # Oprește containere
docker rm cicd6-app cicd6-db      # Șterge containere
```

### Management Volume
```bash
docker volume ls             # Listează volume
docker volume inspect postgres_data  # Inspectează volum
docker volume rm postgres_data       # Șterge volum
```

## 🔧 Configurare Mediului

### Variabile de Mediu
- `DB_HOST` - Host bază de date (default: cicd6-db)
- `DB_PORT` - Port bază de date (default: 5432)
- `DB_NAME` - Nume bază de date (default: messages_db)
- `DB_USER` - Utilizator PostgreSQL (default: postgres)
- `DB_PASSWORD` - Parolă PostgreSQL (default: postgres)

### Volume Persistente
- `postgres_data` - Date PostgreSQL
- Asigură persistența datelor între repornirile containerelor

## 🛡️ Securitate Docker

### Bune Practici
- Utilizare non-root user în containere
- Volume pentru persistența datelor
- Health checks pentru monitorizare
- Network isolation între servicii
- Variabile de mediu pentru configurare

### Avantaje Docker
- ✅ **Compatibilitate multi-platformă** - Windows, Linux, macOS
- ✅ **Ecosistem matur** - Tool-uri și documentație extensivă
- ✅ **Standard industrial** - Folosit de majoritatea companiilor
- ✅ **Ușor de utilizat** - Interfață GUI și CLI intuitive

## 🌐 API Endpoints

| Endpoint | Metodă | Descriere |
|----------|--------|----------|
| `/` | GET | Afișare mesaje |
| `/add` | POST | Adăugare mesaj nou |
| `/health` | GET | Health check |

## 📊 Monitorizare

### Health Checks
```bash
# Verificare stare servicii
docker-compose ps

# Health check individual
curl http://localhost:5000/health
```

### Log-uri
```bash
# Log-uri aplicație
docker logs cicd6-app

# Log-uri bază de date
docker logs cicd6-db
```

## 🔍 Troubleshooting

### Probleme Comune

1. **Port deja folosit:**
   ```bash
   docker-compose down
   docker ps -a
   docker rm $(docker ps -aq)
   ```

2. **Probleme conectare bază de date:**
   ```bash
   docker logs cicd6-db
   docker-compose restart db
   ```

3. **Resetare completă baze de date:**
   ```bash
   docker-compose down -v
   docker-compose up --build
   ```

4. **Docker Desktop nu pornește:**
   - Verifică dacă virtualizarea este activată în BIOS
   - Restart Docker Desktop
   - Reinstalează Docker Desktop dacă este necesar

## 📝 Note Importante

- Acest proiect folosește **Docker** pentru compatibilitate maximă
- Complet compatibil cu Docker Hub și alte registries
- Poate fi rulat pe orice sistem cu Docker instalat
- Suportă atât development cât și production
- Datele persistă în volume Docker independente de containere

## 📚 Documentație Suplimentară

- **Walkthrough.md** - Ghid complet pas cu pas pentru homework
- **RESET_DATABASE.md** - Instrucțiuni pentru resetarea bazei de date
- **Docker Hub** - Imagini publice pentru deployment

---

**Laborator 6 - Containerizare cu Docker**  
*Creat de DiacovCatalin © 2025*