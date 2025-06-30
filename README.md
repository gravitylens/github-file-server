# github-file-server
At every restart this container will clone the contents of a specified github repository and server the contents of those file as a CIFS share.  This is a simple way to create a file repository in a training environments that can be managed centrally.

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

