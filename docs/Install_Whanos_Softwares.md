# Install Infrastructure Softwares

## Prerequisites

- `>=` Python3.10
- A Shell (Bash)
- The infrastructure (`setup-google/` folder)
- A Web Browser (supports jenkins)

Open the terminal and go to the github repo directory via `cd`.

## Environement Setup

In the `${workdir}/ansible` folder. (`cd ${workdir}/ansible`)
Copy the `.env.example` to `.env`

Edit all the necessary variables, here all the necessary decription(s):

| Variable Name           | Description              |
|-------------------------|--------------------------|
| JENKINS_USER_PASSWORD   | Jenkins `admin` password |

Once fully edited, continue to the next step.

## Creating the config

Run the script `./create_configs.sh`:

```bash
./create_configs.sh
```

If everything went right (no ansible errors). Follow the next category.

## Deploy

Run the script `./deploy.sh`:

```bash
./deploy.sh
```

This should setup all the necessary software and permissions to the head server. If no ansible error is reported, follow the next step.

## Connect to Jenkins

With the head server IP (external IP from the IaC output),
connect via a web browser to the url (with user modification):

**Replace `{head_server_ip}` with the saved head external IP without the brackets.**
```
http://{head_server_ip}:8080/
```

You should see a login screen:
![<img alt="Jenkins Login Screen" width="748px" height="420ox" src="./images/jenkins_login.png" />](./images/jenkins_login.png)

For the username, put `admin`.

For the password, put the variable you wrote for JENKINS_USER_PASSWORD in the `.env` file.

## Build Images

The first thing you need to do in jenkins is building the applications base images.

1. From the dashboard, go to the folder `Whanos base images`
2. Click on the green arrow logo to run the workflow: `Build all base images`
3. Once done without errors, follow the next step

## Next Step

Link a Whanos project for testing, with a `whanos.yml` for the deployment for example: [Link a Whanos Project](./Link_a_Project.md).
