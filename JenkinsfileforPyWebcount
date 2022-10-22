pipeline{
    agent { label 'PYHON'}
    stages{
        stage('VCS'){
            steps{
                git branch:'master' , url:'https://github.com/mallojuashok/python-webcount.git'
            }
        }
        stage('Python'){
            steps{
                sh 'pip3 install -r requirements.txt'
                }
        }
        stage('Tox Install'){
            steps{
                sh 'sudo apt install tox -y'
                }
        }
        stage('Run Tax'){
            steps{
                sh 'tox'
                }
        }
        stage('archive results'){
            steps{
                junit '**/junit-py39.xml'
            }
        }
        stage('artifacts'){
            steps{
                archiveArtifacts artifacts: '**/webcount-0.1.zip'
            }
        }

    }
}