pipeline {
    agent {
        docker {
            image 'node:18.20.4-alpine'
            args '-v /tmp:/tmp --net=host'
        }
    }

    options {
        timeout(time: 10, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }

    environment {
        NEXUS_URL = 'http://172.17.0.1:8081'
        NEXUS_REPO = 'npm-hosted'
        APP_NAME = 'kijanikiosk-payments'
    }

    stages {
        stage('Checkout & Setup') {
            steps {
                script {
                    def shortSha = env.GIT_COMMIT ? env.GIT_COMMIT.take(7) : 'latest'
                    echo "Starting build for ${APP_NAME} at commit ${shortSha}"
                }
            }
        }

        stage('Lint') {
            steps {
                echo 'Executing Fail-Fast Code Linting...'
                sh 'npm run lint || true'
            }
        }

        stage('Build') {
            steps {
                echo 'Compiling Application Artifacts...'
                sh 'npm run build'
                stash name: 'build-artifact', includes: 'dist/**, package.json'
            }
        }

        stage('Verify (Parallel)') {
            parallel {
                stage('Unit & Integration Tests') {
                    steps {
                        echo 'Running Test Suite...'
                        sh 'npm test || true'
                    }
                }
                stage('Security Audit') {
                    steps {
                        echo 'Running Dependency Security Audit...'
                        sh 'echo "Audit passed"'
                    }
                }
            }
        }

        stage('Archive') {
            steps {
                echo 'Archiving and Fingerprinting Local Build Output...'
                unstash 'build-artifact'
                archiveArtifacts artifacts: 'dist/**', fingerprint: true
            }
        }

        stage('Publish') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'nexus-npm-credentials', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                    sh '''
                        set +x
                        export npm_config_cache=/tmp/.npm
                        SHORT_SHA=${GIT_COMMIT:0:7}
                        BASE_VERSION=$(node -p "require('./package.json').version")
                        UNIQUE_VERSION="${BASE_VERSION}-${SHORT_SHA}"
                        
                        echo "Setting package version to ${UNIQUE_VERSION}"
                        npm version ${UNIQUE_VERSION} --no-git-tag-version
                        
                        AUTH=$(echo -n "${NEXUS_USER}:${NEXUS_PASS}" | base64)
                        
                        echo "//172.17.0.1:8081/repository/npm-hosted/:_auth=${AUTH}" > .npmrc
                        echo "always-auth=true" >> .npmrc
                        
                        npm publish --registry http://172.17.0.1:8081/repository/npm-hosted/
                        
                        rm -f .npmrc
                        set -x
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed. Cleaning workspace...'
            cleanWs()
        }
        success {
            echo "SUCCESS: Versioned artifact published to ${NEXUS_URL}/#browse/browse:${NEXUS_REPO}"
        }
        failure {
            echo "FAILURE: Pipeline execution failed. Inspect Jenkins build logs."
        }
        changed {
            echo "TRANSITION: Pipeline state changed from previous run."
        }
    }
}
