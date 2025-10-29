# Buld docker file from current director: docker build -t app_name:tag_name . 
        ==> Here .(dot) mean where this specified file located
# Build docker specific docker file: docker build -t app_name:tag_name -f ./v1.Dockerfile . 
        ==> Here .(dot) mean where this specified file located

# Check files and directories in interactive mode:
        ===> docker run --rm -it app_name:tag_name sh --> "sh" because, some base images does not support bash. if need bash  need to install and then use. check "Dockerfile"
        --> --rm tag ensures that the container will be removed from device when it's stopped and it's all necessary logs will be removed from device and no memory will be used


# run requirements file without cache:
        ===> RUN pip install --no-cache-dir -r ./app/requirements.txt --> --no-cache-dir always re-run the requirements.txt file and newly install all dependencies
