pipeline{
    agent {label 'AZURECLI'}
    stages{
         stage('Vm Create'){
            steps{
                sh 'chmod 777 bin.sh'
                sh './bin.sh'
             }
        }
    }
}