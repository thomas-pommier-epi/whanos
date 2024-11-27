folder('Projects') {
    description('Folder for all projects.')
    displayName('Projects')
}

folder('/TEST Whanos base images') {
    description('Folder for testing Whanos base images.')
    displayName('TEST Whanos base images')
}

// Build all base images
freeStyleJob('/TEST Whanos base images/Build all base images') {
    publishers {
        downstream('whanos-c', 'SUCCESS')
        downstream('whanos-javascript', 'SUCCESS')
        downstream('whanos-java', 'SUCCESS')
        downstream('whanos-befunge', 'SUCCESS')
        downstream('whanos-python', 'SUCCESS')
    }
}

// C - Public github repository
freeStyleJob('/TEST Whanos base images/whanos-c') {
    scm {
        git {
            remote {
                name('origin')
                url('https://github.com/thomas-pommier-epi/whanos-c')
            }
            branch('*/main')
        }
    }
    triggers {
        // upstream('Build all base images, ', 'SUCCESS')
        scm('H/5 * * * *')
    }
}

// Javascript - Private github repository
freeStyleJob('/TEST Whanos base images/whanos-javascript') {
    scm {
        git {
            remote {
                name('origin')
                url('***REMOVED***')
            }
            branch('*/main')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
}

// Java - Public self-hosted repository
freeStyleJob('/TEST Whanos base images/whanos-java') {
    scm {
        git {
            remote {
                name('origin')
                url('http://***REMOVED***/whanos_user/whanos-java.git')
            }
            branch('*/main')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
}

// Befunge - Private self-hosted repository
freeStyleJob('/TEST Whanos base images/whanos-befunge') {
    scm {
        git {
            remote {
                name('origin')
                url('git@***REMOVED***:whanos_user/whanos-befunge.git')
                credentials('befunge-ssh') // Create globally the credentials of kind "SSH Username with private key" with "Private key" to "Enter directly" and "Key" to the ssh private key. Put "ID" to "befunge-ssh" and "Username" to "befunge-ssh".
            }
            branch('*/main')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
}

// Python - Public gitlab repository
freeStyleJob('/TEST Whanos base images/whanos-python') {
    scm {
        git {
            remote {
                name('origin')
                url('https://gitlab.com/thomas-pommier-epi/whanos-python.git')
            }
            branch('*/main')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
}

freeStyleJob('/link-project') {
    parameters {
        stringParam("PROJECT_NAME", '', 'Name of the project')
        stringParam("REPOSITORY_URL", '', 'Name of the git repository')
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
                        }
                        branch("*/main")
                    }
                }
                triggers {
                    scm("* * * * *")
                }
                steps {
                    shell("docker build -t $PROJECT_NAME .")
                    shell("kubectl apply -f deployment.yaml")
                }
            }''')
        }
    }
}
