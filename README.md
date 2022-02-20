# opsschool-logging
ELK playground for OpsSchool logging sessions

## Getting Started

1. Clone the project
   ```shell
   git clone https://github.com/yahel2410/opsschool-logging
   cd opsschool-logging
   ```
2. Create a file called `terraform.tfvars` with the required variables (replace `<>` with your values):
   ```
   aws_account_id = "<>"
   aws_region     = "<>"
   ssh_key_name   = "<>"        # ec2 key-pair name
   prefix_name    = "<>"        # your name
   aws_profile    = "<>"        # optional
   ```

3. Run
   ```shell
   terraform init
   terraform apply
   ```

4. If everything went well, `terraform` will output the public ip of the instance and the Kibana url.
   
   Notice: It takes 3-5 minutes for the ELK services to start

5. Access your instance via ssh or Kibana url