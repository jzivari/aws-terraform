# Deploying Localstack and Using Terraform

This document provides step-by-step instructions to deploy Localstack with Docker and install Terraform in Ubuntu. It also includes instructions on how to run Terraform with Localstack.

## Deploying Localstack with Docker

1. First, create an API_KEY on the [Localstack website](https://localstack.cloud/) and use the created API_KEY in Docker Compose.

2. Run the following command in your terminal to deploy Localstack with Docker:

    ```
    docker-compose up -d
    ```

## Installing Terraform in Ubuntu

Follow these steps to install Terraform in Ubuntu:

1. First, find the version of Terraform you want to use.

2. Run the following command to install the unzip utility:

    ```
    sudo apt-get install unzip
    ```

3. Use the wget command to download the desired version of Terraform. For example, to download version 1.4.0:

    ```
    wget https://releases.hashicorp.com/terraform/1.4.0/terraform_1.4.0_linux_amd64.zip
    ```

4. Unzip the downloaded file using the following command:

    ```
    unzip terraform_1.4.0_linux_amd64.zip
    ```

5. Move the Terraform binary to the /usr/local/bin/ directory:

    ```
    sudo mv terraform /usr/local/bin/
    ```

6. Verify that Terraform is installed correctly by running the following command:

    ```
    terraform --version
    ```

## Running Terraform with Localstack

Follow these steps to run Terraform with Localstack:

1. Expose your AWS access and secret keys:

    ```
    export AWS_ACCESS_KEY_ID=test
    export AWS_SECRET_ACCESS_KEY=test
    ```

2. Use the provider.tf file in your Terraform project to configure the Localstack provider.

3. Run the following command to initialize Terraform:

    ```
    terraform init
    ```

## Conclusion

These instructions should help you deploy Localstack with Docker and use Terraform with Localstack. If you encounter any issues or have any questions, please consult the official documentation or seek help from the community.
