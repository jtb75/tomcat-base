env.gitrepo = 'https://github.com/jtb75/tomcat-base.git'
env.repo = 'tomcat-base'
env.dockerImage = ''

node ('jenkins-agent'){
        stage('Clone') {
                echo 'Cloning Repo..'
                git branch: 'main', credentialsId: 'd382daa3-c83a-44c4-9788-1d245c3e8e0c', url: gitrepo
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
        stage ('Scan') {
                container('build') {
                        echo 'Scan for Compliance and Vulnerabilities..'
                        prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock',
                                image: repo +':$BUILD_NUMBER', key: '',
                                logLevel: 'info', podmanPath: '', project: '',
                                resultsFile: 'prisma-cloud-scan-results.json'
                        sh """
                        chmod 666 prisma-cloud-scan-results.json
                        """
                }
        }
        stage ('Publish') {
                container('build') {
                        echo 'Publish Compliance and Vulnerabilities results..'
                        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
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
                        """
                }
        }
}
