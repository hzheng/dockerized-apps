# Gitea Local Git Host

This directory contains the Docker Compose configuration for running Gitea as a local Git hosting service.

## Services

- **Gitea**: The main Git hosting service (latest version 1.21) with SQLite database

## Setup

1. Configure environment variables in the main `.env` file (already set with sensible defaults):
   - `GITEA_HTTP_PORT=3001`: Port for Gitea web interface
   - `GITEA_SSH_PORT=2222`: Port for Git SSH access (uses 2222 to avoid conflicts)
   - `GITEA_DOMAIN=localhost`: Domain name or IP address
   - `GITEA_ADMIN_EMAIL=admin@localhost`: Email address for admin notifications
   - `GITEA_DISABLE_REGISTRATION=true`: Disable new user registration
   - `GITEA_REQUIRE_SIGNIN_VIEW=false`: Allow anonymous repository browsing
   - `GITEA_SUBNET_PREFIX=172.11.131`: Network subnet prefix

2. Run the setup script from the project root:
   ```bash
   ./dock.sh gitea
   ```

## Access

After starting the services:

- **Web Interface**: `http://localhost:3001` (or your configured domain/port)
- **Git SSH**: Use port `2222` for Git operations over SSH
- **Git HTTPS**: Also available via the web interface port

## First Run

1. Navigate to the web interface at `http://localhost:3001`
2. Complete the initial setup wizard
3. Create your first admin user
4. Start creating repositories!

## Features

- Full Git hosting with web interface
- Issue tracking and project management
- Pull/merge requests
- Wiki support
- Email notifications via postfix
- SSH access for Git operations (port 2222)
- HTTPS access for Git operations
- SQLite database (perfect for personal use)

## Data Persistence

All Gitea data is stored in `${DOCKER_VOLUMES}/gitea/data/`:
- Contains the SQLite database file
- Repository data
- Configuration files
- User uploads and attachments

## Network Integration

This setup integrates with the existing infrastructure:
- Uses the `postfix_network` for email notifications
- Logs to `rsyslog` for centralized logging
- Uses bind mounts for persistent data storage
- Environment variables managed via the main `.env` file (symlinked)

## Why SQLite?

For personal Git hosting, SQLite is an excellent choice because:
- ✅ Zero configuration - no separate database container needed
- ✅ File-based storage - easy to backup
- ✅ Excellent performance for small to medium workloads
- ✅ Built into Gitea - no additional dependencies
- ✅ Perfect for single-user or small team scenarios

## Git Operations

You can use either SSH or HTTPS for Git operations:

### SSH (Recommended)
```bash
# Clone a repository
git clone ssh://git@localhost:2222/username/repository.git

# Add remote
git remote add origin ssh://git@localhost:2222/username/repository.git
```

### HTTPS
```bash
# Clone a repository
git clone http://localhost:3001/username/repository.git

# Add remote
git remote add origin http://localhost:3001/username/repository.git
```

## Port Configuration

- **SSH Port 2222**: Used instead of standard port 22 to avoid conflicts
- **HTTP Port 3001**: Different from Redmine's 3000 to avoid conflicts

## Customization

To modify any settings, edit the main `.env` file in the project root. The `gitea/.env` file is a symlink to the main configuration file, following the same pattern as other apps in this project. 
