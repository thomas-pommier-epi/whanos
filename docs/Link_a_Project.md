# Link a Project

Connec to jenkins with the user `admin`.

From the dashboard, click the green arrow from the workflow `link-project`.

You have multiple possibilities

## Build Parameters

- Project_name
  - Project name that will be the workflow name created, as well as the pod name if the project should be deployed.

- Repository URL
  - git url to clone from

- Credentials_ID
  - if the git project is private, the jenkins need to login. It can be:
    - Username and Password
    - Auth to ken
    - Certificate

Once everything is setup, you can return to the dashboard and go to: `Projects/<project_name>`.


## Build Manually the Project

### Build

Once you're in the workflow from `Projects/<project_name>`. Click on `Build Now` if you wish to build immediately. The workflow would have done it itself 1 minute after (due to automatic pulling).

This should trigger the worflows to build the docker image and potentially deploy to the cluster.

If you wish to know more about the success of the workflow (instead of the logo in the left if there are errors). You can go to the `Console Output` menu.
From this you can gather:

- Git pulling
- Docker Build
- Docker Push to Repository
- Kubectl applying the Deployment and Service file for the application
- Awaiting the application external IP adddress

### Monitor Workflow

The workflow outputs numerous informations useful to debug the program's building process. Plus it shows the deployment logs and outputing the **external ip of the program**.
