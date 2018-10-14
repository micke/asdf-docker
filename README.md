This docker container should work out of the box but I built it for use on circleci.

## CircleCI
For some reason circleci doesn't load the `~/.bashrc` file so it's important to
point `BASH_ENV` to this file.

```yml
version: 2
jobs:
  build:
    docker:
      - image: lisinge/asdf:latest
        environment:
          BASH_ENV: "~/.bashrc" # IMPORTANT!

    steps:
      - checkout

      - run: asdf plugin-add erlang
      - run: asdf plugin-add elixir
      - run: asdf plugin-add nodejs
      - run: bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring # Needed if you are using nodejs
      - run: asdf install
```
