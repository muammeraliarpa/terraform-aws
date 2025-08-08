pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = 'aws-terraform-creds'
        AWS_SECRET_ACCESS_KEY = 'aws-terraform-creds'
        AWS_REGION            = 'eu-west-1'
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        
        stage('Get Public IP') {
            steps {
                script {
                    def publicIp = sh(script: 'terraform output -raw public_ip', returnStdout: true).trim()
                    echo "Ubuntu sunucusu başarıyla oluşturuldu. Public IP: ${publicIp}"
                }
            }
        }
    }
}
