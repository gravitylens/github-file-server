# github-file-server
At every restart this container will clone the contents of a specified github repository and serve the contents of that repository as a CIFS share.  This is a simple way to create a file server in multiple training environments that can be managed centrally.

## Setup

1. **Create a `.env` file in the project root with the following content:**
   ```
   GIT_REPO_URL=https://github.com/your/repo.git
   ```
   Replace the URL with your desired Git repository.

2. **Build and start the service:**
   ```
   docker compose up --build
   ```
3. **If necessary allow SMB on the local firewall.**

   ```
   sudo ufw allow 445/tcp
   ```
