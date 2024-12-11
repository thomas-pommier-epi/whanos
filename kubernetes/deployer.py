import yaml
from jinja2 import Template
import sys

def render_template(template_lines, data):
    template = Template(template_lines)
    return template.render(data)

def write_template(project_name, parsed, mode):
    export_path = f'/tmp/{project_name}.{mode}.yml'
    with open(export_path, 'w') as f:
        f.write(parsed)
    return export_path

####################

if len(sys.argv) != 4:
    print("Usage: python deployer.py <path/to/whanos.yml> <project_name> <project_id>", file=sys.stderr)
    sys.exit(1)

project_path = sys.argv[1]
project_name = sys.argv[2]
project_id = sys.argv[3]

with open(f"{project_path}/whanos.yml", 'r') as f:
    data = yaml.safe_load(f)

if not data:
    print("The file 'whanos.yml' is empty", file=sys.stderr)
    sys.exit(1)

with open('/opt/k8s/template.deployment.yml.j2', 'r') as f:
    deployment_template = f.read()

with open('/opt/k8s/template.service.yml.j2', 'r') as f:
    service_template = f.read()

data['name'] = project_name
data['image_name'] = f"gcr.io/{project_id}/{project_name}"

parsed_deployments = render_template(deployment_template, data)
export_deployments = write_template(project_name, parsed_deployments, 'deployment')
parsed_service = render_template(service_template, data)
export_service = write_template(project_name, parsed_service, 'service')

print(f"{export_deployments} {export_service}")
