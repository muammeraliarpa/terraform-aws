pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-terraform-creds').username
        AWS_SECRET_ACCESS_KEY = credentials('aws-terraform-creds').password
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