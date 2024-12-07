pipeline {
    agent any
    tools {
        terraform 'terraform'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Récupérer le code source depuis le dépôt Git
                git branch: 'main', url: 'https://github.com/nesrinechaouani/Terraform-cicd.git'
            }
        }
        stage('Terraform Init') {
            steps {
                // Initialiser Terraform
                bat 'terraform init'
            }
        }

        stage('Terraform Import') {
            steps {
                script {
                    def resourceGroupExists = bat(script: 'az group show --name myResourceGroup', returnStatus: true) == 0
                    if (resourceGroupExists) {
                        echo 'Resource group already exists, importing it into Terraform state.'
                        bat 'terraform import azurerm_resource_group.example /subscriptions/304799ce-2258-416d-85f2-8c42149f7550/resourceGroups/myResourceGroup'
                    } else {
                        echo 'Resource group does not exist, no import needed.'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                // Générer un plan Terraform
                bat 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                // Appliquer les changements
                bat 'terraform apply -auto-approve tfplan'
            }
        }
    }
    post {
        success {
            echo 'Pipeline exécuté avec succès.'
        }
        failure {
            echo 'Erreur dans l\'exécution du pipeline.'
        }
    }
}
