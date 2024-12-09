import yaml
from jinja2 import Template

# TODO replace by the name of the jenkins project
project = 'my-project'
project_path = f'../{project}/whanos.yml'

with open('template.deployment.yml', 'r') as f:
    k8s_template = f.read()

with open(project_path, 'r') as f:
    data = yaml.safe_load(f)

if not data:
    print("The file 'whanos.yml' is empty")
    exit(0)

data['name'] = project

template = Template(k8s_template)
rendered_yaml = template.render(data)

with open(f'{project}.deployment.yml', 'w') as f:
    f.write(rendered_yaml)

print(f"The following kubernetes file has been generated: '{project}.deployment.yml'")
