pipeline {
    agent { node { label 'terraform-node' } } 
    parameters {
        choice(name: 'deploy_choice', choices: ['apply', 'destroy'], description: 'The deployment type')
    }
    environment {
        EMAIL_TO = 'thierrykelly91@gmail.com'
        AWS_REGION = 'us-west-2'  // Set AWS region globally for reusability
    }
    stages {
        stage('1. Terraform init') {
            steps {
                echo 'Starting Terraform initialization...'
                sh 'terraform init'
            }
        }
        stage('2. Terraform plan') {
            steps {
                echo "Running Terraform plan for ${params.deploy_choice}..."
                sh "AWS_REGION=${env.AWS_REGION} terraform plan"
            }
        }
        stage('3. Manual Approval') {
            input {
                message "Should we proceed with the ${params.deploy_choice} operation?"
                ok "Yes, proceed."
                parameters {
                    choice(name: 'Manual_Approval', choices: ['Approve', 'Reject'], description: 'Approve or Reject the deployment')
                }
            }
            steps {
                echo "Deployment has been ${Manual_Approval}"
            }
        }
        stage('4. Terraform Deploy') {
            when {
                expression { params.Manual_Approval == 'Approve' }
            }
            steps {
                echo "Running Terraform ${params.deploy_choice}..."
                
                // Execute the Terraform command (apply or destroy)
                sh "AWS_REGION=${env.AWS_REGION} terraform ${params.deploy_choice} -target=module.vpc -target=module.eks --auto-approve"
                
                script {
                    if (params.deploy_choice == 'apply') {
                        echo 'Running additional scripts for apply phase...'
                        sh "scripts/update-kubeconfig.sh"
                        sh "scripts/observability-addon.sh"
                    }
                }

                // Run Terraform for any remaining changes
                sh "AWS_REGION=${env.AWS_REGION} terraform ${params.deploy_choice} --auto-approve"
            }
        }
        stage('5. Email Notification') {
            steps {
                mail bcc: 'thierrykelly91@gmail.com', 
                     body: '''Terraform deployment is completed.
Let me know if the changes look okay.
Thanks,
Dominion System Technologies,
+1 (313) 413-1477''', 
                     cc: 'thierrykelly91@gmail.com', 
                     subject: 'Terraform Infra deployment completed!!!', 
                     to: 'thierrykelly91@gmail.com'
            }
        }
    }
}
