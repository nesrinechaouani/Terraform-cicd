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
        stage('Azure Login') {
            steps {
                script {
                    bat 'az login --service-principal -u 7ed1097c-36a3-4b50-9bc6-c0b2f91968fc -p T7O8Q~XyRzigy6S5PkFnBEdYFUxu5wo4CMCHiagF --tenant dbd6664d-4eb9-46eb-99d8-5c43ba153c61'
                }
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
                    // Vérifie si Terraform gère déjà la ressource
                    def terraformState = bat(script: 'terraform state list', returnStdout: true).trim()
                    if (!terraformState.contains('azurerm_resource_group.example')) {
                        def resourceGroupExists = bat(script: 'az group show --name myResourceGroup', returnStatus: true) == 0
                        if (resourceGroupExists) {
                            echo 'Resource group already exists, importing it into Terraform state.'
                            bat 'terraform import azurerm_resource_group.example /subscriptions/304799ce-2258-416d-85f2-8c42149f7550/resourceGroups/myResourceGroup'
                        } else {
                            echo 'Resource group does not exist, no import needed.'
                        }
                    } else {
                        echo 'Resource group is already managed by Terraform. Skipping import.'
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
