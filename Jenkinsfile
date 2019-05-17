#!/usr/bin/env groovy
pipeline {
  agent { label 'rspec' }

  environment {
    HOME = "/opt/jenkins-slave"
    USER = "jenkins-slave"
    USERNAME = "jenkins-slave"
    JENKINS_HOME = "/opt/jenkins-slave"
  }

  options {
    gitlabBuilds(builds: [
      'Prepare test environmnet',
      'Puppet Code Style Checking',
      'Puppet Module Metadata Check',
      'Puppet Code Syntax Check',
      'SonarQube Analysis',
      'SonarQube Quality Gate',
      'Puppet-Rspec Test',
      'Puppet Acceptence Test redhat-7.4-x64',
      'Puppet Acceptence Test redhat-6.9-x64',
    ])
  }


  stages {
    stage('debug') {
      steps {
        sh 'printenv'
      }
    }

    stage('Prepare test environmnet') {
      steps {
        gitlabCommitStatus(name: 'Prepare test environmnet') {
          sh '''
            #!/usr/bin/env bash --login
            [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
            /usr/local/rvm/bin/rvm use default
            echo $PATH
            bundle install --without development || bundle update
          '''
        }
      }
    }

    stage('Puppet Code Style Checking') {
      steps {
        gitlabCommitStatus(name: 'Puppet Code Style Checking') {
          script {
            try {
              sh '''
                #!/bin/bash --login
                [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
                /usr/local/rvm/bin/rvm use default
                bundle exec rake lint
              '''
            } catch (e) {
              addGitLabMRComment comment: 'The Puppet Code Style Checking did not pass the test'
              currentBuild.result = 'UNSTABLE'
            }
          }
        }
      }
    }

    stage('Puppet Module Metadata Check') {
      steps {
        gitlabCommitStatus(name: 'Puppet Module Metadata Check') {
          script {
            try {
              sh '''
                #!/bin/bash --login
                [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
                /usr/local/rvm/bin/rvm use default
                bundle exec rake metadata_lint
              '''
            } catch (e) {
              addGitLabMRComment comment: 'The Puppet Metadata Check did not pass the test'
              currentBuild.result = 'UNSTABLE'
            }
          }
        }
      }
    }

    stage('Puppet Code Syntax Check') {
      steps {
        gitlabCommitStatus(name: 'Puppet Code Syntax Check') {
          sh '''
            #!/bin/bash --login
            [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
            /usr/local/rvm/bin/rvm use default
            bundle exec rake syntax
          '''
        }
      }
    }

    stage('Puppet-Rspec Test') {
      steps {
        gitlabCommitStatus(name: 'Puppet-Rspec Test') {
          script {
            try {
              sh '''
                #!/bin/bash --login
                [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
                /usr/local/rvm/bin/rvm use default
                bundle exec rake spec
                '''
            } catch (e) {
              currentBuild.result = 'FAILED'
              updateGitlabCommitStatus(name: 'Puppet-Rspec Test', state: 'failed')
            }
          }
          junit allowEmptyResults: true, keepLongStdio: true, testResults: 'junit/reports_junit.xml'
        }
      }
    }

    stage('SonarQube Analysis') {
      steps {
        gitlabCommitStatus(name: 'SonarQube Analysis') {
          withSonarQubeEnv('Sonarqube puppet 6.7.1 LTS') {
            sh '''
            /opt/sonar-scanner/bin/sonar-scanner -X \
              --define "sonar.projectKey=puppet:${gitlabSourceRepoName}" \
              --define "sonar.projectName=${gitlabSourceRepoName}" \
              --define "sonar.projectVersion=${BUILD_ID}-${gitlabMergeRequestIid}" \
              --define "sonar.exclusions=Jenkinsfile*,junit/**/*,spec/**/*" \
              --define "sonar.sources=."
            '''
          }
        }
      }
    }
    stage("SonarQube Quality Gate") {
      steps {
        gitlabCommitStatus(name: 'SonarQube Quality Gate') {
          script {
            timeout(time: 5, unit: 'MINUTES') {      // Just in case something goes wrong, pipeline will be killed after a timeout
              def qg = waitForQualityGate()        // Reuse taskId previously collected by withSonarQubeEnv
              if (qg.status != 'OK') {
                error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
            }
          }
        }
      }
    }

    stage('Beaker Acceptance Tests') {
      parallel {
        stage('Puppet Acceptence Test redhat-7.4-x64') {
          steps {
            gitlabCommitStatus(name: 'Puppet Acceptence Test redhat-7.4-x64') {
              script {
                try {
                  sh '''
                    #!/bin/bash --login
                    [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
                    export DOCKER_HOST=tcp://localhost:4243
                    /usr/local/rvm/bin/rvm use default
                    bundle exec rake spec_clean
                    bundle exec rake spec_prep
                    bundle exec rake beaker:redhat-7.4-x64
                   '''
                } catch (e) {
                   currentBuild.result = 'FAILED'
                   updateGitlabCommitStatus(name: 'Puppet Acceptence Test redhat-7.4-x64', state: 'failed')
                }
              }
            }
          }
        }

        stage('Puppet Acceptence Test redhat-6.9-x64') {
          steps {
            gitlabCommitStatus(name: 'Puppet Acceptence Test redhat-6.9-x64') {
              script {
                try {
                  sh '''
                    #!/bin/bash --login
                    [[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
                    export DOCKER_HOST=tcp://localhost:4243
                    /usr/local/rvm/bin/rvm use default
                    bundle exec rake spec_clean
                    bundle exec rake spec_prep
                    bundle exec rake beaker:redhat-6.9-x64
                  '''
                } catch (e) {
                  currentBuild.result = 'FAILED'
                  updateGitlabCommitStatus(name: 'Puppet Acceptence Test redhat-6.9-x64', state: 'failed')
                }
              }
            }
          }
        }
      }
    }
  }
  // global feedback of the Project
  post {
    failure {
      updateGitlabCommitStatus state: 'failed'
    }
    success {
      updateGitlabCommitStatus state: 'success'
      //build job: 'vdab_ntp_demo_puppet4', propagate: false, wait: true
    }
    unstable {
      updateGitlabCommitStatus state: 'success'
    }
    aborted {
      updateGitlabCommitStatus state: 'canceled'
    }
  }
}
