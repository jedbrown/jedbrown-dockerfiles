mpich:
	docker build -t jedbrown/mpich --build-arg BASE_IMAGE=ubuntu mpich

mpich-cuda:
	docker build -t jedbrown/mpich-cuda --build-arg BASE_IMAGE=nvidia/cuda mpich

petsc:
	docker build -t jedbrown/petsc petsc

petsc-root:
	docker build -t jedbrown/petsc-root petsc-root

fenics:
	docker build -t jedbrown/fenics fenics

push:
	docker push jedbrown/mpich jedbrown/petsc jedbrown/petsc-root jedbrown/fenics

.PHONY: mpich petsc petsc-root fenics push
