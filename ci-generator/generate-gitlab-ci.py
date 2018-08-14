#!/usr/bin/env python
import os
from jinja2 import Template


def main():
    script_dirname = os.path.dirname(os.path.realpath(__file__))
    yaml_template = os.path.join(script_dirname, "gitlab-ci.jinja2")
    components = {
        'unity': 'Unity',
        'windows': 'Windows,Windows-Mono',
        'mac': 'Mac,Mac-Mono',
        'ios': 'iOS',
        'android': 'Android',
        'webgl': 'WebGL',
        'facebook': 'Facebook-Games'
    }
    # todo: make this more DRY by extracting a version to an object to compute underscore value
    versions = {
        # '2017.4.7f1': {
        #     'version': '2017.4.7',
        #     'build': 'f1',
        #     'underscore': '2017_4_7f1',
        #     'download_url': 'https://beta.unity3d.com/download/1d86eef80e0a/UnitySetup-2017.4.7f1'
        # },
        # '2017.4.8f1': {
        #     'version': '2017.4.8',
        #     'build': 'f1',
        #     'underscore': '2017_4_8f1',
        #     'download_url': 'https://beta.unity3d.com/download/8140fe378247/UnitySetup-2017.4.8f1'
        # },
        # '2018.2.1f1': {
        #     'version': '2018.2.1',
        #     'build': 'f1',
        #     'underscore': '2018_2_1f1',
        #     'download_url': 'https://beta.unity3d.com/download/48afb4a72b1a/UnitySetup-2018.2.1f1'
        # },
        # '2018.2.2f1': {
        #     'version': '2018.2.2',
        #     'build': 'f1',
        #     'underscore': '2018_2_2f1',
        #     'download_url': 'https://beta.unity3d.com/download/fcee59332301/UnitySetup-2018.2.2f1'
        # }
        '2018.2.3f1': {
            'version': '2018.2.3',
            'build': 'f1',
            'underscore': '2018_2_3f1',
            'download_url': 'https://beta.unity3d.com/download/fba045906327/UnitySetup-2018.2.3f1'
        }
    }
    context = {
        'versions': versions,
        'components': components
    }
    rendered_template = render_template(context, yaml_template)
    print(rendered_template)


def render_template(context, yaml_template):
    with open(yaml_template, 'r') as f:
        template = Template(f.read())
    result = template.render(context)
    return result


if __name__ == "__main__":
    main()
