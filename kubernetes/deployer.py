import yaml
from jinja2 import Template
import sys

if len(sys.argv) != 2:
    print("Usage: python deployer.py <path/to/whanos.yml> <project_name>", file=sys.stderr)
    sys.exit(1)

project_path = sys.argv[1]
project_name = sys.argv[2]

with open('/opt/k8s/template.deployment.yml', 'r') as f:
    k8s_template = f.read()

with open(project_path, 'r') as f:
    data = yaml.safe_load(f)

if not data:
    print("The file 'whanos.yml' is empty", file=sys.stderr)
    sys.exit(1)

data['name'] = project_name

template = Template(k8s_template)
rendered_yaml = template.render(data)

export_path = f'/tmp/{project_name}.deployment.yml'
with open(export_path, 'w') as f:
    f.write(rendered_yaml)

print(export_path)
