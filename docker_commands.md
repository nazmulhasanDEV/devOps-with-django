# Buld docker file from current director: 
        docker build -t image_name:tag_name . 
        ==> Here .(dot) mean where this specified file located

# Build docker specific docker file: docker build -t image_name:tag_name -f ./v1.Dockerfile . 
        ==> Here .(dot) mean where this specified file located

# run docker container: docker run --rm -p host_port:container_port image_name:image_tag
                        ==> docker run --rm -p 8000:8000 image_name:image_tag

# Check files and directories in interactive mode:
        ===> docker run --rm -it image_name:tag_name sh --> "sh" because, some base images does not support bash. if need bash  need to install and then use. check "Dockerfile"
        --> --rm tag ensures that the container will be removed from device when it's stopped and it's all necessary logs will be removed from device and no memory will be used

        ==> docker exec -it container_id bash 
        if any image support bash

# run requirements file without cache:
        ===> RUN pip install --no-cache-dir -r ./app/requirements.txt --> --no-cache-dir always re-run the requirements.txt file and newly install all dependencies


# cache dependencies inside pip:
        ===> RUN --mount=type=cache,target=/root/.cache/pip \ pip install --no-cache-dir -r ./app/requirements.txt
        
        --> --mount=type=cache,target=/root/.cache/pip
        
        Creates a cached directory shared across builds /root/.cache/pip is where pip stores downloaded wheels 
        So next build → pip uses cached wheels → faster rebuild
        No changes inside final image — cache is only used during build.


# run docker on mount using volume(JUST FOR CODE):
        ===> docker run --rm -p 8000:8000 -v ./app:/app_v1/app webapp:v2

        ===> updated form: docker run --rm -p 8000:8000 --mount type=bind,src=./app,dst=/app_v1/app webapp:v2

        --rm: ensure the container will get removed when server or container stopped
        -p 8000:8000: ensure port to port connection between host machin and docker
        
        -v ./app:/app_v1/app: -v meaning volume. and ensure local machine binding with docker   specific directory. Helps for developpment mode and reload in each changes on the mapped
        directory in local machine. For instance, if we make any changes in ""./app"" dir, then
        it will automatically work on docker.

        webapp:v2: is basically, container name and tag that we are going to run


# persist others data:
        ===> docker run --rm -p 8000:8000 --volume mycoolapp-data:/app myapp:v2
        it basically stores all data like database, or media files etc so that when we re-start container later, we can use stored data. Becasuse, when stop container, everything get removed includeing files like uploaded. So, basically persis those files using above command

# ===> tricky note: 
        sometimes, above volume command does not work. In this case, ensure that the working directory added to the file sharing list in docker => settings => resource => file sharing



### How to push docker build image to docker hub

# 1.  Build the local image
docker build -t myapp:latest .

# 2. Log in to Docker Hub
docker login

# 3. Tag it for your Docker Hub repo
docker tag myapp:latest nazmulh/myapp:latest

# 4. Push it to Docker Hub
docker push nazmulh/myapp:latest

# 6. Test by pulling it
docker pull nazmulh/myapp:latest

If we want to push latest changes with new version, we have to just change the tag name and push following the similar steps above.