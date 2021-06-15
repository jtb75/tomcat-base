env.gitrepo = 'https://github.com/jtb75/tomcat-base.git'
env.repo = 'tomcat-base'
env.dockerImage = ''

node ('jenkins-agent'){
        stage('Clone') {
                echo 'Cloning Repo..'
                git gitrepo
                sh """
                sed -i 's/BUILDNUMBER/$BUILD_NUMBER/' Dockerfile
                """
        }
        stage ('Build') {
                container('build') {
                        echo 'Building Image..'
                        script {
                                dockerImage = docker.build repo + ":$BUILD_NUMBER"
                        }
                }
        }
        stage ('Test') {
                echo 'Running Test Harness..'
                sh """
                sleep 2
                """
        }
        stage ('Cleanup') {
                container('build') {
                        echo 'Cleaning up Image..'
                        sh """
                        docker rmi $repo:$BUILD_NUMBER
                        docker rmi $repo:latest
                        """
                }
        }
}
