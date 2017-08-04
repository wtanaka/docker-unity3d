# Unity3d docker image

[![Docker Stars](https://img.shields.io/docker/stars/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/) [![Docker Pulls](https://img.shields.io/docker/pulls/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/) [![Docker Automated buil](https://img.shields.io/docker/automated/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/) [![Docker Build Statu](https://img.shields.io/docker/build/gableroux/unity3d.svg)](https://hub.docker.com/r/gableroux/unity3d/)

## About this image

This docker image is based on [GitLab CI with Unity3D in Docker](https://www.projects.science.uu.nl/DGKVj16/blog/gitlab-ci-with-unity3d-in-docker/).

Linux Unity3d builds are taken from [Unity on Linux: Release Notes and Known Issues](https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/)

## Things to consider

This docker image runs in a terminal so you don't have access to the UI. This docker image is intended to run unity commands with the **command line**. You can use it for running **tests** and **creating builds**.

## Usage

### Build the image

```bash
docker build -t gableroux/unity3d:latest .
```

### Run the image

todo

### Publish the image to a registry

This requires _write_ rights on the registry, but you could push to your own registry.

```bash
docker push gableroux/unity3d:latest
```

### Gitlab-CI

This docker image is intended to be used with [gitlab-ci](https://about.gitlab.com/features/gitlab-ci-cd/) (but may work with other CIs). An example project using unity3d in a docker image can be found at **[gableroux/unity3d-gitlab-ci-example](https://gitlab.com/gableroux/unity3d-gitlab-ci-example)**. Have a look to the `.gitlab-ci.yml`.

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)


