This docker container should work out of the box but I built it for use on circleci.

I've included two utility binaries;

1. `asdf-install-plugins` - Goes through your .tool-versions and installs the
   plugin for each tool. Properly propagating exit codes so you can use it in a
   CI build script.
2. `asdf-install-versions` - Goes through your .tool-versions and installs the
   missing tools for you. Properly propagating exit codes so you can use it in a
   CI build script.

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

  - run: asdf-install-plugins
  - run: asdf-install-versions

  - save_cache:
      key: v1-tools-cache-{{ checksum ".tool-versions" }}
      paths:
        - "~/.asdf/plugins"
        - "~/.asdf/installs"
```
