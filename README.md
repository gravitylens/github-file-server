# github-file-server
At every restart this container will clone the contents of a specified github repository and server the contents of those file as a CIFS share.  This is a simple way to create a file server in multiple training environments that can be managed centrally.

## How to
Clone the repository.  Then modify the docker-compose.yml file to specify the URL of the github repository to clone.

```
    environment:
      - GIT_REPO_URL=https://github.com/gravitylens/DrinkRecipes.git
```

Start the container.

```
sudo docker compose up -d
```

If necessary allow SMB on the local firewall.

```
sudo ufw allow 445/tcp
```

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

