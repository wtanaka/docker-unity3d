# Unity3d docker image

[![Docker Stars](https://img.shields.io/docker/stars/wtanaka/unity3d.svg)](https://hub.docker.com/r/wtanaka/unity3d/)
[![Docker Pulls](https://img.shields.io/docker/pulls/wtanaka/unity3d.svg)](https://hub.docker.com/r/wtanaka/unity3d/)
[![Docker Automated build](https://img.shields.io/docker/automated/wtanaka/unity3d.svg)](https://hub.docker.com/r/wtanaka/unity3d/)
[![Image](https://images.microbadger.com/badges/image/wtanaka/unity3d.svg)](https://microbadger.com/images/wtanaka/unity3d)
[![Version](https://images.microbadger.com/badges/version/wtanaka/unity3d.svg)](https://microbadger.com/images/wtanaka/unity3d)

## About this image

This docker image was based on [GitLab CI with Unity3D in
Docker](https://www.projects.science.uu.nl/DGKVj16/blog/gitlab-ci-with-unity3d-in-docker/)
and [Unity3d docker image for running commands in CI such as
gitlab-ci](https://gitlab.com/gableroux/unity3d).

Linux Unity3d builds are taken from [Unity on Linux: Release Notes and
Known
Issues](https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/)

## Things to consider

This docker image runs in a terminal so you don't have access to the
UI. This docker image is intended to run unity commands with the
**command line**. You can use it for running **tests** and **creating
builds**.

## Usage

### Activate

1. Pull the docker image and run it

```bash
UNITY_VERSION=2018.3.0f2
UNITY_USERNAME=your_username@example.com
UNITY_PASSWORD=yourPassword
docker run -it --rm \
  -e "HOSTUID=`id -u`" \
  -e "HOSTGID=`id -g`" \
  -e "UNITY_USERNAME=$UNITY_USERNAME" \
  -e "UNITY_PASSWORD=$UNITY_PASSWORD" \
  -e "WORKDIR=/work" \
  -v "$(pwd):/work" \
  wtanaka/unity3d:"$UNITY_VERSION" \
  bash
```

2. Run this to try to activate Unity

```bash
xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' \
/opt/Unity/Editor/Unity \
-logFile \
-batchmode \
-username "$UNITY_USERNAME" -password "$UNITY_PASSWORD"
```

3. Wait for output that looks like this:

```
LICENSE SYSTEM [2017723 8:6:38] Posting <?xml version="1.0" encoding="UTF-8"?><root><SystemInfo><IsoCode>en</IsoCode><UserName>[...]
```

4. Copy xml content and save as `unity3d.alf`
5. Open https://license.unity3d.com/manual and answer questions
6. Upload `unity3d.alf` for manual activation
7. Download `Unity_v2018.x.ulf`
8. Copy the content of `Unity_v2018.x.ulf` license file to your CI's environment variable `UNITY_LICENSE_CONTENT`.

### Running play mode tests

```
UNITY_LICENSE_CONTENT="`cat Unity_v2018.x.ulf`"
export UNITY_LICENSE_CONTENT
UNITY_VERSION=2018.3.0f2
export UNITY_VERSION
docker run -it --rm \
  -e "HOSTUID=`id -u`" \
  -e "HOSTGID=`id -g`" \
  -e "TEST_PLATFORM=playmode" \
  -e UNITY_LICENSE_CONTENT \
  -e "WORKDIR=/work" \
  -v "$(pwd):/work" \
  wtanaka/unity3d:"$UNITY_VERSION" \
  /xvfb_runtests.sh
```

### Running edit mode tests

```
UNITY_LICENSE_CONTENT="`cat Unity_v2018.x.ulf`"
export UNITY_LICENSE_CONTENT
UNITY_VERSION=2018.3.0f2
export UNITY_VERSION
docker run -it --rm \
  -e "HOSTUID=`id -u`" \
  -e "HOSTGID=`id -g`" \
  -e "TEST_PLATFORM=playmode" \
  -e UNITY_LICENSE_CONTENT \
  -e "WORKDIR=/work" \
  -v "$(pwd):/work" \
  wtanaka/unity3d:"$UNITY_VERSION" \
  /xvfb_runtests.sh
```

### Building

```
UNITY_LICENSE_CONTENT="`cat Unity_v2018.x.ulf`"
export UNITY_LICENSE_CONTENT
UNITY_VERSION=2018.3.0f2
export UNITY_VERSION
docker run -it --rm \
  -e "HOSTUID=`id -u`" \
  -e "HOSTGID=`id -g`" \
  -e "TEST_PLATFORM=playmode" \
  -e UNITY_LICENSE_CONTENT \
  -e "WORKDIR=/work" \
  -v "$(pwd):/work" \
  wtanaka/unity3d:"$UNITY_VERSION" \
  /opt/Unity/Editor/Unity \
  -projectPath . \
  -quit -batchmode -nographics \
  -buildTarget WebGL \
  -customBuildTarget WebGL \
  -customBuildName TheBuildName \
  -customBuildPath TheBuild \
  -customBuildOptions AcceptExternalModificationsToPlayer \
  -executeMethod BuildCommand.PerformBuild \
  -logFile
```

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)

