Prerequisists:
- Terraform
- Google Terraform Plugin

Copy the `.env.example` to .env

run the script `./create_ansible_keys.sh`:
```bash
./create_ansible_keys.sh
```

Create a Google account
Create a Google Cloud Project and make sure the billing is enabled.

Create a Service Account Key

Go to the Google Cloud Console, navigate to the IAM & Admin section, and create a service account key. Next go on the details of the account, go to "Keys" and create one. You select "json" and download the JSON file containing the key.
Next move it in `${workdir}/ansible/setup-google/` and specify in the .env via the TF_VAR_gcp_auth variable the relative path of the file you created. Example:
```
TF_VAR_gcp_auth=whanos-442222-1e064359180f.json
```

Next, run the script `./apply_terraform.sh`:
```bash
./apply_terraform.sh
```