// Create the folder for the base images
folder('/Whanos base images') {
    description('Folder for testing Whanos base images.')
    displayName('Whanos base images')
}

// Build all base images
freeStyleJob('/Whanos base images/Build all base images') {
    publishers {
        downstream('whanos-c', 'SUCCESS')
        downstream('whanos-javascript', 'SUCCESS')
        downstream('whanos-java', 'SUCCESS')
        downstream('whanos-befunge', 'SUCCESS')
        downstream('whanos-python', 'SUCCESS')
        // FOR DEV: add a new image (e.g: Rust)
        // downstream('whanos-rust', 'SUCCESS')
    }
}

// C - Public github repository
freeStyleJob('/Whanos base images/whanos-c') {
    steps {
        shell('docker build -t whanos-c - < /opt/docker-base-images/c/Dockerfile.base')
    }
}

// Javascript - Private github repository
freeStyleJob('/Whanos base images/whanos-javascript') {
    steps {
        shell('docker build -t whanos-javascript - < /opt/docker-base-images/javascript/Dockerfile.base')
    }
}

// Java - Public self-hosted repository
freeStyleJob('/Whanos base images/whanos-java') {
    steps {
        shell('docker build -t whanos-java - < /opt/docker-base-images/java/Dockerfile.base')
    }
}

// Befunge - Private self-hosted repository
freeStyleJob('/Whanos base images/whanos-befunge') {
    steps {
        shell('docker build -t whanos-befunge - < /opt/docker-base-images/befunge/Dockerfile.base')
    }
}

// Python - Public gitlab repository
freeStyleJob('/Whanos base images/whanos-python') {
    steps {
        shell('docker build -t whanos-python - < /opt/docker-base-images/python/Dockerfile.base')
    }
}

// FOR DEV: add a new image (e.g: Rust)
// freeStyleJob('/Whanos base images/whanos-rust') {
//     steps {
//         shell('docker build -t whanos-rust - < /opt/docker-base-images/rust/Dockerfile.base')
//     }
// }
