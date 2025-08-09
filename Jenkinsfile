pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-1'
    }

    stages {
        stage('Prepare SSH Key') {
            steps {
                withCredentials([string(credentialsId: 'terraform-ssh-key', variable: 'PUBLIC_KEY')]) {
                    sh 'echo "$PUBLIC_KEY" > id_rsa.pub'
                    script {
                        env.TF_VAR_public_key = PUBLIC_KEY
                    }
                }
            }
        }


        stage('Terraform Init, Plan, Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-terraform-creds'
                ]]) {
                    sh 'terraform init'
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
         stage('Get Public IP and Update Server') {
            steps {
                script {
                    // Terraform output'tan IP çekiliyor
                    def publicIp = sh(script: 'terraform output -raw public_ip', returnStdout: true).trim()
                    echo "Ubuntu sunucusu başarıyla oluşturuldu. Public IP: ${publicIp}"

                    sshCommand remote: [
                        name: 'aws-server',
                        host: publicIp,
                        user: 'ubuntu',
                        identity: credentials('terraform-ssh-key') 
                    ], command: "sudo apt update -y && sudo apt upgrade -y"
                }
            }
        }
    }
}
