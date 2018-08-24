# Script to generate the `.gitlab-ci.yml`

## Usage

1. Specify versions in `unity_versions.py`. Uncomment the desired versions to include them in the build.
2. install requirements
3. overwrite `gitlab-ci.yml` with new data
```bash
pip install -r requirements.txt
python generate-gitlab-ci.py > ../.gitlab-ci.yml
```

:tada:
