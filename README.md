# mlengine
Docker containers for machine learning and computer vision. For a good tutorial to Docker, please check out [this link](https://docker-curriculum.com).

## Building
Simply clone the repo, and run `./build.sh <image_name>` to build a container that is automatically tagged with the branch name. The available images are:

* jupyter: a basic jupyter notebook environment with python 3.7
* opencv: OpenCV Computer Vision library + python bindings + jupyter notebook
* pytorch: jupyter notebook + pytorch
* tensorflow: jupyter notebook + tensorflow

The automatic builds for branch _master_ can be found on [Dockerhub](https://hub.docker.com) as `endertekin/<image_name>:latest`. For other branches, the auto-builds are tagged as `endertekin/<image_name>:<branchname>`.

## Using Jupyter notebook
By default, all containers run jupyter notebook on port 8888, and can be launched simply by running the `./run.sh` script. To use the nvidia-gpu runtime, you can pass the `-g` option, and to use a different tag other than _latest_, you can use the `-t <tagname>` option. For more info, run `./run.sh -h`.

To stop and remove the container when done, type `docker stop mlengine`. 
### Configuration
Jupyter configuration files are found under the `jupyter_cfg` folder, please copy this folder to your work folder if you will be using Jupyter notebooks. 

*Visuals:* I prefer a dark theme, so the settings for that are in the `jupyter_cfg/custom/custom.css` file, feel free to adjust it to your liking or just remove it for default settings. 

*Acknowledgements*: [Dark theme for Jupyter Notebook/iPython 4](https://github.com/powerpak/jupyter-dark-theme) is created by Theodore Pak.

#### Security
If you would like to put this in the cloud somewhere, or for general security purposes, it is recommended to 1) password protect your notebook server, and 2) use ssl. Based on the instructions here](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#notebook-server-security), the first thing to do is to protect the notebook with a password. To do this, you can use the `generate_jupyter_password.sh` script in the `helpers` subfolder. The container will assume that all secrets are contained within a folder called `private`, so first create this folder, assuming you're in the root folder that you cloned the github repo to

```mkdir private
./generate_jupyter_password.sh <password>
mv pwd.txt private
```

where `<password>` is the password you choose. This will save the sha-1 hashed password in `private/pwd.txt`.

The configuration file `jupyter_cfg/jupyter_notebook_config.py` contains the settings for which port that the jupyter notebook will run on, as well as the SSL certificates, which I highly recommend especially if you'll be running this in the cloud. To do this, we need to generate and add ssl keys underneath `private`. To generate an _unsigned_ ssl certificate & key, on the command line, type:

```openssl req -x509 -newkey rsa:4096 -nodes -keyout private/key.pem -out private/cert.pem -days 365
```

You can then launch the container with the script `./run.sh <imagename>` which will mount the `private` folder in the docker container where the jupyter notebook expects to find it. Your browser wil llikely complain that it cannot verify your credentials, as they have not been signed by a certificate authority. You can either ignore this warning and tell your browser to trust these certificates, or use an official CA such as [Let's Encrypt](https://letsencrypt.org) to get signed SSL certificates from.

## Using the images without jupyter notebook
Note that while all images contain jupyter notebook, it may not be necessary for your workflow to use jupyter. You can use standard python scripts for your training and inference needs via these images without launching jupyter at all. Assuming your code is in a folder called `<my_code_dir>`

```cp run_script.sh <my_code_dir>
cd <my_code_dir>
./run_script.sh <image_name> <scriptname>
```

where `<scriptname>` is the script you use for training, testing, inference etc. This will spin up a Docker container named `mlengine` from a Docker image `<image_name>`, though you can change that by passing the `-c <container_name>` option to `run_script.sh`. Note that this assumes all the resources, data, etc. are contained under the `my_code_dir` folder. You can also examine the `generate_jupyter_password.sh` script, which does something similar, namely launches the container to run a python script called `generate_password.py`.

Once your script is done running, the docker container will stop and remove itself automatically.
## Debugging
It is recommended to write the logs to a file that you can examine during runtime. The outputs from your job that go to stdout/stderr can also be examined by running
```docker logs <container_name>
```

If there's anything you manually need to change, you can also _log on_ to a *running* container by
```docker exec -ti <container_name> /bin/bash
```

Note that the containers are removed once their jobs are complete. This also erases their logs. If you do not want the containers to be removed and would rather remove them yourself by using `docker rm`, then pass the `--no-remove` option to `run_script.sh`