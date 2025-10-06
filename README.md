# github-file-server
At every restart this container will clone the contents of a specified github repository and serve the contents of that repository as a CIFS share.  This is a simple way to create a file server in multiple training environments that can be managed centrally.

## Setup

### Option 1: Public Repository (HTTPS)

1. **Create a `.env` file in the project root with the following content:**

   ```env
   GIT_REPO_URL=https://github.com/your/repo.git
   ```

   Replace the URL with your desired Git repository.

### Option 2: Private Repository with SSH Deploy Keys

1. **Generate a deployment key:**

   ```bash
   ssh-keygen -t ed25519 -f ./deploy_key -N ""
   ```

2. **Add the public key to your GitHub repository:**
   - Go to your repository on GitHub
   - Navigate to Settings → Deploy keys
   - Add the contents of `deploy_key.pub` as a new deploy key

3. **Create a `.ssh` directory and place your private key:**

   ```bash
   mkdir -p .ssh
   cp deploy_key .ssh/id_ed25519
   chmod 600 .ssh/id_ed25519
   ```

4. **Create a `.env` file with SSH URL:**

   ```env
   GIT_REPO_URL=git@github.com:your/repo.git
   ```

### Running the Service

1. **Build and start the service:**

   ```bash
   docker compose up --build
   ```

2. **If necessary allow SMB on the local firewall:**

   ```bash
   sudo ufw allow 445/tcp
   ```

## Access

The service allows both guest and authenticated access to the shared repository files via SMB/CIFS.
