# CICD6 - Flask Messages App with Docker

🚀 **Aplicație web containerizată cu Docker, Flask și PostgreSQL**

## 📋 Descriere

Acest proiect demonstrează utilizarea **Docker** pentru containerizarea unei aplicații web Flask cu bază de date PostgreSQL, folosind practici moderne de securitate și orchestrare.

**Autor:** DiacovCatalin  
**Tehnologii:** Flask, PostgreSQL, Docker, Docker Compose

## 🖥️ **IMPORTANT: Windows Users**

📖 **For detailed step-by-step Windows instructions, see: [`DOCKER-WINDOWS-WALKTHROUGH.md`](DOCKER-WINDOWS-WALKTHROUGH.md)**

The walkthrough includes:
- Docker Desktop installation on Windows
- Detailed explanations of every command
- Windows-specific troubleshooting
- Complete guide from zero to Docker Hub

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
├── Dockerfile              # Definiție imagine Docker
├── requirements.txt        # Dependințe Python
├── docker-compose.yml      # Configurare orchestrare
├── init.sql               # Script inițializare bază de date
├── DOCKER-WINDOWS-WALKTHROUGH.md  # Ghid detaliat Windows
├── templates/
│   └── index.html         # Template HTML
└── README.md              # Documentație
```

## 🚀 Quick Start (Windows/Linux/macOS)

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

### Pași de Rulare

1. **Clonare repository:**
   ```bash
   git clone <repository-url>
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

## 🐳 Comenzi Docker

### Construire Imagine
```bash
docker build -t cicd6-flask-app .
```

### Rulare Container Individual
```bash
docker run -d --name flask-app -p 5000:5000 cicd6-flask-app
```

### Listare Containere
```bash
docker ps
docker ps -a  # Toate containerele
```

### Vizualizare Log-uri
```bash
docker logs flask-app
docker-compose logs app
docker-compose logs db
```

## 📦 Publicare pe Docker Hub

### 1. Autentificare Docker Hub
```bash
docker login docker.io
```

### 2. Taguire Imagine
```bash
docker tag cicd6-flask-app docker.io/DiacovCatalin/cicd6-flask-app:latest
```

### 3. Publicare
```bash
docker push docker.io/DiacovCatalin/cicd6-flask-app:latest
```

### 4. Verificare
```bash
docker pull docker.io/DiacovCatalin/cicd6-flask-app:latest
```

## 🔧 Configurare Mediului

### Variabile de Mediu
- `DB_HOST` - Host bază de date (default: localhost)
- `DB_NAME` - Nume bază de date (default: messages_db)
- `DB_USER` - Utilizator PostgreSQL (default: postgres)
- `DB_PASSWORD` - Parolă PostgreSQL (default: postgres)

### Volume Persistente
- `postgres_data` - Date PostgreSQL
- `app_logs` - Log-uri aplicație

## 🛡️ Securitate Docker

### Bune Practici
- Utilizare non-root user în containere
- Volume pentru persistența datelor
- Health checks pentru monitorizare
- Network isolation între servicii

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
docker-compose logs -f app

# Log-uri bază de date
docker-compose logs -f db
```

## 🔍 Troubleshooting

### Probleme Comune

1. **Port deja folosit:**
   ```bash
   # Verificare porturi
   docker ps
   # Oprire servicii
   docker-compose down
   ```

2. **Probleme conectare bază de date:**
   ```bash
   # Verificare stare database
   docker-compose logs db
   # Restart serviciu
   docker-compose restart db
   ```

3. **Permisiuni volume:**
   ```bash
   # Verificare volume
   docker volume ls
   # Ștergere volume
   docker volume rm cicd6_postgres_data cicd6_app_logs
   ```

4. **Docker Desktop nu pornește:**
   - Verifică dacă virtualizarea este activată în BIOS
   - Restart Docker Desktop
   - Reinstalează Docker Desktop dacă este necesar

## 🚀 Avansat

### Kubernetes Integration
```bash
# Generare YAML Kubernetes
docker compose convert

# Deploy în Kubernetes
kubectl apply -f docker-compose.yaml
```

### Docker Swarm
```bash
# Inițializare Swarm
docker swarm init

# Deploy în Swarm
docker stack deploy -c docker-compose.yml cicd6
```

## 📝 Note

- Acest proiect folosește **Docker** pentru compatibilitate maximă cu Windows
- Complet compatibil cu Docker Hub și alte registries
- Poate fi rulat pe orice sistem cu Docker instalat
- Suportă atât development cât și production

---

**Laborator 6 - Containerizare cu Docker**  
*Creat de DiacovCatalin © 2024*