# CICD6 Homework - Complete Step-by-Step Walkthrough

## Prerequisites
- GitHub account
- CICD6-main folder with all files
- Docker Desktop installed (https://www.docker.com/products/docker-desktop)

---

## Step 1: Setup GitHub Repository

1. **Create new repository on GitHub:**
   - Go to https://github.com
   - Click "+" → "New repository"
   - Name: `CICD6`
   - Description: `Laborator 6 - Docker Flask Application`
   - Make it Public
   - Click "Create repository"

2. **Initialize local repository:**
   ```bash
   cd CICD6-main
   git init
   git add .
   git commit -m "Initial commit - Flask app with Docker"
   ```

3. **Connect to GitHub:**
   ```bash
   git remote add origin https://github.com/alephnil/CICD6.git
   git branch -M main
   git push -u origin main
   ```
   (Replace `alephnil` with your actual GitHub username)

---

## Step 2: Create Docker Hub Account

1. **Sign up for Docker Hub:**
   - Go to https://hub.docker.com
   - Click "Sign Up"
   - Create account (use same username as GitHub if possible)
   - Verify email

---

## Step 3: Create Environment Configuration

1. **Navigate to project folder:**
   ```bash
   cd CICD6-main
   ```

2. **Create .env file:**
   - The `.env` file should already exist in your folder
   - If missing, create it with these contents:
   ```env
   # Flask Application Configuration
   PORT=5000
   SECRET_KEY=dev-secret-key-change-in-production
   DEBUG=True

   # Database Configuration
   DB_HOST=cicd6-db
   DB_PORT=5432
   DB_NAME=messages_db
   DB_USER=postgres
   DB_PASSWORD=postgres
   DB_SSL_MODE=disable

   # PostgreSQL Configuration
   POSTGRES_INITDB_ARGS=--encoding=UTF-8 --lc-collate=C --lc-ctype=C
   ```

---

## Step 4: Build BOTH Docker Images

1. **Build the Flask app image:**
   ```bash
   docker build -t alephnil/cicd6-flask-app -f Dockerfile .
   ```

2. **Build the database image:**
   ```bash
   docker build -t alephnil/cicd6-postgres-db -f Dockerfile.db .
   ```

3. **Verify both images exist:**
   ```bash
   docker images
   ```
   You should see both images:
   - `alephnil/cicd6-flask-app`
   - `alephnil/cicd6-postgres-db`

---

## Step 5: Test BOTH Images Locally

1. **Create Docker network:**
   ```bash
   docker network create cicd6-network
   ```

2. **Run the database container:**
   ```bash
   docker run -d --name cicd6-db --network cicd6-network -p 5432:5432 -v postgres_data:/var/lib/postgresql/data alephnil/cicd6-postgres-db
   ```

3. **Wait for database to be ready (30 seconds):**
   ```bash
   docker logs cicd6-db
   ```
   Wait until you see "database system is ready to accept connections"

4. **Run the Flask app container:**
   ```bash
   docker run -d --name cicd6-app --network cicd6-network -p 5000:5000 alephnil/cicd6-flask-app
   ```

5. **Test the application:**
   - Open browser: http://localhost:5000
   - Add a test message
   - Verify it appears in the list
   - Check health endpoint: http://localhost:5000/health

6. **Stop both containers:**
   ```bash
   docker stop cicd6-app cicd6-db
   docker rm cicd6-app cicd6-db
   ```

---

## Step 6: Push BOTH Images to Docker Hub

1. **Login to Docker Hub:**
   ```bash
   docker login
   ```
   Enter your Docker Hub username and password

2. **Push the Flask app image:**
   ```bash
   docker push alephnil/cicd6-flask-app:latest
   ```

3. **Push the database image:**
   ```bash
   docker push alephnil/cicd6-postgres-db:latest
   ```

4. **Verify on Docker Hub:**
   - Go to https://hub.docker.com
   - Check your repositories
   - Verify both images appear

---

## Step 7: Test Docker Hub Images

1. **Remove local images:**
   ```bash
   docker rmi alephnil/cicd6-flask-app alephnil/cicd6-postgres-db
   ```

2. **Pull both images from Docker Hub:**
   ```bash
   docker pull alephnil/cicd6-flask-app:latest
   docker pull alephnil/cicd6-postgres-db:latest
   ```

3. **Run from Docker Hub:**
   ```bash
   # Database with persistent data volume
   docker run -d --name hub-db --network cicd6-network -p 5432:5432 -v postgres_data:/var/lib/postgresql/data alephnil/cicd6-postgres-db:latest

   # Wait 30 seconds for database

   # Flask app
   docker run -d --name hub-app --network cicd6-network -p 5000:5000 -e DB_HOST=hub-db -e DB_PORT=5432 -e DB_NAME=messages_db -e DB_USER=postgres -e DB_PASSWORD=postgres alephnil/cicd6-flask-app:latest
   ```

4. **Test the application:**
   - Open browser: http://localhost:5000
   - Verify it works

5. **Cleanup:**
   ```bash
   docker stop hub-app hub-db
   docker rm hub-app hub-db
   ```

---

## Step 8: Test with Docker Compose (Alternative)

1. **Test with docker-compose:**
   ```bash
   docker-compose up --build
   ```
   - Test at: http://localhost:5000
   - Stop: `docker-compose down`

---

## Step 9: Final Verification

1. **Check all components work:**
   ```bash
   # Test individual images with persistent data volume
   docker run -d --name final-db --network cicd6-network -p 5432:5432 -v postgres_data:/var/lib/postgresql/data alephnil/cicd6-postgres-db:latest

   # Wait 30 seconds

   docker run -d --name final-app --network cicd6-network -p 5000:5000 -e DB_HOST=final-db -e DB_PORT=5432 -e DB_NAME=messages_db -e DB_USER=postgres -e DB_PASSWORD=postgres alephnil/cicd6-flask-app:latest
   ```
   - Application loads at http://localhost:5000
   - Can add and view messages
   - Database persistence works

2. **Push final changes to GitHub:**
   ```bash
   git add .
   git commit -m "Complete CICD6 homework with separate images"
   git push origin main
   ```

---

## Step 10: Homework Submission

### What to submit:
1. **GitHub Repository URL:** https://github.com/alephnil/CICD6
2. **Docker Hub Flask App URL:** https://hub.docker.com/r/alephnil/cicd6-flask-app
3. **Docker Hub Database URL:** https://hub.docker.com/r/alephnil/cicd6-postgres-db
4. **Screenshot of running application** at http://localhost:5000

### Verification checklist:
- ✅ Flask application works
- ✅ Dockerfile builds Flask app image successfully
- ✅ Dockerfile.db builds database image successfully
- ✅ Both images run independently with docker run
- ✅ Both images published on Docker Hub
- ✅ Code pushed to GitHub

---

## Troubleshooting

### Database connection issues:
```bash
# Check database logs
docker logs cicd6-db

# Wait longer for database to start
sleep 30

# Check network
docker network ls
docker network inspect cicd6-network
```

### Port conflicts:
```bash
# Stop all containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# Remove network
docker network rm cicd6-network
```

### Image build issues:
```bash
# Clean build
docker builder prune
docker build --no-cache -t alephnil/cicd6-flask-app -f Dockerfile .
docker build --no-cache -t alephnil/cicd6-postgres-db -f Dockerfile.db .
```

---

## Commands Summary

```bash
# Build both images
docker build -t alephnil/cicd6-flask-app -f Dockerfile .
docker build -t alephnil/cicd6-postgres-db -f Dockerfile.db .

# Create network
docker network create cicd6-network

# Run both containers
docker run -d --name cicd6-db --network cicd6-network -p 5432:5432 alephnil/cicd6-postgres-db
docker run -d --name cicd6-app --network cicd6-network -p 5000:5000 alephnil/cicd6-flask-app

# Push to Docker Hub
docker push alephnil/cicd6-flask-app:latest
docker push alephnil/cicd6-postgres-db:latest

# Cleanup
docker stop cicd6-app cicd6-db
docker rm cicd6-app cicd6-db
docker network rm cicd6-network
```

---

**Done!** You now have TWO separate Docker images that work together independently.