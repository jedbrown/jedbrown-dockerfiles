UBUNTU ?= ubuntu:latest
MPICH ?= jedbrown/mpich:latest

mpich:
	docker build -t jedbrown/mpich --build-arg BASE_IMAGE=$(UBUNTU) mpich

mpich-sock:
	docker build -t jedbrown/mpich:sock --build-arg BASE_IMAGE=$(UBUNTU) --build-arg MPICH_DEVICE=ch3:sock mpich

mpich-ccache:
	docker build -t jedbrown/mpich-ccache --build-arg BASE_IMAGE=jedbrown/mpich:sock mpich-ccache

mpich-cuda:
	docker build -t jedbrown/mpich-cuda --build-arg BASE_IMAGE=nvidia/cuda mpich

petsc:
	docker build -t jedbrown/petsc --build-arg BASE_IMAGE=$(MPICH) petsc

petsc-root:
	docker build -t jedbrown/petsc-root petsc-root

fenics:
	docker build -t jedbrown/fenics fenics

push:
	docker push jedbrown/mpich jedbrown/petsc jedbrown/petsc-root jedbrown/fenics

.PHONY: mpich petsc petsc-root fenics push
