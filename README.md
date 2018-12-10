# Dockerfiles for computational science

These are Dockerfiles for images that may be of interest to users of PETSc and
related libraries.  They are based on Ubuntu 18.10 (cosmic) and build MPICH-3.3
from source [as needed by NERSC's
Shifter](https://docs.nersc.gov/development/shifter/how-to-use/).  My images
have been built with support for FMA/AVX2 and contain all relevant build tools.
PETSc and FEniCS/Dolfin are built from Git branch 'master'.

* [jedbrown/petsc](https://cloud.docker.com/repository/docker/jedbrown/petsc)
* [jedbrown/fenics](https://cloud.docker.com/repository/docker/jedbrown/fenics)

## Usage via Shifter at NERSC

[Shifter](https://github.com/NERSC/shifter) is a container management system for
HPC facilities.  [Usage](https://docs.nersc.gov/development/shifter/how-to-use/)
is conceptually similar to `docker`, but with its own commands (which have
sensible defaults, thus tend to be cleaner).  Start by fetching an image:

    $ shifterimg pull docker:jedbrown/petsc:master

Enter the container (e.g., on a login node so you can build sources)

    $ shifter --image docker:jedbrown/petsc:master bash

This enters the image, but preserves your working directory (on the host system,
such as a Cori login node),

    $ pwd
    /global/homes/j/jedbrow
    $ head /etc/issue
    Ubuntu 18.10 \n \l

You can build your own software in this environment, following any usual build
procedure.  You might want to extend my images if you need other libraries.  You
can also build software provided by the image.  For example, build using the
PETSc example sources installed in the image:

    make -f $PETSC_DIR/share/petsc/examples/gmakefile.test TESTDIR=test test/snes/examples/tutorials/ex5

Check that it works:

    mpiexec -n 2 test/snes/examples/tutorials/ex5 -snes_monitor

*Never* run significant parallel jobs in this mode!  To do any significant
computation (with or without MPI), you'll create a SLURM batch submission
script,

    #!/bin/bash
    
    #SBATCH --image=docker:jedbrown/petsc:master
    #SBATCH --nodes=2
    #SBATCH --qos=debug
    #SBATCH -C haswell
    
    srun -n 64 shifter test/snes/examples/tutorials/ex5 -snes_monitor -da_grid_x 100 -da_grid_y 200

Shifter uses `LD_LIBRARY_PATH` behind the scenes to route MPICH traffic from
your container over the Cray Aries network.  If you're building your own code,
you should avoid linking to MPI using RPATH.  The `chrpath` tool is available
inside these images and can be used to clean up after a build system that
insists on using RPATH.

You can also use [run interactively](https://docs.nersc.gov/jobs/interactive/)
using `salloc`, then (in the interactive session) use `srun` as above.

## Extending these images

To build other libraries as an extension to these images, create your own
Dockerfile and start with

    FROM jedbrown/petsc:master
    USER root

then install your software (avoiding RPATH, as mentioned above).  Ensure that
there exists a user account (Shifter disallows root).  See the [FEniCS
Dockerfile](fenics/Dockerfile) for an example, and consider [Dockerfile best
practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).
When developing a Dockerfile, I find it helpful to use separate `RUN` lines
(each of which creates a new cached layer) to work through incremental
configuration/build failures.  This produces a large image (because every layer
is stored), so I then squash build sequences into a single `RUN`.

If you are building on a host that is very different from the compute node
architecture, you may want/need to set `-march` appropriately.  (This might
involve rebuilding my images for your architecture.)
