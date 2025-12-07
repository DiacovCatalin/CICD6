# How to Completely Reset the Database

## Quick Reset (Removes all data)
```bash
# Stop and remove containers + volumes
docker-compose down -v

# Rebuild and start fresh
docker-compose up --build
```

## Step-by-Step Explanation

1. **See your volumes:**
   ```bash
   docker volume ls
   ```
   You'll see something like:
   ```
   local     cicd6_postgres_data
   local     cicd6_app_logs
   ```

2. **Stop containers and remove volumes:**
   ```bash
   docker-compose down -v
   ```
   The `-v` flag removes the named volumes

3. **Verify volumes are gone:**
   ```bash
   docker volume ls
   ```
   The cicd6 volumes should be gone

4. **Start fresh:**
   ```bash
   docker-compose up --build
   ```
   This creates new volumes and runs init.sql again

## What Happens Without -v
```bash
docker-compose down        # Removes containers only
docker-compose down -v     # Removes containers + volumes
```

## This is Actually a Good Feature!
- **Data persistence** - Your data survives container restarts
- **Development friendly** - You can restart containers without losing data
- **Production ready** - Database data is safe from container failures

## When to Use Each
- **Normal development:** `docker-compose down` (keeps data)
- **Testing fresh install:** `docker-compose down -v` (removes data)
- **Starting over:** `docker-compose down -v` then `docker-compose up --build`