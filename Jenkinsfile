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
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                // Générer un plan Terraform
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                // Appliquer les changements
                sh 'terraform apply -auto-approve tfplan'
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
