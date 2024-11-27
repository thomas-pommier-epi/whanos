// Create the folder for projects
folder('Projects') {
    description('Folder for all projects.')
    displayName('Projects')
}

// Link a project to the Jenkins instance
freeStyleJob('/link-project') {
    parameters {
        stringParam("PROJECT_NAME", '', 'Name of the project')
        stringParam("REPOSITORY_URL", '', 'Name of the git repository')
        credentialsParam("CREDENTIALS_ID") {
            type('com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey')
            description('SSH Key for deploying build artifacts')
        }
    }
    steps {
        dsl {
            text('''
            freeStyleJob("/Projects/$PROJECT_NAME") {
                scm {
                    git {
                        remote {
                            name("origin")
                            url("$REPOSITORY_URL")
                            credentials("$CREDENTIALS_ID")
                        }
                        branch("*/main")
                    }
                }
                triggers {
                    scm("* * * * *")
                }
                steps {
                    shell("docker build -t $PROJECT_NAME .")
                    shell("if [[ -f whanos.yml ]] then; kubectl apply -f whanos.yml; fi")
                }
            }''')
        }
    }
}
