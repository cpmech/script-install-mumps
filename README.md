# Script to install METIS and MUMPS

The script `install-mumps.bash` builds both static and **dynamic** libraries for the MUMPS sparse solver. The script offers an option to use the Intel compilers.

The script downloads MUMPS' source code from the Debian repository, compiles the code and installs the headers to `/usr/local/include/mumps` and the libraries (static and **dynamic**) to `/usr/local/lib/mumps`. The intel libraries have the suffix `_intel`.

This project also offers a script to download and compile {Par}METIS.

You may build a Docker image or run the script directly in an Ubuntu/Linux system. The docker image is quite convenient for use with Visual Code remote development tools.

## Docker Image

We can build the Docker image by running:

```bash
bash build-docker-image.bash {ON,[OFF]}
```

where the {ON,OFF} option tells the script to use the Intel tools or not. The default is OFF (gcc+OpenBlas+OpenMPI).

Open the terminal in a temporary Docker container:

```bash
docker run --rm -it mumps /bin/bash
# or
docker run --rm -it mumps_intel /bin/bash
```

Alternatively, see [Visual Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview). First, create a directory and copy the `.devcontainer` directory into it.

Then, open your project folder (e.g. this repo folder) in Visual Studio Code and click the green button at the window's left-bottom corner. Choose _Reopen in Container_.

![](vscode-open-in-container.gif)

If you want to debug using VS Code, copy the `.vscode` directory to your project and modify as appropriate. See the example below of how convenient it is to use VS Code for debugging the code.

![](Script_Install_MUMPS_1.gif)

## Ubuntu/Linux 20.10

### Install dependencies

See file [install-deps.bash](https://github.com/cpmech/script-install-mumps/blob/main/install-deps.bash)

### Compile and install MUMPS on Ubuntu

Use the following scripts:

1. `install-metis.bash {ON,OFF}` to install {Par}METIS, with Intel or not
2. `install-mumps.bash {ON,OFF}` to install MUMPS, with Intel or not

or use: `all.bash {ON,OFF}` to install {Par}METIS and MUMPS, with Intel or not.

### Remove include and library files on Ubuntu:

Use the following scripts:

1. `uninstall-metis.bash`
1. `uninstall-mumps.bash`
