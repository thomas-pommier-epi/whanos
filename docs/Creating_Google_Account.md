# Creating a Google Cloud Project

1. **Sign in to Google Cloud Console:**

    - Go to the [Google Cloud Console](https://console.cloud.google.com/).
    - Sign in with your Google account.
2. **Create a New Project:**

    - Click on the project drop-down menu at the top of the page.
    - Click on the "New Project" button.
    - Enter a project name.
    - Optionally, you can edit the project ID or select an organization.
    - **Copy somewhere the project id for permissions setup**
    - Click on the "Create" button.
3. **Enable Billing (if required):**

    - If you haven't already set up billing, you will be prompted to do so. Follow the instructions to set up billing for your project.

# Creating a Service Account

1. **Navigate to the IAM & Admin Section:**

    - In the Google Cloud Console, go to the navigation menu (three horizontal lines) and select "IAM & Admin" > "Service Accounts."
2. **Create a Service Account:**

    - Click on the "Create Service Account" button at the top of the page.
    - Enter a service account name like "whanos-service" and click enter
    - Click on the "Create and Continue" button.
3. **Grant Access to the Service Account:**

    The roles will be defined later, **but you need to be the owner or at least the admin of the project**.
    So **click continue**.
4. **Grant Users Access to This Service Account (Optional):**

    - You can grant users access to act as this service account. This step is optional.
    - Click on the "Done" button.

# Downloading the Service Account Key

1. **Generate a Key:**

    - After creating the service account, you will be redirected to the service account details page.
    - Click on the email of the newly created account
    - Click on the "Keys" tab.
    - Click on the select menu "Add Key" button and select "Create New Key."
2. **Select Key Type:**

    - Choose "JSON" as the key type.
    - Click on the "Create" button.
3. **Download the Key File:**

    - The JSON key file will be automatically downloaded, once downloaded put it in `${workdir}/ansible/setup-google/`
    - Rename the file `whanos_gke.json`

# Enabling APIs

1. **Enable the Kubernetes Engine API:**

    - Go to the [Kubernetes Engine API](https://console.cloud.google.com/apis/library/container.googleapis.com) page.
    - Click on the "Enable" button.

2. **Enable the Compute Engine API:**

    - Go to the [Compute Engine API](https://console.cloud.google.com/apis/library/compute.googleapis.com) page.
    - Click on the "Enable" button.
