# mlengine
Docker containers for machine learning and computer vision. For a good tutorial to Docker, please check out [this link](https://docker-curriculum.com).

## Building
Simply clone the repo, and run `./build.sh <image_name>` to build a container that is automatically tagged with the branch name. The available images are:

* jupyter: a basic jupyter notebook environment with python 3.7
* opencv: OpenCV Computer Vision library + python bindings + jupyter notebook
* pytorch: jupyter notebook + pytorch
* tensorflow: jupyter notebook + tensorflow

The automatic builds for branch _master_ can be found on [Dockerhub](https://hub.docker.com) as `endertekin/<image_name>:latest`. For other branches, the auto-builds are tagged as `endertekin/<image_name>:<branchname>`.


## Using the images without jupyter notebook
Note that while all images contain jupyter notebook, it may not be necessary for your workflow to use jupyter. You can use standard python scripts for your training and inference needs via these images without launching jupyter at all. Assuming your code is in a folder called `<my_code_dir>`

```
cp run_script.sh <my_code_dir>
cd <my_code_dir>
./run_script.sh <image_name> <scriptname>
```

where `<scriptname>` is the script you use for training, testing, inference etc. This will spin up a Docker container named `mlengine` from a Docker image `<image_name>`, though you can change that by passing the `-c <container_name>` option to `run_script.sh`. Note that this assumes all the resources, data, etc. are contained under the `my_code_dir` folder. You can also examine the `secure_juypter_notebook.sh` script, which does something similar, namely launches the container to run a python script called `generate_password.py`.

Once your script is done running, the docker container will stop and remove itself automatically.

## Securing the notebook
The jupyter notebook requires a password, and connections default to https. To do this, you need to create a hashed password file, the ssl certificate and private key, and put them in athe `private` folder. You can follow the insturctions [here](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html), or use the provided utility `./secure_juypter_notebook.sh <password>` to create these files.

## Debugging
It is recommended to write the logs to a file that you can examine during runtime. The outputs from your job that go to stdout/stderr can also be examined by running
```
docker logs <container_name>
```

If there's anything you manually need to change, you can also _log on_ to a *running* container by
```
docker exec -ti <container_name> /bin/bash
```

Note that the containers are removed once their jobs are complete. This also erases their logs. If you do not want the containers to be removed and would rather remove them yourself by using `docker rm`, then pass the `--no-remove` option to `run_script.sh`