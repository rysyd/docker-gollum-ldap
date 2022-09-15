## gollum wiki with benefits

wiki engine - https://github.com/gollum/gollum
Оne needs initialised git repo and config.rb file (example provided)

## Steps
1, initializing wiki repository
```
mkdir wiki
cd wiki
git init
```
2, edit config.rb and copy to the `wiki` directory.

3, using docker compose
```
docker compose up -d
```

Gollum listens using http on port 8080.

