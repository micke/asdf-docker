This docker container should work out of the box but I built it for use on circleci.

# CircleCI
CircleCI for some reason doesn't load the `~/.bashrc` file.  
So it's important to point `BASH_ENV` to this file.

```yml
version: 2
jobs:
  build:
    docker:
      - image: lisinge/asdf:latest
        environment:
          BASH_ENV: "~/.bashrc" # IMPORTANT!
```

## Caching
I recommend to utilize caching on CircleCI so asdf doesn't have to install all
of your versions on each build.

```yml
steps:
  - checkout

  - restore_cache:
      keys:
        - v1-tools-cache-{{ checksum ".tool-versions" }}

  - run: asdf plugin-add erlang || true
  - run: asdf plugin-add elixir || true
  - run: asdf plugin-add nodejs || true
  - run: bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  - run: asdf install || true

  - save_cache:
      key: v1-tools-cache-{{ checksum ".tool-versions" }}
      paths: "~/.asdf/plugins"
```
