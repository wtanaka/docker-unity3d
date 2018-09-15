# Unity3d docker image

[![pipeline status](https://gitlab.com/gableroux/unity3d/badges/master/pipeline.svg)](https://gitlab.com/gableroux/unity3d/commits/master) [![Docker Stars](https://img.shields.io/docker/stars/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/) [![Docker Pulls](https://img.shields.io/docker/pulls/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/) [![Docker Automated build](https://img.shields.io/docker/automated/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/) [![Image](https://images.microbadger.com/badges/image/gableroux/unity3d.svg)](https://microbadger.com/images/gableroux/unity3d) [![Version](https://images.microbadger.com/badges/version/gableroux/unity3d.svg)](https://microbadger.com/images/gableroux/unity3d)

## About this image

This docker image was first based on [GitLab CI with Unity3D in Docker](https://www.projects.science.uu.nl/DGKVj16/blog/gitlab-ci-with-unity3d-in-docker/) but changed a lot.

Linux Unity3d builds are taken from [Unity on Linux: Release Notes and Known Issues](https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/) and all supported versions can be found in [`ci-generator/unity_versions.yml`](ci-generator/unity_versions.yml)

## Things to consider

This docker image runs in a terminal so you don't have access to the UI. This docker image is intended to run unity commands with the **command line**. You can use it for running **tests** and **creating builds**.

## Usage

### Build the image

```bash
docker build -t gableroux/unity3d:latest .
```

### Run the image

```bash
docker run -it --rm \
  -v "$(pwd):/root/project" \
  gableroux/unity3d:latest \
  xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' \
  /opt/Unity/Editor/Unity -projectPath /root/project
```

### Gitlab-CI

This docker image is intended to be used with [gitlab-ci](https://about.gitlab.com/features/gitlab-ci-cd/) (but may work with other CIs). An example project using unity3d in a docker image can be found at **[gableroux/unity3d-gitlab-ci-example](https://gitlab.com/gableroux/unity3d-gitlab-ci-example)**. Have a look to the `.gitlab-ci.yml`.

## Shameless plug

I made this for free as a gift to the video game community. If this tool helped you, feel free to become a patron for [Totema Studio](https://totemastudio.com) on Patreon: :beers:

[![Totema Studio Logo](./doc/totema-studio-logo-217.png)](https://patreon.com/totemastudio)

[![Become a Patron](./doc/become_a_patron_button.png)](https://www.patreon.com/bePatron?c=1073078)

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)

