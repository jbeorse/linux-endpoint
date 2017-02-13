To build the image run the following command inside the root directory:
"docker build -t <orgname>/linux_endpoint ."

After it finished building, it can be run with the following command:
"docker run --rm -it -p 8080:8080 <orgname>/linux_endpoint"

