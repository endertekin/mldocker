# tf_jupyter
Docker container for machine learning, runs jupyter notebook & tensorflow

## Building
Simply clone the repo, and run `./build.sh` to build a container that is automatically tagged with the branch name. To also build the gpu version, run `./build.sh -g`. The GPU version is built from `Dockerfile_gpu`.

The automatic builds for branch _master_ can be found on Dockerhub as `aviatr/tf_jupyter:latest` and `aviatr/tf_jupyter:gpu`. For other branches, the auto-builds are tagged as `aviatr/tf_jupyter:<branchname>` and `aviatr/tf_jupyter:gpu-<branchname>`.

## Using the containers
By default, the container runs jupyter notebook on port 8888, and can be launched simply by running the `./run.sh` script. To use the nvidia-gpu runtime, you can pass the `-g` option, and to use a different tag other than _master_, you can use the `-t <tagname>` option. For more info, run `./run.sh -h`.

If you would like to put this in the cloud somewhere, create a _private_ folder, and replace the sha-1 hashed password in pwd.txt file (currently _password_) with your own password. Furthermore, add your ssl keys underneath _private_. You can then launch the container with the script `./run.sh` which will mount the _private_ folder in the docker container where the jupyter notebook expects to find them, and also passes your password to the jupyter notebook.

## Acknowledgements:
[Dark theme for Jupyter Notebook/iPython 4](https://github.com/powerpak/jupyter-dark-theme) is created by Theodore Pak.
