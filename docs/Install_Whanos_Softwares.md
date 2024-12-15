# Install Infrastructure Softwares

In the `ansible/` folder. (`cd ansible/`)
Copy the `.env.example` to `.env`

## Prerequisists

- Python
- A Shell
- The infrastructure
- A Web Browser

Open the terminal and go to the github repo directory via `cd`.

## Environement Setup

In the `ansible/setup-google` folder. (`cd ansible/setup-google`)
Copy the `.env.example` to `.env`

Edit all the necessary variables, here all the necessary decriptions:

| Variable Name           | Description              |
|-------------------------|--------------------------|
| JENKINS_USER_PASSWORD   | Jenkins `admin` password |


Once fully edited, continue to the next step.

## Creating the config

run the script `./create_configs.sh`:

```bash
./create_configs.sh
```

If everything went right (no ansible errors).

## Connect to Jenkins

With the HEAD Server IP (external IP from the IaC output),
connect via a web browser the url (with user modification):

`http://{head_server_ip}:8080/`

You should see a login screen:
![Jenkins Login Screen](./images/jenkins_logins.png)

As a the username, put `admin`
For the password, the variable you wrote for JENKINS_USER_PASSWORD

## Build Images

The first thing you need to do in jenkins is buildin the applications base images.

1. From the dashboard, Go to the folder `Whanos base images`
2. Click on the arrow key to run the workflow: `Build all base images`
3. Once done without errors, follow the next step
